module "alarm-service-resources" {
  count                                = var.resource_alarms_enabled ? 1 : 0
  source                               = "applike/alarm-service-resources/aws"
  version                              = "1.1.2"
  context                              = module.this.context
  enabled                              = var.resource_alarms_enabled
  treat_missing_data                   = var.resource_alarms_treat_missing_data
  average_resource_period              = var.resource_alarms_average_period
  average_resource_evaluation_periods  = var.resource_alarms_average_evaluation_periods
  average_resource_datapoints_to_alarm = var.resource_alarms_average_datapoints_to_alarm
  average_resource_cpu_threshold       = var.resource_alarms_average_cpu_threshold
  average_resource_memory_threshold    = var.resource_alarms_average_memory_threshold
  maximum_resource_period              = var.resource_alarms_maximum_period
  maximum_resource_evaluation_periods  = var.resource_alarms_maximum_evaluation_periods
  maximum_resource_datapoints_to_alarm = var.resource_alarms_maximum_datapoints_to_alarm
  maximum_resource_cpu_threshold       = var.resource_alarms_maximum_cpu_threshold
  maximum_resource_memory_threshold    = var.resource_alarms_maximum_memory_threshold
}
