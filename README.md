# tf-update-in-place

Terraform keep updating-in-place resources even though none of them got touched instead of their position has changed ... can someone help me fix this issue -

```
.... < remove some extra info > ...

Terraform used the selected providers to generate the following execution plan. Resource actions are
indicated with the following symbols:
  ~ update in-place

Terraform will perform the following actions:

  # aws_iam_user_group_membership.groups["0"] will be updated in-place
  ~ resource "aws_iam_user_group_membership" "groups" {
      ~ groups = [
          - "aws-lambda",
          + "aws-ec2",
        ]
        id     = "terraform-20230331153935663300000002"
        # (1 unchanged attribute hidden)
    }

  # aws_iam_user_group_membership.groups["1"] will be updated in-place
  ~ resource "aws_iam_user_group_membership" "groups" {
      ~ groups = [
          - "aws-ec2",
          + "aws-vpc",
        ]
        id     = "terraform-20230331153935663300000003"
        # (1 unchanged attribute hidden)
    }

  # aws_iam_user_group_membership.groups["2"] will be updated in-place
  ~ resource "aws_iam_user_group_membership" "groups" {
      ~ groups = [
          - "aws-vpc",
          + "aws-lambda",
        ]
        id     = "terraform-20230331154455701300000002"
        # (1 unchanged attribute hidden)
    }

Plan: 0 to add, 3 to change, 0 to destroy.

```