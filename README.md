Alibaba Cloud Monitor Service Terraform Module

# terraform-alicloud-cloud-monitor-service

English | [简体中文](https://github.com/alibabacloud-automation/terraform-alicloud-cloud-monitor-service/blob/main/README-CN.md)

Terraform module which creates comprehensive Cloud Monitor Service (CMS) resources on Alibaba Cloud. This module enables [efficient monitoring and alerting for cloud resources](https://www.alibabacloud.com/help/en/cms/product-overview/what-is-cloudmonitor), providing a complete solution for monitoring infrastructure, applications, and custom metrics across your Alibaba Cloud environment.

## Usage

This module provides a complete Cloud Monitor Service setup including namespaces, alarm management, monitor groups, site monitoring, and hybrid monitoring capabilities. You can use it to establish comprehensive monitoring for your cloud infrastructure.

```terraform
module "cloud_monitor_service" {
  source = "alibabacloud-automation/cloud-monitor-service/alicloud"

  # Namespace configuration
  create_namespace = true
  namespace_config = {
    namespace     = "my-monitoring-namespace"
    specification = "cms.s1.large"
    description   = "Monitoring namespace for my application"
  }

  # Alarm contact group configuration
  create_alarm_contact_group = true
  alarm_contact_group_config = {
    alarm_contact_group_name = "my-contact-group"
    describe                 = "Primary contact group for alerts"
    enable_subscribed        = true
  }

  # Monitor group configuration
  create_monitor_group = true
  monitor_group_config = {
    monitor_group_name = "my-monitor-group"
    contact_groups     = ["my-contact-group"]
  }

  # Alarm configuration
  alarms_config = {
    cpu_alarm = {
      name           = "high-cpu-usage"
      project        = "acs_ecs_dashboard"
      metric         = "CPUUtilization"
      contact_groups = ["my-contact-group"]
      escalations_critical = {
        statistics          = "Average"
        comparison_operator = ">"
        threshold           = "80"
        times               = 3
      }
    }
  }

  # Site monitoring configuration
  site_monitors_config = {
    website_monitor = {
      address   = "https://www.example.com"
      task_name = "website-availability"
      task_type = "HTTP"
      interval  = 5
      isp_cities = [
        {
          city = "546"
          isp  = "465"
          type = "IDC"
        }
      ]
    }
  }

  tags = {
    Environment = "production"
    Project     = "monitoring"
  }
}
```

## Examples

* [Complete Example](https://github.com/alibabacloud-automation/terraform-alicloud-cloud-monitor-service/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->

## Submit Issues

If you have any problems when using this module, please opening
a [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend opening an issue on this repo.

## Authors

Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com).

## License

MIT Licensed. See LICENSE for full details.

## Reference

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)