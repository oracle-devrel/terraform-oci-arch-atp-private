## Copyright (c) 2021, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

variable "tenancy_ocid" {}
variable "compartment_ocid" {}
variable "region" {}
#variable "fingerprint" {}
#variable "user_ocid" {}
#variable "private_key_path" {}
variable "ATP_password" {}

variable "availability_domain_name" {
  default = ""
}

variable "availability_domain_number" {
  default = 0
}

variable "release" {
  description = "Reference Architecture Release (OCI Architecture Center)"
  default     = "1.5.1"
}

variable "oracle_instant_client_version" {
  #  default     = "21.1"
  default = "19.10"
}

variable "oracle_instant_client_version_short" {
  #  default     = "21"
  default = "19.10"
}

variable "VCN-CIDR" {
  default = "10.0.0.0/16"
}

variable "ATP_PrivateSubnet-CIDR" {
  default = "10.0.2.0/24"
}

variable "Webserver_PublicSubnet-CIDR" {
  default = "10.0.1.0/24"
}

variable "VCNname" {
  default = "VCN"
}

variable "use_existing_vcn" {
  default = false
}

variable "use_existing_nsg" {
  default = false
}

variable "vcn_id" {
  default = ""
}

variable "compute_subnet_id" {
  default = ""
}

variable "compute_nsg_id" {
  default = ""
}

variable "ATP_subnet_id" {
  default = ""
}

variable "ATP_nsg_id" {
  default = ""
}

variable "Shape" {
  default = "VM.Standard.A1.Flex"
}

variable "Shape_flex_ocpus" {
  default = 1
}

variable "Shape_flex_memory" {
  default = 10
}

variable "ssh_public_key" {
  default = ""
}

variable "ATP_free_tier" {
  default = true
}

variable "ATP_private_endpoint" {
  default = true
}

variable "ATP_database_cpu_core_count" {
  default = 1
}

variable "ATP_database_data_storage_size_in_tbs" {
  default = 1
}

variable "ATP_database_db_name" {
  default = "atppriv1"
}

variable "ATP_database_db_version" {
  default = "19c"
}

variable "ATP_database_defined_tags_value" {
  default = ""
}

variable "ATP_database_display_name" {
  default = "atppriv1"
}

variable "ATP_database_freeform_tags" {
  default = {
    "Owner" = "atppriv1"
  }
}

variable "ATP_database_license_model" {
  default = "LICENSE_INCLUDED"
}

variable "ATP_tde_wallet_zip_file" {
  default = "tde_wallet_atppriv1.zip"
}

variable "ATP_private_endpoint_label" {
  default = "ATPPrivateEndpoint1"
}

variable "instance_os" {
  description = "Operating system for compute instances"
  default     = "Oracle Linux"
}

variable "linux_os_version" {
  description = "Operating system version for all Linux instances"
  default     = "7.9"
  #  default     = "8"
}

# Dictionary Locals
locals {
  compute_flexible_shapes = [
    "VM.Standard.E3.Flex",
    "VM.Standard.E4.Flex",
    "VM.Optimized3.Flex",
    "VM.Standard.A1.Flex"
  ]
}

# Checks if is using Flexible Compute Shapes
locals {
  is_flexible_node_shape   = contains(local.compute_flexible_shapes, var.Shape)
  availability_domain_name = var.availability_domain_name == "" ? lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.availability_domain_number], "name") : var.availability_domain_name
  ATP_nsg_id               = !var.use_existing_nsg ? oci_core_network_security_group.ATPSecurityGroup[0].id : var.ATP_nsg_id
  ATP_subnet_id            = !var.use_existing_vcn ? oci_core_subnet.ATPEndpointSubnet[0].id : var.ATP_subnet_id
  vcn_id                   = !var.use_existing_vcn ? oci_core_virtual_network.VCN[0].id : var.vcn_id
}
