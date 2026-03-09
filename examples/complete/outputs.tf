# VPC and network outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = alicloud_vpc.example.id
}

output "vswitch_id" {
  description = "The ID of the VSwitch"
  value       = alicloud_vswitch.example.id
}

output "instance_id" {
  description = "The ID of the ECS instance"
  value       = alicloud_instance.example.id
}

# Log Service outputs
output "log_project_name" {
  description = "The name of the Log Service project"
  value       = alicloud_log_project.example.project_name
}

output "log_store_name" {
  description = "The name of the Log Service logstore"
  value       = alicloud_log_store.example.logstore_name
}

# Cloud Monitor Service outputs
output "namespace_id" {
  description = "The ID of the CMS namespace"
  value       = module.cloud_monitor_service.namespace_id
}

output "monitor_group_id" {
  description = "The ID of the monitor group"
  value       = module.cloud_monitor_service.monitor_group_id
}

output "alarm_contact_group_id" {
  description = "The ID of the alarm contact group"
  value       = module.cloud_monitor_service.alarm_contact_group_id
}

output "alarms" {
  description = "The CMS alarms information"
  value       = module.cloud_monitor_service.alarms
}

output "site_monitors" {
  description = "The CMS site monitors information"
  value       = module.cloud_monitor_service.site_monitors
}

output "sls_groups" {
  description = "The CMS SLS groups information"
  value       = module.cloud_monitor_service.sls_groups
}

output "hybrid_monitor_sls_tasks" {
  description = "The CMS hybrid monitor SLS tasks information"
  value       = module.cloud_monitor_service.hybrid_monitor_sls_tasks
}