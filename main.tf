module "labels" {
  source      = "clouddrove/labels/azure"
  version     = "1.0.0"
  name        = var.name
  environment = var.environment
  managedby   = var.managedby
  label_order = var.label_order
  repository  = var.repository
}

resource "azurerm_monitor_action_group" "group" {
  for_each = var.actionGroups

  name                = each.value.actionGroupName
  resource_group_name = each.value.actionGroupRGName
  short_name          = each.value.actionGroupShortName
  enabled             = each.value.actionGroupEnabled

  dynamic "email_receiver" {
    for_each = each.value.actionGroupEmailReceiver
    content {
      name                    = email_receiver.value["name"]
      email_address           = email_receiver.value["email_address"]
      use_common_alert_schema = email_receiver.value["use_common_alert_schema"]
    }
  }
  tags = module.labels.tags
}

resource "azurerm_monitor_metric_alert" "alert" {
  for_each                 = var.metricAlerts
  name                     = each.value.alertName
  resource_group_name      = each.value.alertResourceGroupName
  scopes                   = each.value.alertScopes
  description              = each.value.alertDescription
  enabled                  = each.value.alertEnabled
  auto_mitigate            = each.value.alertAutoMitigate
  frequency                = each.value.alertFrequency
  target_resource_type     = each.value.alertTargetResourceType
  target_resource_location = each.value.alertTargetResourceLoc

  criteria {
    metric_namespace = each.value.dynCriteriaMetricNamespace
    metric_name      = each.value.dynCriteriaMetricName
    aggregation      = each.value.dynCriteriaAggregation
    operator         = each.value.dynCriteriaOperator
    threshold        = each.value.dynCriteriathreshold


  }
  action {
    action_group_id = each.value.actionGroupID
  }
  tags = module.labels.tags
}
