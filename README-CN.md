阿里云云监控服务 Terraform 模块

# terraform-alicloud-cloud-monitor-service

[English](https://github.com/alibabacloud-automation/terraform-alicloud-cloud-monitor-service/blob/main/README.md) | 简体中文

在阿里云上创建完整云监控服务（CMS）资源的 Terraform 模块。此模块提供[高效的云资源监控和告警功能](https://www.alibabacloud.com/help/en/cms/product-overview/what-is-cloudmonitor)，为您的阿里云环境提供基础设施、应用程序和自定义指标的完整监控解决方案。

## 使用方法

此模块提供完整的云监控服务设置，包括命名空间、告警管理、监控组、站点监控和混合监控功能。您可以使用它为您的云基础设施建立全面的监控。

```terraform
module "cloud_monitor_service" {
  source = "alibabacloud-automation/cloud-monitor-service/alicloud"

  # 命名空间配置
  create_namespace = true
  namespace_config = {
    namespace     = "my-monitoring-namespace"
    specification = "cms.s1.large"
    description   = "Monitoring namespace for my application"
  }

  # 告警联系人组配置
  create_alarm_contact_group = true
  alarm_contact_group_config = {
    alarm_contact_group_name = "my-contact-group"
    describe                 = "Primary contact group for alerts"
    enable_subscribed        = true
  }

  # 监控组配置
  create_monitor_group = true
  monitor_group_config = {
    monitor_group_name = "my-monitor-group"
    contact_groups     = ["my-contact-group"]
  }

  # 告警配置
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

  # 站点监控配置
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

## 示例

* [完整示例](https://github.com/alibabacloud-automation/terraform-alicloud-cloud-monitor-service/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->

## 提交问题

如果您在使用此模块时遇到任何问题，请提交一个 [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) 并告知我们。

**注意：** 不建议在此仓库中提交问题。

## 作者

由阿里云 Terraform 团队创建和维护(terraform@alibabacloud.com)。

## 许可证

MIT 许可。有关完整详细信息，请参阅 LICENSE。

## 参考

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)