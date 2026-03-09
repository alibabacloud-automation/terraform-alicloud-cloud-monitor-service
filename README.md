Alibaba Cloud Cloud Monitor Service Terraform Module

# terraform-alicloud-cloud-monitor-service

English | [简体中文](https://github.com/alibabacloud-automation/terraform-alicloud-cloud-monitor-service/blob/main/README-CN.md)

Terraform module which creates comprehensive Cloud Monitor Service (CMS) resources on Alibaba Cloud. This module enables [efficient monitoring and alerting for cloud resources](https://www.alibabacloud.com/help/en/cms/product-overview/what-is-cloudmonitor), providing a complete solution for monitoring infrastructure, applications, and custom metrics across your Alibaba Cloud environment.

## Usage

```terraform
module "cloud_monitor_service" {
  source = "alibabacloud-automation/cloud-monitor-service/alicloud"

  # Namespace configuration
  namespace_config = {
    namespace   = "my-monitoring-namespace"
    description = "Monitoring namespace for my application"
  }

  # Alarm contact group configuration
  alarm_contact_group_config = {
    alarm_contact_group_name = "my-contact-group"
    describe                 = "Primary contact group for alerts"
  }

  # Monitor group configuration
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
}
```

## Examples

* [Complete Example](https://github.com/alibabacloud-automation/terraform-alicloud-cloud-monitor-service/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.171.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.171.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_cloud_monitor_service_basic_public.basic_public](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cloud_monitor_service_basic_public) | resource |
| [alicloud_cloud_monitor_service_enterprise_public.enterprise_public](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cloud_monitor_service_enterprise_public) | resource |
| [alicloud_cms_alarm.alarms](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cms_alarm) | resource |
| [alicloud_cms_alarm_contact.contacts](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cms_alarm_contact) | resource |
| [alicloud_cms_alarm_contact_group.contact_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cms_alarm_contact_group) | resource |
| [alicloud_cms_dynamic_tag_group.dynamic_tag_groups](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cms_dynamic_tag_group) | resource |
| [alicloud_cms_event_rule.event_rules](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cms_event_rule) | resource |
| [alicloud_cms_group_metric_rule.group_metric_rules](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cms_group_metric_rule) | resource |
| [alicloud_cms_hybrid_monitor_fc_task.fc_tasks](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cms_hybrid_monitor_fc_task) | resource |
| [alicloud_cms_hybrid_monitor_sls_task.sls_tasks](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cms_hybrid_monitor_sls_task) | resource |
| [alicloud_cms_metric_rule_template.metric_rule_templates](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cms_metric_rule_template) | resource |
| [alicloud_cms_monitor_group.group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cms_monitor_group) | resource |
| [alicloud_cms_monitor_group_instances.group_instances](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cms_monitor_group_instances) | resource |
| [alicloud_cms_namespace.namespace](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cms_namespace) | resource |
| [alicloud_cms_site_monitor.site_monitors](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cms_site_monitor) | resource |
| [alicloud_cms_sls_group.sls_groups](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cms_sls_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alarm_contact_group_config"></a> [alarm\_contact\_group\_config](#input\_alarm\_contact\_group\_config) | The parameters of alarm contact group. The attribute 'alarm\_contact\_group\_name' is required. | <pre>object({<br/>    alarm_contact_group_name = string<br/>    contacts                 = optional(list(string), [])<br/>    describe                 = optional(string, null)<br/>    enable_subscribed        = optional(bool, false)<br/>  })</pre> | <pre>{<br/>  "alarm_contact_group_name": null<br/>}</pre> | no |
| <a name="input_alarm_contact_group_id"></a> [alarm\_contact\_group\_id](#input\_alarm\_contact\_group\_id) | The ID of an existing alarm contact group. Required when create\_alarm\_contact\_group is false. | `string` | `null` | no |
| <a name="input_alarm_contacts_config"></a> [alarm\_contacts\_config](#input\_alarm\_contacts\_config) | Configuration for alarm contacts. | <pre>map(object({<br/>    alarm_contact_name     = string<br/>    describe               = string<br/>    channels_mail          = optional(string, null)<br/>    channels_sms           = optional(string, null)<br/>    channels_ding_web_hook = optional(string, null)<br/>    channels_aliim         = optional(string, null)<br/>    lang                   = optional(string, "en")<br/>  }))</pre> | `{}` | no |
| <a name="input_alarms_config"></a> [alarms\_config](#input\_alarms\_config) | Configuration for CMS alarms. | <pre>map(object({<br/>    name               = string<br/>    project            = string<br/>    metric             = string<br/>    period             = optional(number, 300)<br/>    contact_groups     = list(string)<br/>    effective_interval = optional(string, "00:00-23:59")<br/>    metric_dimensions  = optional(string, null)<br/>    silence_time       = optional(number, 86400)<br/>    webhook            = optional(string, null)<br/>    enabled            = optional(bool, true)<br/>    escalations_critical = optional(object({<br/>      statistics          = string<br/>      comparison_operator = string<br/>      threshold           = string<br/>      times               = number<br/>    }), null)<br/>    escalations_warn = optional(object({<br/>      statistics          = string<br/>      comparison_operator = string<br/>      threshold           = string<br/>      times               = number<br/>    }), null)<br/>    escalations_info = optional(object({<br/>      statistics          = string<br/>      comparison_operator = string<br/>      threshold           = string<br/>      times               = number<br/>    }), null)<br/>  }))</pre> | `{}` | no |
| <a name="input_create_alarm_contact_group"></a> [create\_alarm\_contact\_group](#input\_create\_alarm\_contact\_group) | Whether to create a new alarm contact group. If false, an existing group ID must be provided. | `bool` | `true` | no |
| <a name="input_create_basic_public"></a> [create\_basic\_public](#input\_create\_basic\_public) | Whether to create Cloud Monitor Service Basic Public | `bool` | `false` | no |
| <a name="input_create_enterprise_public"></a> [create\_enterprise\_public](#input\_create\_enterprise\_public) | Whether to create Cloud Monitor Service Enterprise Public | `bool` | `false` | no |
| <a name="input_create_monitor_group"></a> [create\_monitor\_group](#input\_create\_monitor\_group) | Whether to create a new monitor group. If false, an existing group ID must be provided. | `bool` | `true` | no |
| <a name="input_create_monitor_group_instances"></a> [create\_monitor\_group\_instances](#input\_create\_monitor\_group\_instances) | Whether to create monitor group instances | `bool` | `false` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Whether to create a new CMS namespace. If false, an existing namespace ID must be provided. | `bool` | `true` | no |
| <a name="input_dynamic_tag_groups_config"></a> [dynamic\_tag\_groups\_config](#input\_dynamic\_tag\_groups\_config) | Configuration for CMS dynamic tag groups. | <pre>map(object({<br/>    tag_key                       = string<br/>    match_express_filter_relation = optional(string, "and")<br/>    contact_group_list            = list(string)<br/>    template_id_list              = optional(list(string), [])<br/>    match_express = list(object({<br/>      tag_value                = string<br/>      tag_value_match_function = string<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_event_rules_config"></a> [event\_rules\_config](#input\_event\_rules\_config) | Configuration for CMS event rules. | <pre>map(object({<br/>    rule_name    = string<br/>    silence_time = optional(number, 86400)<br/>    description  = optional(string, null)<br/>    status       = optional(string, "ENABLED")<br/>    event_pattern = object({<br/>      product         = string<br/>      sql_filter      = optional(string, null)<br/>      name_list       = optional(list(string), [])<br/>      level_list      = optional(list(string), [])<br/>      event_type_list = optional(list(string), [])<br/>    })<br/>  }))</pre> | `{}` | no |
| <a name="input_group_metric_rules_config"></a> [group\_metric\_rules\_config](#input\_group\_metric\_rules\_config) | Configuration for CMS group metric rules. | <pre>map(object({<br/>    group_metric_rule_name = string<br/>    category               = string<br/>    metric_name            = string<br/>    namespace              = string<br/>    period                 = optional(number, 300)<br/>    interval               = optional(number, 3600)<br/>    silence_time           = optional(number, 86400)<br/>    no_effective_interval  = optional(string, null)<br/>    webhook                = optional(string, null)<br/>    dimensions             = optional(string, null)<br/>    contact_groups         = optional(list(string), [])<br/>    email_subject          = optional(string, null)<br/>    effective_interval     = optional(string, null)<br/>    escalations = optional(object({<br/>      critical = optional(object({<br/>        comparison_operator = string<br/>        statistics          = string<br/>        threshold           = string<br/>        times               = number<br/>      }), null)<br/>      warn = optional(object({<br/>        comparison_operator = string<br/>        statistics          = string<br/>        threshold           = string<br/>        times               = number<br/>      }), null)<br/>      info = optional(object({<br/>        comparison_operator = string<br/>        statistics          = string<br/>        threshold           = string<br/>        times               = number<br/>      }), null)<br/>    }), null)<br/>  }))</pre> | `{}` | no |
| <a name="input_hybrid_monitor_fc_tasks_config"></a> [hybrid\_monitor\_fc\_tasks\_config](#input\_hybrid\_monitor\_fc\_tasks\_config) | Configuration for CMS hybrid monitor FC tasks. | <pre>map(object({<br/>    yarm_config    = string<br/>    target_user_id = optional(string, null)<br/>  }))</pre> | `{}` | no |
| <a name="input_hybrid_monitor_sls_tasks_config"></a> [hybrid\_monitor\_sls\_tasks\_config](#input\_hybrid\_monitor\_sls\_tasks\_config) | Configuration for CMS hybrid monitor SLS tasks. | <pre>map(object({<br/>    task_name           = string<br/>    description         = optional(string, null)<br/>    collect_interval    = optional(number, 60)<br/>    collect_target_type = string<br/>    sls_process_config = object({<br/>      filter = optional(object({<br/>        relation = optional(string, "and")<br/>        filters = list(object({<br/>          operator     = string<br/>          value        = string<br/>          sls_key_name = string<br/>        }))<br/>      }), null)<br/>      statistics = optional(list(object({<br/>        function      = string<br/>        alias         = string<br/>        sls_key_name  = string<br/>        parameter_one = optional(string, null)<br/>        parameter_two = optional(string, null)<br/>      })), [])<br/>      group_by = optional(list(object({<br/>        alias        = string<br/>        sls_key_name = string<br/>      })), [])<br/>      express = optional(list(object({<br/>        express = string<br/>        alias   = string<br/>      })), [])<br/>    })<br/>    attach_labels = optional(list(object({<br/>      name  = string<br/>      value = string<br/>    })), [])<br/>  }))</pre> | `{}` | no |
| <a name="input_metric_rule_templates_config"></a> [metric\_rule\_templates\_config](#input\_metric\_rule\_templates\_config) | Configuration for CMS metric rule templates. | <pre>map(object({<br/>    metric_rule_template_name = string<br/>    description               = optional(string, null)<br/>    group_id                  = optional(string, null)<br/>    apply_mode                = optional(string, null)<br/>    notify_level              = optional(number, null)<br/>    silence_time              = optional(number, 86400)<br/>    webhook                   = optional(string, null)<br/>    enable_start_time         = optional(string, null)<br/>    enable_end_time           = optional(string, null)<br/>    alert_templates = optional(list(object({<br/>      rule_name   = string<br/>      metric_name = string<br/>      namespace   = string<br/>      category    = string<br/>      webhook     = optional(string, null)<br/>      escalations = optional(object({<br/>        critical = optional(object({<br/>          comparison_operator = string<br/>          statistics          = string<br/>          threshold           = string<br/>          times               = string<br/>        }), null)<br/>        warn = optional(object({<br/>          comparison_operator = string<br/>          statistics          = string<br/>          threshold           = string<br/>          times               = string<br/>        }), null)<br/>        info = optional(object({<br/>          comparison_operator = string<br/>          statistics          = string<br/>          threshold           = string<br/>          times               = string<br/>        }), null)<br/>      }), null)<br/>    })), [])<br/>  }))</pre> | `{}` | no |
| <a name="input_monitor_group_config"></a> [monitor\_group\_config](#input\_monitor\_group\_config) | The parameters of monitor group. The attribute 'monitor\_group\_name' is required. | <pre>object({<br/>    monitor_group_name  = string<br/>    contact_groups      = optional(list(string), [])<br/>    resource_group_id   = optional(string, null)<br/>    resource_group_name = optional(string, null)<br/>  })</pre> | <pre>{<br/>  "monitor_group_name": null<br/>}</pre> | no |
| <a name="input_monitor_group_id"></a> [monitor\_group\_id](#input\_monitor\_group\_id) | The ID of an existing monitor group. Required when create\_monitor\_group is false. | `string` | `null` | no |
| <a name="input_monitor_group_instances_config"></a> [monitor\_group\_instances\_config](#input\_monitor\_group\_instances\_config) | Configuration for monitor group instances. | <pre>list(object({<br/>    instance_id   = string<br/>    instance_name = string<br/>    region_id     = string<br/>    category      = string<br/>  }))</pre> | `[]` | no |
| <a name="input_namespace_config"></a> [namespace\_config](#input\_namespace\_config) | The parameters of CMS namespace. The attribute 'namespace' is required. | <pre>object({<br/>    namespace     = string<br/>    specification = optional(string, "cms.s1.3xlarge")<br/>    description   = optional(string, null)<br/>  })</pre> | <pre>{<br/>  "namespace": null<br/>}</pre> | no |
| <a name="input_namespace_id"></a> [namespace\_id](#input\_namespace\_id) | The ID of an existing CMS namespace. Required when create\_namespace is false. | `string` | `null` | no |
| <a name="input_site_monitors_config"></a> [site\_monitors\_config](#input\_site\_monitors\_config) | Configuration for CMS site monitors. | <pre>map(object({<br/>    address   = string<br/>    task_name = string<br/>    task_type = string<br/>    interval  = optional(number, 1)<br/>    status    = optional(string, "1")<br/>    isp_cities = list(object({<br/>      city = string<br/>      isp  = string<br/>      type = optional(string, "IDC")<br/>    }))<br/>    option_json = optional(object({<br/>      response_content     = optional(string, null)<br/>      expect_value         = optional(string, null)<br/>      port                 = optional(number, null)<br/>      is_base_encode       = optional(bool, false)<br/>      ping_num             = optional(number, 5)<br/>      match_rule           = optional(number, 0)<br/>      failure_rate         = optional(string, null)<br/>      request_content      = optional(string, null)<br/>      attempts             = optional(number, 3)<br/>      request_format       = optional(string, "text")<br/>      password             = optional(string, null)<br/>      diagnosis_ping       = optional(bool, false)<br/>      response_format      = optional(string, "text")<br/>      cookie               = optional(string, null)<br/>      ping_port            = optional(number, null)<br/>      user_name            = optional(string, null)<br/>      dns_match_rule       = optional(string, null)<br/>      timeout              = optional(number, 5000)<br/>      dns_server           = optional(string, null)<br/>      diagnosis_mtr        = optional(bool, false)<br/>      header               = optional(string, null)<br/>      min_tls_version      = optional(string, null)<br/>      ping_type            = optional(string, "icmp")<br/>      dns_type             = optional(string, "A")<br/>      dns_hijack_whitelist = optional(string, null)<br/>      http_method          = optional(string, "get")<br/>      assertions = optional(list(object({<br/>        operator = string<br/>        target   = string<br/>        type     = string<br/>      })), [])<br/>    }), null)<br/>  }))</pre> | `{}` | no |
| <a name="input_sls_groups_config"></a> [sls\_groups\_config](#input\_sls\_groups\_config) | Configuration for CMS SLS groups. | <pre>map(object({<br/>    sls_group_name        = string<br/>    sls_group_description = optional(string, null)<br/>    sls_group_config = list(object({<br/>      sls_user_id  = optional(string, null)<br/>      sls_logstore = string<br/>      sls_project  = string<br/>      sls_region   = string<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alarm_contact_group_id"></a> [alarm\_contact\_group\_id](#output\_alarm\_contact\_group\_id) | The ID of the alarm contact group |
| <a name="output_alarm_contact_group_name"></a> [alarm\_contact\_group\_name](#output\_alarm\_contact\_group\_name) | The name of the alarm contact group |
| <a name="output_alarm_contacts"></a> [alarm\_contacts](#output\_alarm\_contacts) | The alarm contacts information |
| <a name="output_alarms"></a> [alarms](#output\_alarms) | The CMS alarms information |
| <a name="output_basic_public_create_time"></a> [basic\_public\_create\_time](#output\_basic\_public\_create\_time) | The creation time of the Cloud Monitor Service Basic Public |
| <a name="output_basic_public_id"></a> [basic\_public\_id](#output\_basic\_public\_id) | The ID of the Cloud Monitor Service Basic Public |
| <a name="output_dynamic_tag_groups"></a> [dynamic\_tag\_groups](#output\_dynamic\_tag\_groups) | The CMS dynamic tag groups information |
| <a name="output_enterprise_public_create_time"></a> [enterprise\_public\_create\_time](#output\_enterprise\_public\_create\_time) | The creation time of the Cloud Monitor Service Enterprise Public |
| <a name="output_enterprise_public_id"></a> [enterprise\_public\_id](#output\_enterprise\_public\_id) | The ID of the Cloud Monitor Service Enterprise Public |
| <a name="output_event_rules"></a> [event\_rules](#output\_event\_rules) | The CMS event rules information |
| <a name="output_group_metric_rules"></a> [group\_metric\_rules](#output\_group\_metric\_rules) | The CMS group metric rules information |
| <a name="output_hybrid_monitor_fc_tasks"></a> [hybrid\_monitor\_fc\_tasks](#output\_hybrid\_monitor\_fc\_tasks) | The CMS hybrid monitor FC tasks information |
| <a name="output_hybrid_monitor_sls_tasks"></a> [hybrid\_monitor\_sls\_tasks](#output\_hybrid\_monitor\_sls\_tasks) | The CMS hybrid monitor SLS tasks information |
| <a name="output_metric_rule_templates"></a> [metric\_rule\_templates](#output\_metric\_rule\_templates) | The CMS metric rule templates information |
| <a name="output_monitor_group_id"></a> [monitor\_group\_id](#output\_monitor\_group\_id) | The ID of the monitor group |
| <a name="output_monitor_group_instances_id"></a> [monitor\_group\_instances\_id](#output\_monitor\_group\_instances\_id) | The ID of the monitor group instances |
| <a name="output_monitor_group_name"></a> [monitor\_group\_name](#output\_monitor\_group\_name) | The name of the monitor group |
| <a name="output_namespace_id"></a> [namespace\_id](#output\_namespace\_id) | The ID of the CMS namespace |
| <a name="output_namespace_specification"></a> [namespace\_specification](#output\_namespace\_specification) | The specification of the CMS namespace |
| <a name="output_site_monitors"></a> [site\_monitors](#output\_site\_monitors) | The CMS site monitors information |
| <a name="output_sls_groups"></a> [sls\_groups](#output\_sls\_groups) | The CMS SLS groups information |
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