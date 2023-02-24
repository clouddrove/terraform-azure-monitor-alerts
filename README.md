<!-- This file was automatically generated by the `geine`. Make all changes to `README.yaml` and run `make readme` to rebuild this file. -->

<p align="center"> <img src="https://user-images.githubusercontent.com/50652676/62349836-882fef80-b51e-11e9-99e3-7b974309c7e3.png" width="100" height="100"></p>


<h1 align="center">
    Terraform AZURE MONITOR ALERTS
</h1>

<p align="center" style="font-size: 1.2rem;"> 
    Terraform module to create monitor alerts resource on AZURE.
     </p>

<p align="center">

<a href="https://www.terraform.io">
  <img src="https://img.shields.io/badge/Terraform-v1.1.7-green" alt="Terraform">
</a>
<a href="LICENSE.md">
  <img src="https://img.shields.io/badge/License-APACHE-blue.svg" alt="Licence">
</a>


</p>
<p align="center">

<a href='https://facebook.com/sharer/sharer.php?u=https://github.com/clouddrove/terraform-azure-monitor-alerts'>
  <img title="Share on Facebook" src="https://user-images.githubusercontent.com/50652676/62817743-4f64cb80-bb59-11e9-90c7-b057252ded50.png" />
</a>
<a href='https://www.linkedin.com/shareArticle?mini=true&title=Terraform+AZURE+MONITOR+ALERTS&url=https://github.com/clouddrove/terraform-azure-monitor-alerts'>
  <img title="Share on LinkedIn" src="https://user-images.githubusercontent.com/50652676/62817742-4e339e80-bb59-11e9-87b9-a1f68cae1049.png" />
</a>
<a href='https://twitter.com/intent/tweet/?text=Terraform+AZURE+MONITOR+ALERTS&url=https://github.com/clouddrove/terraform-azure-monitor-alerts'>
  <img title="Share on Twitter" src="https://user-images.githubusercontent.com/50652676/62817740-4c69db00-bb59-11e9-8a79-3580fbbf6d5c.png" />
</a>

</p>
<hr>


We eat, drink, sleep and most importantly love **DevOps**. We are working towards strategies for standardizing architecture while ensuring security for the infrastructure. We are strong believer of the philosophy <b>Bigger problems are always solved by breaking them into smaller manageable problems</b>. Resonating with microservices architecture, it is considered best-practice to run database, cluster, storage in smaller <b>connected yet manageable pieces</b> within the infrastructure. 

This module is basically combination of [Terraform open source](https://www.terraform.io/) and includes automatation tests and examples. It also helps to create and improve your infrastructure with minimalistic code instead of maintaining the whole infrastructure code yourself.

We have [*fifty plus terraform modules*][terraform_modules]. A few of them are comepleted and are available for open source usage while a few others are in progress.




## Prerequisites

This module has a few dependencies: 

- [Terraform 1.x.x](https://learn.hashicorp.com/terraform/getting-started/install.html)
- [Go](https://golang.org/doc/install)
- [github.com/stretchr/testify/assert](https://github.com/stretchr/testify)
- [github.com/gruntwork-io/terratest/modules/terraform](https://github.com/gruntwork-io/terratest)







## Examples


**IMPORTANT:** Since the `master` branch used in `source` varies based on new modifications, we suggest that you use the release versions [here](https://github.com/clouddrove/terraform-azure-monitor-alerts/releases).


Here are some examples of how you can use this module in your inventory structure:
### action group
```hcl
  module "monitor-alerts" {
  source                         = "clouddrove/monitor-alerts/azure"
  version                        = "1.0.0"
  name                           = "app"
  environment                    = "test"
  label_order                    = ["name", "environment"]

  actionGroups = {
    "group1" = {
      actionGroupName      = "AlertEscalationGroup"
      actionGroupShortName = "alertesc"
      actionGroupRGName    = module.resource_group.resource_group_name
      actionGroupEnabled   = "true"
      actionGroupEmailReceiver = [
        {
          name                    = "example"
          email_address           = "example@gmail.com"
          use_common_alert_schema = "true"
        },
        {
          name                    = "test"
          email_address           = "test@gmail.com"
          use_common_alert_schema = "true"
        }
      ]
    }
  }
}
```
### metric alert
```hcl
  module "monitor-alerts" {
  source                         = "clouddrove/monitor-alerts/azure"
  version                        = "1.0.0"
  name                           = "app"
  environment                    = "test"
  label_order                    = ["name", "environment"]

  actionGroups = {
    "group1" = {
      actionGroupName      = "AlertEscalationGroup"
      actionGroupShortName = "alertesc"
      actionGroupRGName    = module.resource_group.resource_group_name
      actionGroupEnabled   = "true"
      actionGroupEmailReceiver = [
        {
          name                    = "test"
          email_address           = "mahesh.yadav@clouddrove.com"
          use_common_alert_schema = "true"
        },
        {
          name                    = "test"
          email_address           = "test@gmail.com"
          use_common_alert_schema = "true"
        }
      ]
    }
  }
}
```

  ### Activity Log Alert
```hcl
module "alerts" {
depends_on = [data.azurerm_monitor_action_group.example, ]
source     = "clouddrove/monitor-alerts/azure"

name        = "app"
environment = "test"
label_order = ["name", "environment"]

activity_log_alert = {
  "test1" = {
    alertname      = "nsg-write"
    alertrg        = module.resource_group.resource_group_name
    alertscopes    = [module.resource_group.resource_group_id]
    description    = "Administrative alerts for nsg"
    operation_name = "Microsoft.Network/networkSecurityGroups/write"
    actionGroupID  = data.azurerm_monitor_action_group.example.id
    category       = "Administrative"
  }
}
}


```






## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| actionGroups | n/a | <pre>map(object({<br>    actionGroupName          = string<br>    actionGroupShortName     = string<br>    actionGroupRGName        = string<br>    actionGroupEnabled       = string<br>    actionGroupEmailReceiver = list(map(string))<br>  }))</pre> | `{}` | no |
| activity\_log\_alert | n/a | <pre>map(object({<br>    alertname      = string<br>    alertrg        = string<br>    alertscopes    = list(string)<br>    description    = string<br>    operation_name = string<br>    actionGroupID  = string<br>    category       = string<br>  }))</pre> | `{}` | no |
| application | Application (e.g. `cd` or `clouddrove`). | `string` | `""` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| label\_order | Label order, e.g. `name`,`application`. | `list(any)` | `[]` | no |
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




## Testing
In this module testing is performed with [terratest](https://github.com/gruntwork-io/terratest) and it creates a small piece of infrastructure, matches the output like ARN, ID and Tags name etc and destroy infrastructure in your AWS account. This testing is written in GO, so you need a [GO environment](https://golang.org/doc/install) in your system. 

You need to run the following command in the testing folder:
```hcl
  go test -run Test
```



## Feedback 
If you come accross a bug or have any feedback, please log it in our [issue tracker](https://github.com/clouddrove/terraform-azure-monitor-alerts/issues), or feel free to drop us an email at [hello@clouddrove.com](mailto:hello@clouddrove.com).

If you have found it worth your time, go ahead and give us a ★ on [our GitHub](https://github.com/clouddrove/terraform-azure-monitor-alerts)!

## About us

At [CloudDrove][website], we offer expert guidance, implementation support and services to help organisations accelerate their journey to the cloud. Our services include docker and container orchestration, cloud migration and adoption, infrastructure automation, application modernisation and remediation, and performance engineering.

<p align="center">We are <b> The Cloud Experts!</b></p>
<hr />
<p align="center">We ❤️  <a href="https://github.com/clouddrove">Open Source</a> and you can check out <a href="https://github.com/clouddrove">our other modules</a> to get help with your new Cloud ideas.</p>

  [website]: https://clouddrove.com
  [github]: https://github.com/clouddrove
  [linkedin]: https://cpco.io/linkedin
  [twitter]: https://twitter.com/clouddrove/
  [email]: https://clouddrove.com/contact-us.html
  [terraform_modules]: https://github.com/clouddrove?utf8=%E2%9C%93&q=terraform-&type=&language=
