# Common variables
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
  description = "Whether to create a new CMS namespace. If false, an existing namespace ID must be provided."
  type        = bool
  default     = true
}

variable "namespace_id" {
  description = "The ID of an existing CMS namespace. Required when create_namespace is false."
  type        = string
  default     = null
}

variable "namespace_config" {
  description = "The parameters of CMS namespace. The attribute 'namespace' is required."
  type = object({
    namespace     = string
    specification = optional(string, "cms.s1.3xlarge")
    description   = optional(string, null)
  })
  default = {
    namespace = null
  }
}

variable "create_alarm_contact_group" {
  description = "Whether to create a new alarm contact group. If false, an existing group ID must be provided."
  type        = bool
  default     = true
}

variable "alarm_contact_group_id" {
  description = "The ID of an existing alarm contact group. Required when create_alarm_contact_group is false."
  type        = string
  default     = null
}

variable "alarm_contact_group_config" {
  description = "The parameters of alarm contact group. The attribute 'alarm_contact_group_name' is required."
  type = object({
    alarm_contact_group_name = string
    contacts                 = optional(list(string), [])
    describe                 = optional(string, null)
    enable_subscribed        = optional(bool, false)
  })
  default = {
    alarm_contact_group_name = null
  }
}

variable "alarm_contacts_config" {
  description = "Configuration for alarm contacts."
  type = map(object({
    alarm_contact_name     = string
    describe               = string
    channels_mail          = optional(string, null)
    channels_sms           = optional(string, null)
    channels_ding_web_hook = optional(string, null)
    channels_aliim         = optional(string, null)
    lang                   = optional(string, "en")
  }))
  default = {}
}

variable "create_monitor_group" {
  description = "Whether to create a new monitor group. If false, an existing group ID must be provided."
  type        = bool
  default     = true
}

variable "monitor_group_id" {
  description = "The ID of an existing monitor group. Required when create_monitor_group is false."
  type        = string
  default     = null
}

variable "monitor_group_config" {
  description = "The parameters of monitor group. The attribute 'monitor_group_name' is required."
  type = object({
    monitor_group_name  = string
    contact_groups      = optional(list(string), [])
    resource_group_id   = optional(string, null)
    resource_group_name = optional(string, null)
  })
  default = {
    monitor_group_name = null
  }
}

variable "create_monitor_group_instances" {
  description = "Whether to create monitor group instances"
  type        = bool
  default     = false
}

variable "monitor_group_instances_config" {
  description = "Configuration for monitor group instances."
  type = list(object({
    instance_id   = string
    instance_name = string
    region_id     = string
    category      = string
  }))
  default = []
}

variable "alarms_config" {
  description = "Configuration for CMS alarms."
  type = map(object({
    name               = string
    project            = string
    metric             = string
    period             = optional(number, 300)
    contact_groups     = list(string)
    effective_interval = optional(string, "00:00-23:59")
    metric_dimensions  = optional(string, null)
    silence_time       = optional(number, 86400)
    webhook            = optional(string, null)
    enabled            = optional(bool, true)
    escalations_critical = optional(object({
      statistics          = string
      comparison_operator = string
      threshold           = string
      times               = number
    }), null)
    escalations_warn = optional(object({
      statistics          = string
      comparison_operator = string
      threshold           = string
      times               = number
    }), null)
    escalations_info = optional(object({
      statistics          = string
      comparison_operator = string
      threshold           = string
      times               = number
    }), null)
  }))
  default = {}
}

variable "group_metric_rules_config" {
  description = "Configuration for CMS group metric rules."
  type = map(object({
    group_metric_rule_name = string
    category               = string
    metric_name            = string
    namespace              = string
    period                 = optional(number, 300)
    interval               = optional(number, 3600)
    silence_time           = optional(number, 86400)
    no_effective_interval  = optional(string, null)
    webhook                = optional(string, null)
    dimensions             = optional(string, null)
    contact_groups         = optional(list(string), [])
    email_subject          = optional(string, null)
    effective_interval     = optional(string, null)
    escalations = optional(object({
      critical = optional(object({
        comparison_operator = string
        statistics          = string
        threshold           = string
        times               = number
      }), null)
      warn = optional(object({
        comparison_operator = string
        statistics          = string
        threshold           = string
        times               = number
      }), null)
      info = optional(object({
        comparison_operator = string
        statistics          = string
        threshold           = string
        times               = number
      }), null)
    }), null)
  }))
  default = {}
}

variable "event_rules_config" {
  description = "Configuration for CMS event rules."
  type = map(object({
    rule_name    = string
    silence_time = optional(number, 86400)
    description  = optional(string, null)
    status       = optional(string, "ENABLED")
    event_pattern = object({
      product         = string
      sql_filter      = optional(string, null)
      name_list       = optional(list(string), [])
      level_list      = optional(list(string), [])
      event_type_list = optional(list(string), [])
    })
  }))
  default = {}
}

variable "site_monitors_config" {
  description = "Configuration for CMS site monitors."
  type = map(object({
    address   = string
    task_name = string
    task_type = string
    interval  = optional(number, 1)
    status    = optional(string, "1")
    isp_cities = list(object({
      city = string
      isp  = string
      type = optional(string, "IDC")
    }))
    option_json = optional(object({
      response_content     = optional(string, null)
      expect_value         = optional(string, null)
      port                 = optional(number, null)
      is_base_encode       = optional(bool, false)
      ping_num             = optional(number, 5)
      match_rule           = optional(number, 0)
      failure_rate         = optional(string, null)
      request_content      = optional(string, null)
      attempts             = optional(number, 3)
      request_format       = optional(string, "text")
      password             = optional(string, null)
      diagnosis_ping       = optional(bool, false)
      response_format      = optional(string, "text")
      cookie               = optional(string, null)
      ping_port            = optional(number, null)
      user_name            = optional(string, null)
      dns_match_rule       = optional(string, null)
      timeout              = optional(number, 5000)
      dns_server           = optional(string, null)
      diagnosis_mtr        = optional(bool, false)
      header               = optional(string, null)
      min_tls_version      = optional(string, null)
      ping_type            = optional(string, "icmp")
      dns_type             = optional(string, "A")
      dns_hijack_whitelist = optional(string, null)
      http_method          = optional(string, "get")
      assertions = optional(list(object({
        operator = string
        target   = string
        type     = string
      })), [])
    }), null)
  }))
  default = {}
}

variable "hybrid_monitor_fc_tasks_config" {
  description = "Configuration for CMS hybrid monitor FC tasks."
  type = map(object({
    yarm_config    = string
    target_user_id = optional(string, null)
  }))
  default = {}
}

variable "hybrid_monitor_sls_tasks_config" {
  description = "Configuration for CMS hybrid monitor SLS tasks."
  type = map(object({
    task_name           = string
    description         = optional(string, null)
    collect_interval    = optional(number, 60)
    collect_target_type = string
    sls_process_config = object({
      filter = optional(object({
        relation = optional(string, "and")
        filters = list(object({
          operator     = string
          value        = string
          sls_key_name = string
        }))
      }), null)
      statistics = optional(list(object({
        function      = string
        alias         = string
        sls_key_name  = string
        parameter_one = optional(string, null)
        parameter_two = optional(string, null)
      })), [])
      group_by = optional(list(object({
        alias        = string
        sls_key_name = string
      })), [])
      express = optional(list(object({
        express = string
        alias   = string
      })), [])
    })
    attach_labels = optional(list(object({
      name  = string
      value = string
    })), [])
  }))
  default = {}
}

variable "sls_groups_config" {
  description = "Configuration for CMS SLS groups."
  type = map(object({
    sls_group_name        = string
    sls_group_description = optional(string, null)
    sls_group_config = list(object({
      sls_user_id  = optional(string, null)
      sls_logstore = string
      sls_project  = string
      sls_region   = string
    }))
  }))
  default = {}
}

variable "metric_rule_templates_config" {
  description = "Configuration for CMS metric rule templates."
  type = map(object({
    metric_rule_template_name = string
    description               = optional(string, null)
    group_id                  = optional(string, null)
    apply_mode                = optional(string, null)
    notify_level              = optional(number, null)
    silence_time              = optional(number, 86400)
    webhook                   = optional(string, null)
    enable_start_time         = optional(string, null)
    enable_end_time           = optional(string, null)
    alert_templates = optional(list(object({
      rule_name   = string
      metric_name = string
      namespace   = string
      category    = string
      webhook     = optional(string, null)
      escalations = optional(object({
        critical = optional(object({
          comparison_operator = string
          statistics          = string
          threshold           = string
          times               = string
        }), null)
        warn = optional(object({
          comparison_operator = string
          statistics          = string
          threshold           = string
          times               = string
        }), null)
        info = optional(object({
          comparison_operator = string
          statistics          = string
          threshold           = string
          times               = string
        }), null)
      }), null)
    })), [])
  }))
  default = {}
}

variable "dynamic_tag_groups_config" {
  description = "Configuration for CMS dynamic tag groups."
  type = map(object({
    tag_key                       = string
    match_express_filter_relation = optional(string, "and")
    contact_group_list            = list(string)
    template_id_list              = optional(list(string), [])
    match_express = list(object({
      tag_value                = string
      tag_value_match_function = string
    }))
  }))
  default = {}
}

variable "tags" {
  description = "A mapping of tags to assign to the resources"
  type        = map(string)
  default     = {}
}