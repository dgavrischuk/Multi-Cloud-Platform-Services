data external test_policy_members{
  query = {
    for role, members in local.cloudrun_iam_bindings["app1"]:
      role => length(lookup(members, "members", []))
  }

  program = ["python", "${path.module}/test_policy_members.py"]
}
output test_policy_members {
  value = data.external.test_policy_members.result
}

data external test_ae_traffic_extended {
  query = lookup(local.cloudrun_traffic, "app1-service", {})
  program = ["python", "${path.module}/test_cloudrun_traffic_extended.py"]
}
output test_ae_traffic_1 {
  value = data.external.test_ae_traffic_extended.result
}

data external test_ae_traffic {
  query = lookup(local.cloudrun_traffic, "app1", {})
  program = ["python", "${path.module}/test_cloudrun_traffic.py"]
}

output test_ae_traffic {
  value = data.external.test_ae_traffic.result
}
data external test_ae_traffic_empty {
  query = lookup(local.cloudrun_traffic, "app2", {})
  program = ["python", "${path.module}/test_cloudrun_traffic.py"]
}

output test_ae_traffic_empty {
  value = data.external.test_ae_traffic.result
}

data external test_domain {
  query = {
    for service, config in local.cloudrun_domains:
      service => lookup(config, "domain", null )
  }
  program = ["python", "${path.module}/test_cloudrun_domain.py"]
}

output test_domain {
  value = data.external.test_domain.result
}

data external test_autogenerate_revision_name {
  query = {
    for service, value in local.cloudrun_autogenerate_revision_name:
      service => tostring(value)
  }
  program = ["python", "${path.module}/test_cloudrun_autogenerate_revision_name.py"]
}

output test_autogenerate_revision_name {
  value = data.external.test_autogenerate_revision_name.result
}