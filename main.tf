# Local variables for resource IDs and configurations
locals {
  # Monitor group ID - use created group or external group ID
  this_monitor_group_id = var.create_monitor_group ? alicloud_cms_monitor_group.group[0].id : var.monitor_group_id

  # Namespace ID - use created namespace or external namespace ID
  this_namespace_id = var.create_namespace ? alicloud_cms_namespace.namespace[0].id : var.namespace_id
}

# Cloud Monitor Service Basic Public
resource "alicloud_cloud_monitor_service_basic_public" "basic_public" {
  count = var.create_basic_public ? 1 : 0
}

# Cloud Monitor Service Enterprise Public  
resource "alicloud_cloud_monitor_service_enterprise_public" "enterprise_public" {
  count = var.create_enterprise_public ? 1 : 0
}

# CMS Namespace for hybrid monitoring
resource "alicloud_cms_namespace" "namespace" {
  count         = var.create_namespace ? 1 : 0
  namespace     = var.namespace_config.namespace
  specification = var.namespace_config.specification
  description   = var.namespace_config.description
}

# CMS Alarm Contact Group
resource "alicloud_cms_alarm_contact_group" "contact_group" {
  count                    = var.create_alarm_contact_group ? 1 : 0
  alarm_contact_group_name = var.alarm_contact_group_config.alarm_contact_group_name
  contacts                 = var.alarm_contact_group_config.contacts
  describe                 = var.alarm_contact_group_config.describe
  enable_subscribed        = var.alarm_contact_group_config.enable_subscribed
}

# CMS Alarm Contacts
resource "alicloud_cms_alarm_contact" "contacts" {
  for_each = var.alarm_contacts_config

  alarm_contact_name     = each.value.alarm_contact_name
  describe               = each.value.describe
  channels_mail          = each.value.channels_mail
  channels_sms           = each.value.channels_sms
  channels_ding_web_hook = each.value.channels_ding_web_hook
  channels_aliim         = each.value.channels_aliim
  lang                   = each.value.lang
}

# CMS Monitor Group
resource "alicloud_cms_monitor_group" "group" {
  count               = var.create_monitor_group ? 1 : 0
  monitor_group_name  = var.monitor_group_config.monitor_group_name
  contact_groups      = var.monitor_group_config.contact_groups
  resource_group_id   = var.monitor_group_config.resource_group_id
  resource_group_name = var.monitor_group_config.resource_group_name
  tags                = var.tags
}

# CMS Monitor Group Instances
resource "alicloud_cms_monitor_group_instances" "group_instances" {
  count    = var.create_monitor_group_instances ? 1 : 0
  group_id = local.this_monitor_group_id

  dynamic "instances" {
    for_each = var.monitor_group_instances_config
    content {
      instance_id   = instances.value.instance_id
      instance_name = instances.value.instance_name
      region_id     = instances.value.region_id
      category      = instances.value.category
    }
  }
}

# CMS Alarms
resource "alicloud_cms_alarm" "alarms" {
  for_each = var.alarms_config

  name               = each.value.name
  project            = each.value.project
  metric             = each.value.metric
  period             = each.value.period
  contact_groups     = each.value.contact_groups
  effective_interval = each.value.effective_interval
  metric_dimensions  = each.value.metric_dimensions
  silence_time       = each.value.silence_time
  webhook            = each.value.webhook
  enabled            = each.value.enabled

  dynamic "escalations_critical" {
    for_each = each.value.escalations_critical != null ? [each.value.escalations_critical] : []
    content {
      statistics          = escalations_critical.value.statistics
      comparison_operator = escalations_critical.value.comparison_operator
      threshold           = escalations_critical.value.threshold
      times               = escalations_critical.value.times
    }
  }

  dynamic "escalations_warn" {
    for_each = each.value.escalations_warn != null ? [each.value.escalations_warn] : []
    content {
      statistics          = escalations_warn.value.statistics
      comparison_operator = escalations_warn.value.comparison_operator
      threshold           = escalations_warn.value.threshold
      times               = escalations_warn.value.times
    }
  }

  dynamic "escalations_info" {
    for_each = each.value.escalations_info != null ? [each.value.escalations_info] : []
    content {
      statistics          = escalations_info.value.statistics
      comparison_operator = escalations_info.value.comparison_operator
      threshold           = escalations_info.value.threshold
      times               = escalations_info.value.times
    }
  }

  tags = var.tags
}

# CMS Group Metric Rules
resource "alicloud_cms_group_metric_rule" "group_metric_rules" {
  for_each = var.group_metric_rules_config

  group_id               = local.this_monitor_group_id
  group_metric_rule_name = each.value.group_metric_rule_name
  category               = each.value.category
  metric_name            = each.value.metric_name
  namespace              = each.value.namespace
  rule_id                = each.key
  period                 = each.value.period
  interval               = each.value.interval
  silence_time           = each.value.silence_time
  no_effective_interval  = each.value.no_effective_interval
  webhook                = each.value.webhook
  dimensions             = each.value.dimensions
  contact_groups         = each.value.contact_groups
  email_subject          = each.value.email_subject
  effective_interval     = each.value.effective_interval

  dynamic "escalations" {
    for_each = each.value.escalations != null ? [each.value.escalations] : []
    content {
      dynamic "critical" {
        for_each = escalations.value.critical != null ? [escalations.value.critical] : []
        content {
          comparison_operator = critical.value.comparison_operator
          statistics          = critical.value.statistics
          threshold           = critical.value.threshold
          times               = critical.value.times
        }
      }

      dynamic "warn" {
        for_each = escalations.value.warn != null ? [escalations.value.warn] : []
        content {
          comparison_operator = warn.value.comparison_operator
          statistics          = warn.value.statistics
          threshold           = warn.value.threshold
          times               = warn.value.times
        }
      }

      dynamic "info" {
        for_each = escalations.value.info != null ? [escalations.value.info] : []
        content {
          comparison_operator = info.value.comparison_operator
          statistics          = info.value.statistics
          threshold           = info.value.threshold
          times               = info.value.times
        }
      }
    }
  }
}

# CMS Event Rules
resource "alicloud_cms_event_rule" "event_rules" {
  for_each = var.event_rules_config

  rule_name    = each.value.rule_name
  group_id     = local.this_monitor_group_id
  silence_time = each.value.silence_time
  description  = each.value.description
  status       = each.value.status

  dynamic "event_pattern" {
    for_each = [each.value.event_pattern]
    content {
      product         = event_pattern.value.product
      sql_filter      = event_pattern.value.sql_filter
      name_list       = event_pattern.value.name_list
      level_list      = event_pattern.value.level_list
      event_type_list = event_pattern.value.event_type_list
    }
  }
}

# CMS Site Monitor
resource "alicloud_cms_site_monitor" "site_monitors" {
  for_each = var.site_monitors_config

  address   = each.value.address
  task_name = each.value.task_name
  task_type = each.value.task_type
  interval  = each.value.interval
  status    = each.value.status

  dynamic "isp_cities" {
    for_each = each.value.isp_cities
    content {
      city = isp_cities.value.city
      isp  = isp_cities.value.isp
      type = isp_cities.value.type
    }
  }

  dynamic "option_json" {
    for_each = each.value.option_json != null ? [each.value.option_json] : []
    content {
      response_content     = option_json.value.response_content
      expect_value         = option_json.value.expect_value
      port                 = option_json.value.port
      is_base_encode       = option_json.value.is_base_encode
      ping_num             = option_json.value.ping_num
      match_rule           = option_json.value.match_rule
      failure_rate         = option_json.value.failure_rate
      request_content      = option_json.value.request_content
      attempts             = option_json.value.attempts
      request_format       = option_json.value.request_format
      password             = option_json.value.password
      diagnosis_ping       = option_json.value.diagnosis_ping
      response_format      = option_json.value.response_format
      cookie               = option_json.value.cookie
      ping_port            = option_json.value.ping_port
      user_name            = option_json.value.user_name
      dns_match_rule       = option_json.value.dns_match_rule
      timeout              = option_json.value.timeout
      dns_server           = option_json.value.dns_server
      diagnosis_mtr        = option_json.value.diagnosis_mtr
      header               = option_json.value.header
      min_tls_version      = option_json.value.min_tls_version
      ping_type            = option_json.value.ping_type
      dns_type             = option_json.value.dns_type
      dns_hijack_whitelist = option_json.value.dns_hijack_whitelist
      http_method          = option_json.value.http_method

      dynamic "assertions" {
        for_each = option_json.value.assertions != null ? option_json.value.assertions : []
        content {
          operator = assertions.value.operator
          target   = assertions.value.target
          type     = assertions.value.type
        }
      }
    }
  }
}

# CMS Hybrid Monitor FC Task
resource "alicloud_cms_hybrid_monitor_fc_task" "fc_tasks" {
  for_each = var.hybrid_monitor_fc_tasks_config

  namespace      = local.this_namespace_id
  yarm_config    = each.value.yarm_config
  target_user_id = each.value.target_user_id
}

# CMS Hybrid Monitor SLS Task
resource "alicloud_cms_hybrid_monitor_sls_task" "sls_tasks" {
  for_each = var.hybrid_monitor_sls_tasks_config

  task_name           = each.value.task_name
  namespace           = local.this_namespace_id
  description         = each.value.description
  collect_interval    = each.value.collect_interval
  collect_target_type = each.value.collect_target_type

  dynamic "sls_process_config" {
    for_each = [each.value.sls_process_config]
    content {
      dynamic "filter" {
        for_each = sls_process_config.value.filter != null ? [sls_process_config.value.filter] : []
        content {
          relation = filter.value.relation

          dynamic "filters" {
            for_each = filter.value.filters
            content {
              operator     = filters.value.operator
              value        = filters.value.value
              sls_key_name = filters.value.sls_key_name
            }
          }
        }
      }

      dynamic "statistics" {
        for_each = sls_process_config.value.statistics != null ? sls_process_config.value.statistics : []
        content {
          function      = statistics.value.function
          alias         = statistics.value.alias
          sls_key_name  = statistics.value.sls_key_name
          parameter_one = statistics.value.parameter_one
          parameter_two = statistics.value.parameter_two
        }
      }

      dynamic "group_by" {
        for_each = sls_process_config.value.group_by != null ? sls_process_config.value.group_by : []
        content {
          alias        = group_by.value.alias
          sls_key_name = group_by.value.sls_key_name
        }
      }

      dynamic "express" {
        for_each = sls_process_config.value.express != null ? sls_process_config.value.express : []
        content {
          express = express.value.express
          alias   = express.value.alias
        }
      }
    }
  }

  dynamic "attach_labels" {
    for_each = each.value.attach_labels != null ? each.value.attach_labels : []
    content {
      name  = attach_labels.value.name
      value = attach_labels.value.value
    }
  }
}

# CMS SLS Group
resource "alicloud_cms_sls_group" "sls_groups" {
  for_each = var.sls_groups_config

  sls_group_name        = each.value.sls_group_name
  sls_group_description = each.value.sls_group_description

  dynamic "sls_group_config" {
    for_each = each.value.sls_group_config
    content {
      sls_user_id  = sls_group_config.value.sls_user_id
      sls_logstore = sls_group_config.value.sls_logstore
      sls_project  = sls_group_config.value.sls_project
      sls_region   = sls_group_config.value.sls_region
    }
  }
}

# CMS Metric Rule Template
resource "alicloud_cms_metric_rule_template" "metric_rule_templates" {
  for_each = var.metric_rule_templates_config

  metric_rule_template_name = each.value.metric_rule_template_name
  description               = each.value.description
  group_id                  = each.value.group_id
  apply_mode                = each.value.apply_mode
  notify_level              = each.value.notify_level
  silence_time              = each.value.silence_time
  webhook                   = each.value.webhook
  enable_start_time         = each.value.enable_start_time
  enable_end_time           = each.value.enable_end_time

  dynamic "alert_templates" {
    for_each = each.value.alert_templates != null ? each.value.alert_templates : []
    content {
      rule_name   = alert_templates.value.rule_name
      metric_name = alert_templates.value.metric_name
      namespace   = alert_templates.value.namespace
      category    = alert_templates.value.category
      webhook     = alert_templates.value.webhook

      dynamic "escalations" {
        for_each = alert_templates.value.escalations != null ? [alert_templates.value.escalations] : []
        content {
          dynamic "critical" {
            for_each = escalations.value.critical != null ? [escalations.value.critical] : []
            content {
              comparison_operator = critical.value.comparison_operator
              statistics          = critical.value.statistics
              threshold           = critical.value.threshold
              times               = critical.value.times
            }
          }

          dynamic "warn" {
            for_each = escalations.value.warn != null ? [escalations.value.warn] : []
            content {
              comparison_operator = warn.value.comparison_operator
              statistics          = warn.value.statistics
              threshold           = warn.value.threshold
              times               = warn.value.times
            }
          }

          dynamic "info" {
            for_each = escalations.value.info != null ? [escalations.value.info] : []
            content {
              comparison_operator = info.value.comparison_operator
              statistics          = info.value.statistics
              threshold           = info.value.threshold
              times               = info.value.times
            }
          }
        }
      }
    }
  }
}

# CMS Dynamic Tag Group
resource "alicloud_cms_dynamic_tag_group" "dynamic_tag_groups" {
  for_each = var.dynamic_tag_groups_config

  tag_key                       = each.value.tag_key
  match_express_filter_relation = each.value.match_express_filter_relation
  contact_group_list            = each.value.contact_group_list
  template_id_list              = each.value.template_id_list

  dynamic "match_express" {
    for_each = each.value.match_express
    content {
      tag_value                = match_express.value.tag_value
      tag_value_match_function = match_express.value.tag_value_match_function
    }
  }
}