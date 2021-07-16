region = "ap-southeast-1"

availability_zones = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]

#vpc_cidr_block = "172.16.0.0/16"

namespace = "edu"

stage = "test"

name = "eks-node-group"

kubernetes_version = "1.20"

oidc_provider_enabled = true

enabled_cluster_log_types = ["audit"]

cluster_log_retention_period = 7

instance_types = ["t3.small"]

desired_size = 2

max_size = 3

min_size = 2

disk_size = 20

kubernetes_labels = {}

before_cluster_joining_userdata = <<-EOT
  printf "\n\n###\nExample output from before_cluster_joining_userdata\n###\n\n"
  EOT

remote_access_enabled = false
