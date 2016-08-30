# Terraform for Carina

This directory contains Terraform modules that can be used to deploy infrastructure to the Carina container environment using the Terraform Docker provider.  Make sure you have your Carina environment setup before trying to use these modules.  You can follow the steps in [Getting started with Carina](https://getcarina.com/docs/getting-started/getting-started-carina-cli/) to install the carina commandline tool and configure your environment properly.  The modules use the docker environment variables setup when running `eval $(carina env mycluster)`. 

## [MySQL Module](mysql)

This module will build the infrastructure described in [Use MySQL on Carina](https://getcarina.com/docs/tutorials/data-stores-mysql/).  The module as default values for all the parameters that are the same as those on the example page.  To use the module make and save a `.tf` file similar to this one:
```
module "mysql_example" {
    source = "github.com/sandpiper-io/terraform/carina/mysql"
}
```
Then make sure you have the Carina environment setup:
```
$ eval $(carina env YOUR_CLUSTER_NAME)
```
Execute a terraform plan in the directory where you saved the above file to see what will happen:
```
$ terraform plan
```
Finally apply the change:
```
$ terraform apply
```
When completed there will be a file in the current directory called `open_guestbook.sh`.  This file has the URL to your guestbook app on Carina.  If you're on a mac you can open guestbook in a browser by running:
```
$ sh open_guestbook.sh
```
