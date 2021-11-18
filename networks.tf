## Copyright (c) 2021, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_core_virtual_network" "VCN" {
  count          = !var.use_existing_vcn ? 1 : 0
  cidr_block     = var.VCN-CIDR
  dns_label      = "VCN"
  compartment_id = var.compartment_ocid
  display_name   = "VCN"
  defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_core_dhcp_options" "DhcpOptions1" {
  count          = !var.use_existing_vcn ? 1 : 0
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.VCN[0].id
  display_name   = "DHCPOptions1"

  // required
  options {
    type        = "DomainNameServer"
    server_type = "VcnLocalPlusInternet"
  }

  // optional
  options {
    type                = "SearchDomain"
    search_domain_names = ["example.com"]
  }
}

resource "oci_core_nat_gateway" "NATGateway" {
  count          = !var.use_existing_vcn ? 1 : 0
  compartment_id = var.compartment_ocid
  display_name   = "NATGateway"
  vcn_id         = oci_core_virtual_network.VCN[0].id
  defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_core_internet_gateway" "InternetGateway" {
  count          = !var.use_existing_vcn ? 1 : 0
  compartment_id = var.compartment_ocid
  display_name   = "InternetGateway"
  vcn_id         = oci_core_virtual_network.VCN[0].id
  defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_core_route_table" "RouteTableViaIGW" {
  count          = !var.use_existing_vcn ? 1 : 0
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.VCN[0].id
  display_name   = "RouteTableViaIGW"
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.InternetGateway[0].id
  }
  defined_tags = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_core_route_table" "RouteTableViaNAT" {
  count          = !var.use_existing_vcn ? 1 : 0
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.VCN[0].id
  display_name   = "RouteTableViaNAT"
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.NATGateway[0].id
  }
  defined_tags = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_core_subnet" "WebSubnet" {
  count           = !var.use_existing_vcn ? 1 : 0
  cidr_block      = var.Webserver_PublicSubnet-CIDR
  display_name    = "WebSubnet"
  dns_label       = "fkN1"
  compartment_id  = var.compartment_ocid
  vcn_id          = oci_core_virtual_network.VCN[0].id
  route_table_id  = oci_core_route_table.RouteTableViaIGW[0].id
  dhcp_options_id = oci_core_dhcp_options.DhcpOptions1[0].id
  defined_tags    = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_core_subnet" "ATPEndpointSubnet" {
  count                      = !var.use_existing_vcn ? 1 : 0
  cidr_block                 = var.ATP_PrivateSubnet-CIDR
  display_name               = "ATPEndpointSubnet"
  dns_label                  = "fkN2"
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_virtual_network.VCN[0].id
  route_table_id             = oci_core_route_table.RouteTableViaNAT[0].id
  dhcp_options_id            = oci_core_dhcp_options.DhcpOptions1[0].id
  prohibit_public_ip_on_vnic = true
  defined_tags               = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}
