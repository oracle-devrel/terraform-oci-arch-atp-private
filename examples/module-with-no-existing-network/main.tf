## Copyright (c) 2021 Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}
variable "compartment_ocid" {}
variable "ATP_password" {}
variable "ATP_free_tier" {}

provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

module "oci-arch-atp-private" {
  source           = "github.com/oracle-devrel/terraform-oci-arch-atp-private"
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  region           = var.region
  private_key_path = var.private_key_path
  compartment_ocid = var.compartment_ocid
  ATP_password     = var.ATP_password
  ATP_free_tier    = var.ATP_free_tier
}

output "webserver1_public_ip" {
  value = module.oci-arch-atp-private.webserver1_public_ip
}

output "generated_ssh_private_key" {
  value     = module.oci-arch-atp-private.generated_ssh_private_key
  sensitive = true
}
