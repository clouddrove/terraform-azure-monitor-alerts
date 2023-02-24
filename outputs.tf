output "ag" {
  value = azurerm_monitor_action_group.group.*
}
output "metric-alerts" {
  value = azurerm_monitor_metric_alert.alert
}
