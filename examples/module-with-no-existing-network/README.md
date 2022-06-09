## Create ATP with Private Endpoint + network deployed by the module
This is an example of how to use the oci-arch-atp-private module to deploy ATP with Private Endpoint and network cloud infrastructure elements created by the module.
  
### Using this example
Update terraform.tfvars with the required information.

### Deploy the ATP Private Endpoint
Initialize Terraform:
```
$ terraform init
```
View what Terraform plans do before actually doing it:
```
$ terraform plan
```

Create a `terraform.tfvars` file, and specify the following variables:

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

# ATP
ATP_password  = "<ATP_password>"
ATP_free_tier = false
```

Use Terraform to Provision resources:
```
$ terraform apply
```

### Destroy the ATP Private Endpoint

Use Terraform to destroy resources:
```
$ terraform destroy -auto-approve
```
