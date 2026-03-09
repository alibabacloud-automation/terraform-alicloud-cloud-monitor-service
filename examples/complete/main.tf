# Provider configuration
provider "alicloud" {
  region = var.region
}

# Data sources for existing resources
data "alicloud_zones" "default" {
  available_resource_creation = "Instance"
}

data "alicloud_instance_types" "default" {
  availability_zone = data.alicloud_zones.default.zones[0].id
  cpu_core_count    = 1
  memory_size       = 2
}

data "alicloud_images" "default" {
  name_regex = "^ubuntu_18_04_x64*"
  owners     = "system"
}

# Create VPC and related resources for demonstration
resource "alicloud_vpc" "example" {
  vpc_name   = "${var.name}-vpc"
  cidr_block = "10.0.0.0/16"
}

resource "alicloud_vswitch" "example" {
  vpc_id       = alicloud_vpc.example.id
  cidr_block   = "10.0.1.0/24"
  zone_id      = data.alicloud_zones.default.zones[0].id
  vswitch_name = "${var.name}-vswitch"
}

resource "alicloud_security_group" "example" {
  security_group_name = "${var.name}-sg"
  vpc_id              = alicloud_vpc.example.id
}

resource "alicloud_instance" "example" {
  availability_zone    = data.alicloud_zones.default.zones[0].id
  instance_name        = "${var.name}-instance"
  image_id             = data.alicloud_images.default.images[0].id
  instance_type        = data.alicloud_instance_types.default.instance_types[0].id
  security_groups      = [alicloud_security_group.example.id]
  vswitch_id           = alicloud_vswitch.example.id
  system_disk_category = "cloud_efficiency"
}

# Create Log Service resources for SLS monitoring
resource "random_uuid" "example" {}

resource "alicloud_log_project" "example" {
  project_name = substr("${var.name}-${replace(random_uuid.example.result, "-", "")}", 0, 16)
}

resource "alicloud_log_store" "example" {
  project_name          = alicloud_log_project.example.project_name
  logstore_name         = "${var.name}-logstore"
  shard_count           = 3
  auto_split            = true
  max_split_shard_count = 60
  append_meta           = true
}

# Cloud Monitor Service Module
module "cloud_monitor_service" {
  source = "../../"

  # Basic service configuration
  create_basic_public      = var.create_basic_public
  create_enterprise_public = var.create_enterprise_public

  # Namespace configuration
  create_namespace = var.create_namespace
  namespace_config = {
    namespace     = var.namespace_name
    specification = var.namespace_specification
    description   = "Cloud Monitor Service namespace for ${var.name}"
  }

  # Alarm contact group configuration
  create_alarm_contact_group = var.create_alarm_contact_group
  alarm_contact_group_config = {
    alarm_contact_group_name = var.name
    describe                 = var.name
  }

  # Monitor group configuration
  create_monitor_group = var.create_monitor_group
  monitor_group_config = {
    monitor_group_name = var.name
    contact_groups     = [var.name]
  }

  # Monitor group instances
  create_monitor_group_instances = var.create_monitor_group_instances
  monitor_group_instances_config = [
    {
      instance_id   = alicloud_instance.example.id
      instance_name = alicloud_instance.example.instance_name
      region_id     = var.region
      category      = "ecs"
    },
    {
      instance_id   = alicloud_vpc.example.id
      instance_name = alicloud_vpc.example.vpc_name
      region_id     = var.region
      category      = "vpc"
    }
  ]

  # Alarms configuration
  alarms_config = {
    ecs_cpu_alarm = {
      name           = var.name
      project        = "acs_ecs_dashboard"
      metric         = "CPUUtilization"
      contact_groups = [var.name]
      metric_dimensions = jsonencode([
        {
          instanceId = alicloud_instance.example.id
        }
      ])
      escalations_critical = {
        statistics          = "Average"
        comparison_operator = ">"
        threshold           = "80"
        times               = 3
      }
    }
  }

  # Site monitors configuration
  site_monitors_config = {
    website_monitor = {
      address   = var.monitor_website_url
      task_name = "${var.name}-website-monitor"
      task_type = "HTTP"
      interval  = 5
      isp_cities = [
        {
          city = "546"
          isp  = "465"
          type = "IDC"
        }
      ]
      option_json = {
        timeout = 10000
        assertions = [
          {
            operator = "lessThan"
            target   = "3000"
            type     = "response_time"
          }
        ]
      }
    }
  }

  # SLS groups configuration
  sls_groups_config = {
    sls_group = {
      sls_group_name        = "sls_group"
      sls_group_description = "SLS group for ${var.name}"
      sls_group_config = [
        {
          sls_logstore = alicloud_log_store.example.logstore_name
          sls_project  = alicloud_log_project.example.project_name
          sls_region   = var.region
        }
      ]
    }
  }

  # Hybrid monitor SLS tasks configuration - temporarily disabled due to SLS group dependency issue
  # hybrid_monitor_sls_tasks_config = {
  #   sls_task = {
  #     task_name           = "sls_task"
  #     description         = "SLS monitoring task for ${var.name}"
  #     collect_target_type = "sls_group"
  #     sls_process_config = {
  #       statistics = [
  #         {
  #           function     = "count"
  #           alias        = "request_count"
  #           sls_key_name = "status"
  #         }
  #       ]
  #     }
  #   }
  # }
  hybrid_monitor_sls_tasks_config = {}

  # Tags
  tags = var.tags
}