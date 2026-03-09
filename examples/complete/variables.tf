variable "region" {
  description = "The Alibaba Cloud region to deploy resources in"
  type        = string
  default     = "cn-shanghai"
}

variable "name" {
  description = "Name prefix for all resources"
  type        = string
  default     = "cms-example"
}

variable "create_basic_public" {
  description = "Whether to create Cloud Monitor Service Basic Public"
  type        = bool
  default     = false
}

variable "create_enterprise_public" {
  description = "Whether to create Cloud Monitor Service Enterprise Public"
  type        = bool
  default     = false
}

variable "create_namespace" {
  description = "Whether to create a new CMS namespace"
  type        = bool
  default     = true
}

variable "namespace_name" {
  description = "The name of the CMS namespace"
  type        = string
  default     = "cms-example-namespace"
}

variable "namespace_specification" {
  description = "The specification of the CMS namespace"
  type        = string
  default     = "cms.s1.large"
}

variable "create_alarm_contact_group" {
  description = "Whether to create a new alarm contact group"
  type        = bool
  default     = true
}

variable "create_monitor_group" {
  description = "Whether to create a new monitor group"
  type        = bool
  default     = true
}

variable "create_monitor_group_instances" {
  description = "Whether to create monitor group instances"
  type        = bool
  default     = true
}

variable "monitor_website_url" {
  description = "Website URL to monitor"
  type        = string
  default     = "https://www.alibabacloud.com"
}

variable "tags" {
  description = "A mapping of tags to assign to the resources"
  type        = map(string)
  default = {
    Environment = "example"
    Project     = "cloud-monitor-service"
    ManagedBy   = "Terraform"
  }
}