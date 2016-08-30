# Terraform for Carina

This directory contains Terraform modules that can be used to deploy infrastructure to the Carina container environment.  Make sure you have your Carina environment setup before trying to use these modules.  You can follow the steps in [Getting started with Carina](https://getcarina.com/docs/getting-started/getting-started-carina-cli/) to install the carina commandline tool and configure your environment properly.  The modules use the docker environment variables setup when running `eval $(carina env mycluster)`. 

## [MySQL Module](mysql)

This module will build the infrastructure described in [Use MySQL on Carina](https://getcarina.com/docs/tutorials/data-stores-mysql/).  The module as default values for all the parameters that are the same as those on the example page. 