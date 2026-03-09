# Basic Public Service
output "basic_public_id" {
  description = "The ID of the Cloud Monitor Service Basic Public"
  value       = var.create_basic_public ? alicloud_cloud_monitor_service_basic_public.basic_public[0].id : null
}

output "basic_public_create_time" {
  description = "The creation time of the Cloud Monitor Service Basic Public"
  value       = var.create_basic_public ? alicloud_cloud_monitor_service_basic_public.basic_public[0].create_time : null
}

# Enterprise Public Service
output "enterprise_public_id" {
  description = "The ID of the Cloud Monitor Service Enterprise Public"
  value       = var.create_enterprise_public ? alicloud_cloud_monitor_service_enterprise_public.enterprise_public[0].id : null
}

output "enterprise_public_create_time" {
  description = "The creation time of the Cloud Monitor Service Enterprise Public"
  value       = var.create_enterprise_public ? alicloud_cloud_monitor_service_enterprise_public.enterprise_public[0].create_time : null
}

# Namespace
output "namespace_id" {
  description = "The ID of the CMS namespace"
  value       = local.this_namespace_id
}

output "namespace_specification" {
  description = "The specification of the CMS namespace"
  value       = var.create_namespace ? alicloud_cms_namespace.namespace[0].specification : null
}

# Alarm Contact Group
output "alarm_contact_group_id" {
  description = "The ID of the alarm contact group"
  value       = var.create_alarm_contact_group ? alicloud_cms_alarm_contact_group.contact_group[0].id : var.alarm_contact_group_id
}

output "alarm_contact_group_name" {
  description = "The name of the alarm contact group"
  value       = var.create_alarm_contact_group ? alicloud_cms_alarm_contact_group.contact_group[0].alarm_contact_group_name : null
}

# Alarm Contacts
output "alarm_contacts" {
  description = "The alarm contacts information"
  value = {
    for k, v in alicloud_cms_alarm_contact.contacts : k => {
      id                 = v.id
      alarm_contact_name = v.alarm_contact_name
      describe           = v.describe
    }
  }
}

# Monitor Group
output "monitor_group_id" {
  description = "The ID of the monitor group"
  value       = local.this_monitor_group_id
}

output "monitor_group_name" {
  description = "The name of the monitor group"
  value       = var.create_monitor_group ? alicloud_cms_monitor_group.group[0].monitor_group_name : null
}

# Monitor Group Instances
output "monitor_group_instances_id" {
  description = "The ID of the monitor group instances"
  value       = var.create_monitor_group_instances ? alicloud_cms_monitor_group_instances.group_instances[0].id : null
}

# Alarms
output "alarms" {
  description = "The CMS alarms information"
  value = {
    for k, v in alicloud_cms_alarm.alarms : k => {
      id     = v.id
      name   = v.name
      status = v.status
    }
  }
}

# Group Metric Rules
output "group_metric_rules" {
  description = "The CMS group metric rules information"
  value = {
    for k, v in alicloud_cms_group_metric_rule.group_metric_rules : k => {
      id                     = v.id
      group_metric_rule_name = v.group_metric_rule_name
      status                 = v.status
    }
  }
}

# Event Rules
output "event_rules" {
  description = "The CMS event rules information"
  value = {
    for k, v in alicloud_cms_event_rule.event_rules : k => {
      id        = v.id
      rule_name = v.rule_name
      status    = v.status
    }
  }
}

# Site Monitors
output "site_monitors" {
  description = "The CMS site monitors information"
  value = {
    for k, v in alicloud_cms_site_monitor.site_monitors : k => {
      id        = v.id
      task_name = v.task_name
      status    = v.status
    }
  }
}

# Hybrid Monitor FC Tasks
output "hybrid_monitor_fc_tasks" {
  description = "The CMS hybrid monitor FC tasks information"
  value = {
    for k, v in alicloud_cms_hybrid_monitor_fc_task.fc_tasks : k => {
      id                        = v.id
      hybrid_monitor_fc_task_id = v.hybrid_monitor_fc_task_id
    }
  }
}

# Hybrid Monitor SLS Tasks
output "hybrid_monitor_sls_tasks" {
  description = "The CMS hybrid monitor SLS tasks information"
  value = {
    for k, v in alicloud_cms_hybrid_monitor_sls_task.sls_tasks : k => {
      id        = v.id
      task_name = v.task_name
    }
  }
}

# SLS Groups
output "sls_groups" {
  description = "The CMS SLS groups information"
  value = {
    for k, v in alicloud_cms_sls_group.sls_groups : k => {
      id             = v.id
      sls_group_name = v.sls_group_name
    }
  }
}

# Metric Rule Templates
output "metric_rule_templates" {
  description = "The CMS metric rule templates information"
  value = {
    for k, v in alicloud_cms_metric_rule_template.metric_rule_templates : k => {
      id                        = v.id
      metric_rule_template_name = v.metric_rule_template_name
      rest_version              = v.rest_version
    }
  }
}

# Dynamic Tag Groups
output "dynamic_tag_groups" {
  description = "The CMS dynamic tag groups information"
  value = {
    for k, v in alicloud_cms_dynamic_tag_group.dynamic_tag_groups : k => {
      id      = v.id
      tag_key = v.tag_key
      status  = v.status
    }
  }
}