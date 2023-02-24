#Module      : LABEL
#Description : Terraform label module variables.
variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "application" {
  type        = string
  default     = ""
  description = "Application (e.g. `cd` or `clouddrove`)."
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)."
}

variable "managedby" {
  type        = string
  default     = "anmol@clouddrove.com"
  description = "ManagedBy, eg 'CloudDrove' or 'AnmolNagpal'."
}

variable "label_order" {
  type        = list(any)
  default     = []
  description = "Label order, e.g. `name`,`application`."
}
variable "repository" {
  type        = string
  default     = ""
  description = "Terraform current module repo"
}

variable "actionGroups" {
  type = map(object({
    actionGroupName          = string
    actionGroupShortName     = string
    actionGroupRGName        = string
    actionGroupEnabled       = string
    actionGroupEmailReceiver = list(map(string))
  }))
  default = {}
}

variable "metricAlerts" {
  type = map(object({
    alertName                  = string
    alertResourceGroupName     = string
    alertScopes                = list(string)
    alertDescription           = string
    alertEnabled               = bool
    alertAutoMitigate          = bool
    alertFrequency             = string
    alertTargetResourceType    = string
    alertTargetResourceLoc     = string
    dynCriteriaMetricNamespace = string
    dynCriteriaMetricName      = string
    dynCriteriaAggregation     = string
    dynCriteriaOperator        = string
    dynCriteriathreshold       = string
    actionGroupID              = string
  }))
  default = {}
}

variable "activity_log_alert" {
  type = map(object({
    alertname      = string
    alertrg        = string
    alertscopes    = list(string)
    description    = string
    operation_name = string
    actionGroupID  = string
    category       = string
  }))

  default = {}
}