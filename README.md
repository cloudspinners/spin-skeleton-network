This project has code that can be copied into a [rake_cloudspin](https://github.com/cloudspinners/rake_cloudspin) component definition project to define a stack for essential networking. You can then modify the code in here to suit your purposes.

The main infrastructure elements defined in this project are a VPC and subnets.

NOTE: This code is not production ready. It is being used to experiment with how to implement the ideas here. So it is constantly changing, with no promise that it will remain consistent, coherent, or even working. It should be considered as an example, and something you might copy, modify, and use with caution.

It includes Inspec tests to validate things.


## What's in here


# Prerequisites

This skeleton component includes the [spin-skeleton-aws-users](https://github.com/cloudspinners/spin-skeleton-aws-users), itself a skeleton that sets up basic roles and policies. See the documentation of that project for information about bootstrapping any AWS account you want to provision this code in. You will want to edit `users.yaml` to have only the IAM users for yourself and any other people working on your project with you.


# Usage

## Configuring


## Applying

```bash
./go deployment:network:plan
# Evaluate the output before proceeding, then:
./go deployment:network:provision
# Evaluate the output before proceeding, then:
./go deployment:network:test
```
