# Complete Example

This example demonstrates the complete usage of the Cloud Monitor Service Terraform module with various monitoring features.

## Features Demonstrated

- **Basic Monitoring Services**: Create CMS namespace and basic monitoring setup
- **Alarm Management**: Configure alarm contact groups, contacts, and alarm rules
- **Monitor Groups**: Set up monitor groups and associate instances
- **Site Monitoring**: Monitor external websites with HTTP checks
- **Log Integration**: Integrate with Log Service for hybrid monitoring
- **SLS Tasks**: Configure SLS-based monitoring tasks

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| alicloud | >= 1.171.0 |
| random | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| alicloud | >= 1.171.0 |
| random | >= 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| cloud_monitor_service | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| alicloud_vpc.example | resource |
| alicloud_vswitch.example | resource |
| alicloud_security_group.example | resource |
| alicloud_instance.example | resource |
| alicloud_log_project.example | resource |
| alicloud_log_store.example | resource |
| random_uuid.example | resource |
| alicloud_zones.default | data source |
| alicloud_instance_types.default | data source |
| alicloud_images.default | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| region | The Alibaba Cloud region to deploy resources in | `string` | `"cn-hangzhou"` | no |
| name | Name prefix for all resources | `string` | `"cms-example"` | no |
| create_basic_public | Whether to create Cloud Monitor Service Basic Public | `bool` | `false` | no |
| create_enterprise_public | Whether to create Cloud Monitor Service Enterprise Public | `bool` | `false` | no |
| create_namespace | Whether to create a new CMS namespace | `bool` | `true` | no |
| namespace_name | The name of the CMS namespace | `string` | `"cms-example-namespace"` | no |
| namespace_specification | The specification of the CMS namespace | `string` | `"cms.s1.large"` | no |
| create_alarm_contact_group | Whether to create a new alarm contact group | `bool` | `true` | no |
| contact_email | Email address for alarm notifications | `string` | `"admin@example.com"` | no |
| create_monitor_group | Whether to create a new monitor group | `bool` | `true` | no |
| create_monitor_group_instances | Whether to create monitor group instances | `bool` | `true` | no |
| monitor_website_url | Website URL to monitor | `string` | `"https://www.alibabacloud.com"` | no |
| tags | A mapping of tags to assign to the resources | `map(string)` | `{"Environment": "example", "ManagedBy": "Terraform", "Project": "cloud-monitor-service"}` | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | The ID of the VPC |
| vswitch_id | The ID of the VSwitch |
| instance_id | The ID of the ECS instance |
| log_project_name | The name of the Log Service project |
| log_store_name | The name of the Log Service logstore |
| namespace_id | The ID of the CMS namespace |
| monitor_group_id | The ID of the monitor group |
| alarm_contact_group_id | The ID of the alarm contact group |
| alarms | The CMS alarms information |
| site_monitors | The CMS site monitors information |
| sls_groups | The CMS SLS groups information |
| hybrid_monitor_sls_tasks | The CMS hybrid monitor SLS tasks information |

## Notes

1. **Email Verification**: After creating alarm contacts with email addresses, you need to verify the email addresses to receive notifications.

2. **Resource Dependencies**: This example creates ECS instances and VPC resources for demonstration purposes. The monitoring configuration depends on these resources.

3. **SLS Integration**: The example demonstrates integration with Log Service for hybrid monitoring capabilities.

4. **Cost Considerations**: Some monitoring features may incur additional costs. Please review the pricing before deploying.

5. **Customization**: You can customize the monitoring configuration by modifying the variables or adding additional alarm rules and monitors.