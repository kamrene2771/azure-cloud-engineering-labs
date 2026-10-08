# 02 — Azure Management & Governance

> Status: 🔄 **In progress**

This section documents the next phase of the Azure learning path: management, governance, monitoring, and cost-control concepts.

Planned topics include:

- Cost management
- Resource tagging
- Azure Policy
- Resource locks
- Azure RBAC
- Azure Monitor
- Azure Advisor
- Management tools
- Infrastructure deployment approaches


1.factors that can affect costs
Many factors affect how much you pay. Some of the factors that affect cost are:

Resource type
Consumption
Maintenance
Geography
Subscription type
Azure Marketplace

the pricing calculator
The pricing calculator is designed to give you an estimated cost for provisioning resources in Azure. You can get an estimate for individual resources, build out a solution, or use an example scenario to see an estimate of the Azure spend.

If you're planning a new web application, you can model one App Service plan, a managed database, and required storage options in the pricing calculator. You can then compare monthly estimates across regions, service tiers, and redundancy options before deployment.

2.Microsoft Cost Management tool

What is Cost Management?
Cost Management provides the ability to quickly check Azure resource costs, create alerts based on resource spend, and create budgets that can be used to automate management of resources.

Cost alerts
Cost alerts provide a single location to quickly check on all of the different alert types that may show up in the Cost Management service. The three types of alerts that may show up are:

Budget alerts
Credit alerts
Department spending quota alerts.
Budget alerts
Budget alerts notify you when spending reaches or exceeds a threshold you define. You can create budgets in the Azure portal or through the Azure Consumption API.

In the Azure portal, budgets are defined by cost. If you use the Azure Consumption API, you can also define budgets by consumption usage. Budget alerts are generated automatically whenever the budget alert conditions are met. You can view all cost alerts in the Azure portal. Whenever an alert is generated, it appears in cost alerts, and an alert email is also sent to the people in the alert recipients list of the budget.

For example, you might set an alert at 80% of a monthly dev/test budget so your team can investigate and right-size resources before costs exceed target.

3.the purpose of tags

Resource management Tags enable you to locate and act on resources that are associated with specific workloads, environments, teams, and owners.
Cost management and optimization Tags enable you to group resources so that you can report on costs, allocate internal cost centers, track budgets, and forecast estimated cost.
Operations management Tags enable you to group resources according to how critical their availability is to your operations. This grouping helps you formulate service-level agreements (SLAs). An SLA is an uptime or performance guarantee between you and your users.
Security Tags enable you to classify data by its security level, such as public or confidential.
Governance and regulatory compliance Tags enable you to identify resources that align with governance or regulatory compliance requirements, such as ISO 27001. Tags can also be part of your standards enforcement efforts. For example, you might require that all resources be tagged with an owner or department name.
Workload optimization and automation Tags can help you visualize all of the resources that participate in complex deployments. For example, you might tag a resource with its associated workload or application name and use software such as Azure DevOps to perform automated tasks on those resources.

4.cost optimization options in Azure

Reservations
Reservations are best for stable, predictable workloads. You commit to specific resource capacity for a one-year or three-year term, and Azure applies discounted pricing to matching usage.

Azure savings plan for compute
Azure savings plan for compute is another commitment-based option for compute services. Instead of committing to a specific VM family or instance type, you commit to an hourly spend amount for one or three years, and savings are applied to eligible compute usage.

Spot pricing
Spot Virtual Machines use unused Azure capacity at reduced prices. Spot is most appropriate for interruptible workloads because Azure can reclaim that capacity when needed.

Decision guide
Use this quick decision pattern:

Choose Reservations for predictable, long-running workloads with stable resource needs.
Choose Azure savings plan for compute when usage is steady but you need more flexibility across compute services.
Choose Spot pricing for fault-tolerant or interruptible workloads where lowest cost is the top priority.
