provider "azurerm" {
  features {}
}

module "resource_group" {
  source  = "clouddrove/resource-group/azure"
  version = "1.0.2"

  name        = "app"
  environment = "test"
  label_order = ["name", "environment"]
  location    = "Canada Central"
}

module "azmonitor-action-group" {
  source      = "./../../"
  name        = "app"
  environment = "test"

  actionGroups = {
    "group1" = {
      actionGroupName      = "Notification"
      actionGroupShortName = "alertesc"
      actionGroupRGName    = module.resource_group.resource_group_name
      actionGroupEnabled   = "true"
      actionGroupEmailReceiver = [
        {
          name                    = "test"
          email_address           = "archit.chopra@clouddrove.com"
          use_common_alert_schema = "false"
        }
      ]
    }
  }
}

data "azurerm_monitor_action_group" "example" {
  depends_on          = [module.azmonitor-action-group]
  resource_group_name = module.resource_group.resource_group_name
  name                = "Notification"
}



module "alerts" {
  depends_on = [data.azurerm_monitor_action_group.example, ]
  source     = "./../../"

  name        = "app"
  environment = "test"

  activity_log_alert = {
    "test1" = {
      alertname      = "nsg-write"
      alertrg        = module.resource_group.resource_group_name
      alertscopes    = [module.resource_group.resource_group_id]
      description    = "Administrative alerts for nsg"
      operation_name = "Microsoft.Network/networkSecurityGroups/write"
      actionGroupID  = data.azurerm_monitor_action_group.example.id
      category       = "Administrative"
    },
    "test2" = {
      alertname      = "nsg-delete"
      alertrg        = module.resource_group.resource_group_name
      alertscopes    = [module.resource_group.resource_group_id]
      description    = "Administrative alerts for nsg"
      operation_name = "Microsoft.Network/networkSecurityGroups/delete"
      actionGroupID  = data.azurerm_monitor_action_group.example.id
      category       = "Administrative"
    }
  }
}


