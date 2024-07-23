# terraform-oci-arch-atp-private

Deploy Private Endpoint for Autonomous Database to take advantage of the fully managed, preconfigured database environment of Oracle Autonomous Database in private subnets of Oracle Cloud Infrastructure. This reference architecture deploys Autonomous Private Endpoint and Flask-based Webserver on Oracle Cloud Infrastructure. 

For details of the architecture, see [_Deploy Private Endpoints for Autonomous Database_](https://docs.oracle.com/en/solutions/autonomous-db-private-endpoint/index.html)

## Architecture Diagram

![](./images/oci-arch-atp-private.png)

## Prerequisites

- Permission to `manage` the following types of resources in your Oracle Cloud Infrastructure tenancy: `vcns`, `internet-gateways`, `route-tables`, `network-security-groups`, `subnets`, `autonomous-database-family`, and `instances`.

- Quota to create the following resources: 1 VCN, 2 subnets, 1 Internet Gateway, 1 NAT Gateway, 2 route rules, 1 ATP database instance, and 1 compute instance.

If you don't have the required permissions and quota, contact your tenancy administrator. See [Policy Reference](https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Reference/policyreference.htm), [Service Limits](https://docs.cloud.oracle.com/en-us/iaas/Content/General/Concepts/servicelimits.htm), [Compartment Quotas](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/resourcequotas.htm).

## Deploy Using Oracle Resource Manager

1. Click [![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?region=home&zipUrl=https://github.com/oracle-devrel/terraform-oci-arch-atp-private/releases/latest/download/terraform-oci-arch-atp-private-stack-latest.zip)

    If you aren't already signed in, when prompted, enter the tenancy and user credentials.

2. Review and accept the terms and conditions.

3. Select the region where you want to deploy the stack.

4. Follow the on-screen prompts and instructions to create the stack.

5. After creating the stack, click **Terraform Actions**, and select **Plan**.

6. Wait for the job to be completed, and review the plan.

    To make any changes, return to the Stack Details page, click **Edit Stack**, and make the required changes. Then, run the **Plan** action again.

7. If no further changes are necessary, return to the Stack Details page, click **Terraform Actions**, and select **Apply**. 

## Deploy Using the Terraform CLI

### Clone the Module
Now, you'll want a local copy of this repo. You can make that with the commands:

    git clone https://github.com/oracle-devrel/terraform-oci-arch-atp-private.git
    cd terraform-oci-arch-atp-private
    ls

### Set Up and Configure Terraform

1. Complete the prerequisites described [here](https://github.com/cloud-partners/oci-prerequisites).

2. Create a `terraform.tfvars` file, and specify the following variables:

```
# Authentication
tenancy_ocid         = "<tenancy_ocid>"
user_ocid            = "<user_ocid>"
fingerprint          = "<finger_print>"
private_key_path     = "<pem_private_key_path>"

# Region
region = "<oci_region>"

# Compartment
compartment_ocid = "<compartment_ocid>"

# ATP password
ATP_password = "<ATP_password>"
````

### Create the Resources
Run the following commands:

    terraform init
    terraform plan
    terraform apply

### Destroy the Deployment
When you no longer need the deployment, you can run this command to destroy the resources:

    terraform destroy

## Deploy as a Module
It's possible to utilize this repository as remote module, providing the necessary inputs:

```
module "oci-arch-atp-private" {
  source           = "github.com/oracle-devrel/terraform-oci-arch-atp-private"
  tenancy_ocid     = "<tenancy_ocid>"
  user_ocid        = "<user_ocid>"
  fingerprint      = "<user_ocid>"
  region           = "<oci_region>"
  private_key_path = "<private_key_path>"
  compartment_ocid = "<compartment_ocid>"
  ATP_password     = "<ATP_password>"
}
```

## Contributing
This project is open source.  Please submit your contributions by forking this repository and submitting a pull request!  Oracle appreciates any contributions that are made by the open source community.

### Attribution & Credits
Initially, this project was created and distributed in [GitHub Oracle QuickStart space](https://github.com/oracle-quickstart/oci-arch-atp-private). For that reason, we would like to thank all the involved contributors enlisted below:
- Lukasz Feldman (https://github.com/lfeldman)
- Flavio Pereira (https://github.com/flavio-santino)
- Nuno Gonçalves (https://github.com/nugoncal)

## License
Copyright (c) 2024 Oracle and/or its affiliates.

Licensed under the Universal Permissive License (UPL), Version 1.0.

See [LICENSE](LICENSE) for more details.


