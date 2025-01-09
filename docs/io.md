## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| actionGroups | n/a | <pre>map(object({<br>    actionGroupName          = string<br>    actionGroupShortName     = string<br>    actionGroupRGName        = string<br>    actionGroupEnabled       = string<br>    actionGroupEmailReceiver = list(map(string))<br>  }))</pre> | `{}` | no |
| activity\_log\_alert | n/a | <pre>map(object({<br>    alertname      = string<br>    alertrg        = string<br>    alertscopes    = list(string)<br>    description    = string<br>    operation_name = string<br>    actionGroupID  = string<br>    category       = string<br>  }))</pre> | `{}` | no |
| application | Application (e.g. `cd` or `clouddrove`). | `string` | `""` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| label\_order | Label order, e.g. `name`,`application`. | `list(any)` | <pre>[<br>  "name",<br>  "environment"<br>]</pre> | no |
| managedby | ManagedBy, eg 'CloudDrove' or 'AnmolNagpal'. | `string` | `"anmol@clouddrove.com"` | no |
| metricAlerts | n/a | <pre>map(object({<br>    alertName                  = string<br>    alertResourceGroupName     = string<br>    alertScopes                = list(string)<br>    alertDescription           = string<br>    alertEnabled               = bool<br>    alertAutoMitigate          = bool<br>    alertFrequency             = string<br>    alertTargetResourceType    = string<br>    alertTargetResourceLoc     = string<br>    dynCriteriaMetricNamespace = string<br>    dynCriteriaMetricName      = string<br>    dynCriteriaAggregation     = string<br>    dynCriteriaOperator        = string<br>    dynCriteriathreshold       = string<br>    actionGroupID              = string<br>  }))</pre> | `{}` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| repository | Terraform current module repo | `string` | `""` | no |
| tags | Additional tags (e.g. map(`BusinessUnit`,`XYZ`). | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| ag | n/a |
| metric-alerts | n/a |

