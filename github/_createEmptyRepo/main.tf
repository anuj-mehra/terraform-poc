locals {
  repos_data = yamldecode(file("${path.module}/repos.yml")).repos
}

output "repos_raw" {
  value = local.repos_data
}

resource "github_repository" "repos" {
  for_each = {
  for repo in local.repos_data : repo.name => repo
  }

  name        = each.value.name
  description = each.value.description
  visibility  = each.value.visibility

  template {
    owner      = each.value.template_owner
    repository = each.value.template_repo
  }
}
