# langwire-infra
Terraform files for AWS resources related to langwire

## How to run
Currently, the .tfstate file is managed in my local machine, meaning that deploys of the infra can only be done via this way, or it can get out of sync. If the resources needs deletion, check all resources whose tags are defined in the [providers.tf](providers.tf#L15) file.

### First run
```bash
terraform init 
```
### Update resources
```bash
terraform apply
```

## Infracost service
This outputs estimations for the infra with breakdowns using the terraform repo. https://www.infracost.io
After I ran this, I decided to remove the NAT gateway with public/private subnets to avoid extra $37/mo.

```bash
❯ infracost breakdown --path=. --show-skipped
Evaluating Terraform directory at .
  ✔ Downloading Terraform modules
  ✔ Evaluating Terraform directory
  ✔ Retrieving cloud prices to calculate costs

Project: gorillalogic/langwire-infra

 Name                       Monthly Qty  Unit            Monthly Cost

 aws_ecr_repository.main
 └─ Storage               Monthly cost depends on usage: $0.10 per GB

 aws_ecs_service.main
 ├─ Per GB per hour                 0.5  GB                     $1.62
 └─ Per vCPU per hour              0.25  CPU                    $7.39

 OVERALL TOTAL                                                  $9.01
──────────────────────────────────
15 cloud resources were detected:
∙ 2 were estimated, 1 of which usage-based costs, see https://infracost.io/usage-file
∙ 13 were free:
  ∙ 2 x aws_iam_role
  ∙ 1 x aws_ecr_lifecycle_policy
  ∙ 1 x aws_ecs_cluster
  ∙ 1 x aws_ecs_task_definition
  ∙ 1 x aws_iam_role_policy_attachment
  ∙ 1 x aws_internet_gateway
  ∙ 1 x aws_route
  ∙ 1 x aws_route_table
  ∙ 1 x aws_route_table_association
  ∙ 1 x aws_security_group
  ∙ 1 x aws_subnet
  ∙ 1 x aws_vpc
```

## References

I based this setup on this blogpost https://engineering.finleap.com/posts/2020-02-20-ecs-fargate-terraform and removed some components for simplicity.

## Future Work
- Move ECS fargate to a private subnet, add a NAT Gateway and a ALB.
