# Local variables
locals { users = yamldecode(file("users.yaml")) }
locals { groups = yamldecode(file("groups.yaml")) }

# Create iam user
resource "aws_iam_user" "users" {
  for_each = local.users
  name     = each.value.name
}

# Create iam group
resource "aws_iam_group" "groups" {
  for_each = local.groups
  name     = each.value.name
}

# Users can have multiple groups 
# Flatten user > group for group-assignments
locals {
  groupAssignments = flatten([
    for key, attributes in local.users : [
      for g in attributes.groups_aws : {
        name  = attributes.name
        group = g
        email = key
      }
    ] if attributes.groups_aws != null
  ])
}

# Assign Users to Group
resource "aws_iam_user_group_membership" "groups" {
  for_each = { for idx, v in local.groupAssignments : idx => v }
  user     = aws_iam_user.users[each.value.email].name
  groups   = [aws_iam_group.groups[each.value.group].name]
}


## Provider 
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.61.0"
    }
  }
}

provider "aws" {}
