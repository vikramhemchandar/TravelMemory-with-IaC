# Terraform Infrastructure Setup: Implementation Log

This document lists the command execution log and respective outputs for the infrastructure setup phase using Terraform.

---

## 🛠️ Command Log

### 1. Initialize Terraform (`terraform init`)
This command initializes the working directory containing Terraform configuration files and downloads the necessary provider plugins.

**Command:**
```bash
cd terraform
terraform init
```

**Output:**
```text
Initializing the backend...
Initializing provider plugins...
- Finding hashicorp/tls versions matching "~> 4.0"...
- Finding hashicorp/local versions matching "~> 2.0"...
- Finding hashicorp/http versions matching "~> 3.0"...
- Finding hashicorp/aws versions matching "~> 5.0"...
- Installing hashicorp/tls v4.3.0...
- Installed hashicorp/tls v4.3.0 (signed by HashiCorp)
- Installing hashicorp/local v2.9.0...
- Installed hashicorp/local v2.9.0 (signed by HashiCorp)
- Installing hashicorp/http v3.6.0...
- Installed hashicorp/http v3.6.0 (signed by HashiCorp)
- Installing hashicorp/aws v5.100.0...
- Installed hashicorp/aws v5.100.0 (signed by HashiCorp)
Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

---

### 2. Validate Configurations (`terraform validate`)
This command validates the syntax and internal consistency of the configuration files.

**Command:**
```bash
terraform validate
```

**Output:**
```text
Success! The configuration is valid.
```

---

### 3. Generate Execution Plan (`terraform plan`)
This command performs a dry run, querying the active AWS provider state and printing out all the cloud resource additions, deletions, or modifications required to reach the target configuration state.

**Command:**
```bash
terraform plan
```

**Output:**
```text
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_eip.nat will be created
  + resource "aws_eip" "nat" {
      + allocation_id        = (known after apply)
      + association_id       = (known after apply)
      + carrier_ip           = (known after apply)
      + customer_owned_ip    = (known after apply)
      + domain               = "vpc"
      + id                   = (known after apply)
      + instance             = (known after apply)
      + network_border_group = (known after apply)
      + network_interface    = (known after apply)
      + private_dns          = (known after apply)
      + private_ip           = (known after apply)
      + public_dns           = (known after apply)
      + public_ip           = (known after apply)
      + public_ipv4_pool     = (known after apply)
      + tags                 = {
          + "Environment" = "Dev"
          + "Name"        = "travelmemory-nat-eip"
          + "Project"     = "travelmemory"
        }
      + tags_all             = {
          + "Environment" = "Dev"
          + "Name"        = "travelmemory-nat-eip"
          + "Project"     = "travelmemory"
        }
    }

  # aws_iam_instance_profile.ec2_profile will be created
  + resource "aws_iam_instance_profile" "ec2_profile" {
      + arn         = (known after apply)
      + create_date = (known after apply)
      + id          = (known after apply)
      + name        = "travelmemory-ec2-profile"
      + path        = "/"
      + role        = "travelmemory-ec2-role"
      + unique_id   = (known after apply)
    }

  # aws_iam_role.ec2_role will be created
  + resource "aws_iam_role" "ec2_role" {
      + arn                   = (known after apply)
      + assume_role_policy    = jsonencode(
            {
              + Statement = [
                  + {
                      + Action    = "sts:AssumeRole"
                      + Effect    = "Allow"
                      + Principal = {
                          + Service = "ec2.amazonaws.com"
                        }
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + create_date           = (known after apply)
      + force_detach_policies = false
      + id                    = (known after apply)
      + max_session_duration  = 3600
      + name                  = "travelmemory-ec2-role"
      + path                  = "/"
      + unique_id             = (known after apply)
      + tags                   = {
          + "Environment" = "Dev"
          + "Name"        = "travelmemory-ec2-role"
          + "Project"     = "travelmemory"
        }
      + tags_all               = {
          + "Environment" = "Dev"
          + "Name"        = "travelmemory-ec2-role"
          + "Project"     = "travelmemory"
        }
    }

  # aws_iam_role_policy_attachment.ssm_policy will be created
  + resource "aws_iam_role_policy_attachment" "ssm_policy" {
      + id         = (known after apply)
      + policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
      + role       = "travelmemory-ec2-role"
    }

  # aws_instance.db will be created
  + resource "aws_instance" "db" {
      + ami                                  = "ami-0c7217cdde317cfec" # Ubuntu 22.04 LTS (known after lookup)
      + arn                                  = (known after apply)
      + associate_public_ip_address          = false
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + id                                   = (known after apply)
      + instance_type                        = "t2.micro"
      + key_name                             = "travelmemory-key"
      + subnet_id                            = (known after apply)
      + vpc_security_group_ids               = (known after apply)
      ...
      + tags                                 = {
          + "Environment" = "Dev"
          + "Name"        = "travelmemory-db-server"
          + "Project"     = "travelmemory"
          + "Role"        = "database"
        }
    }

  # aws_instance.web will be created
  + resource "aws_instance" "web" {
      + ami                                  = "ami-0c7217cdde317cfec" # Ubuntu 22.04 LTS (known after lookup)
      + arn                                  = (known after apply)
      + associate_public_ip_address          = true
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + id                                   = (known after apply)
      + instance_type                        = "t2.micro"
      + key_name                             = "travelmemory-key"
      + subnet_id                            = (known after apply)
      + vpc_security_group_ids               = (known after apply)
      ...
      + tags                                 = {
          + "Environment" = "Dev"
          + "Name"        = "travelmemory-web-server"
          + "Project"     = "travelmemory"
          + "Role"        = "web"
        }
    }

  # aws_internet_gateway.igw will be created
  + resource "aws_internet_gateway" "igw" {
      + arn      = (known after apply)
      + id       = (known after apply)
      + owner_id = (known after apply)
      + tags     = {
          + "Environment" = "Dev"
          + "Name"        = "travelmemory-igw"
          + "Project"     = "travelmemory"
        }
      + tags_all = {
          + "Environment" = "Dev"
          + "Name"        = "travelmemory-igw"
          + "Project"     = "travelmemory"
        }
      + vpc_id   = (known after apply)
    }

  # aws_key_pair.deployer will be created
  + resource "aws_key_pair" "deployer" {
      + arn             = (known after apply)
      + fingerprint     = (known after apply)
      + id              = (known after apply)
      + key_name        = "travelmemory-key"
      + key_pair_id     = (known after apply)
      + public_key      = (known after apply)
      + tags            = {
          + "Environment" = "Dev"
          + "Name"        = "travelmemory-key"
          + "Project"     = "travelmemory"
        }
      + tags_all        = {
          + "Environment" = "Dev"
          + "Name"        = "travelmemory-key"
          + "Project"     = "travelmemory"
        }
    }

  # aws_nat_gateway.nat will be created
  + resource "aws_nat_gateway" "nat" {
      + allocation_id        = (known after apply)
      + association_id       = (known after apply)
      + connectivity_type    = "public"
      + id                   = (known after apply)
      + network_interface_id = (known after apply)
      + private_ip           = (known after apply)
      + public_ip            = (known after apply)
      + subnet_id            = (known after apply)
      + tags                 = {
          + "Environment" = "Dev"
          + "Name"        = "travelmemory-nat"
          + "Project"     = "travelmemory"
        }
      + tags_all             = {
          + "Environment" = "Dev"
          + "Name"        = "travelmemory-nat"
          + "Project"     = "travelmemory"
        }
    }

  # aws_route_table.private will be created
  + resource "aws_route_table" "private" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + route            = [
          + {
              + carrier_gateway_id         = ""
              + cidr_block                 = "0.0.0.0/0"
              + core_network_arn           = ""
              + destination_prefix_list_id = ""
              + egress_only_gateway_id     = ""
              + gateway_id                 = ""
              + ipv6_cidr_block            = ""
              + local_gateway_id           = ""
              + nat_gateway_id             = (known after apply)
              + network_interface_id       = ""
              + transit_gateway_id         = ""
              + vpc_endpoint_id            = ""
              + vpc_peering_connection_id  = ""
            },
        ]
      + tags             = {
          + "Environment" = "Dev"
          + "Name"        = "travelmemory-private-rt"
          + "Project"     = "travelmemory"
        }
      + tags_all         = {
          + "Environment" = "Dev"
          + "Name"        = "travelmemory-private-rt"
          + "Project"     = "travelmemory"
        }
      + vpc_id           = (known after apply)
    }

  # aws_route_table.public will be created
  + resource "aws_route_table" "public" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + route            = [
          + {
              + carrier_gateway_id         = ""
              + cidr_block                 = "0.0.0.0/0"
              + core_network_arn           = ""
              + destination_prefix_list_id = ""
              + egress_only_gateway_id     = ""
              + gateway_id                 = (known after apply)
              + ipv6_cidr_block            = ""
              + local_gateway_id           = ""
              + nat_gateway_id             = ""
              + network_interface_id       = ""
              + transit_gateway_id         = ""
              + vpc_endpoint_id            = ""
              + vpc_peering_connection_id  = ""
            },
        ]
      + tags             = {
          + "Environment" = "Dev"
          + "Name"        = "travelmemory-public-rt"
          + "Project"     = "travelmemory"
        }
      + tags_all         = {
          + "Environment" = "Dev"
          + "Name"        = "travelmemory-public-rt"
          + "Project"     = "travelmemory"
        }
      + vpc_id           = (known after apply)
    }

  # aws_security_group.web_sg will be created
  + resource "aws_security_group" "web_sg" {
      + arn                    = (known after apply)
      + description            = "Security group for MERN Web Server"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = [
                  + "::/0",
                ]
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "Allow React frontend default port"
              + from_port        = 3000
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 3000
            },
          + {
              + cidr_blocks      = [
                  + "122.164.165.252/32",
                ]
              + description      = "Allow SSH from my IP"
              + from_port        = 22
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 22
            },
            ...
        ]
      + name                   = "travelmemory-web-sg"
      + tags                   = {
          + "Environment" = "Dev"
          + "Name"        = "travelmemory-web-sg"
          + "Project"     = "travelmemory"
        }
      + vpc_id                 = (known after apply)
    }

  # aws_subnet.private will be created
  + resource "aws_subnet" "private" {
      + availability_zone                              = "us-east-1a"
      + cidr_block                                     = "10.0.2.0/24"
      + map_public_ip_on_launch                        = false
      + tags                                           = {
          + "Environment" = "Dev"
          + "Name"        = "travelmemory-private-subnet"
          + "Project"     = "travelmemory"
        }
      + vpc_id                                         = (known after apply)
    }

  # aws_subnet.public will be created
  + resource "aws_subnet" "public" {
      + availability_zone                              = "us-east-1a"
      + cidr_block                                     = "10.0.1.0/24"
      + map_public_ip_on_launch                        = true
      + tags                                           = {
          + "Environment" = "Dev"
          + "Name"        = "travelmemory-public-subnet"
          + "Project"     = "travelmemory"
        }
      + vpc_id                                         = (known after apply)
    }

  # aws_vpc.main will be created
  + resource "aws_vpc" "main" {
      + cidr_block                           = "10.0.0.0/16"
      + enable_dns_hostnames                 = true
      + enable_dns_support                   = true
      + tags                                 = {
          + "Environment" = "Dev"
          + "Name"        = "travelmemory-vpc"
          + "Project"     = "travelmemory"
        }
    }

  # local_file.private_key will be created
  + resource "local_file" "private_key" {
      + content              = (sensitive value)
      + filename             = "./travelmemory-key.pem"
      + file_permission      = "0400"
    }

  # tls_private_key.key will be created
  + resource "tls_private_key" "key" {
      + algorithm                     = "RSA"
      + rsa_bits                      = 4096
    }

Plan: 20 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + database_server_private_ip = (known after apply)
  + detected_client_ip         = "122.164.165.252"
  + ssh_instruction_db         = (known after apply)
  + ssh_instruction_web        = (known after apply)
  + web_server_private_ip      = (known after apply)
  + web_server_public_ip       = (known after apply)

─────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't
guarantee to take exactly these actions if you run "terraform apply" now.
```

---

### 4. Provision Resources (`terraform apply`)
This command applies the changes required to reach the desired state of the configuration.

**Command:**
```bash
terraform apply -auto-approve
```

**Output:**
```diff
+ tls_private_key.key: Creating...
+ tls_private_key.key: Creation complete after 0s [id=1509a7465366746c3cdb58778f58e8e39bfc799c]
+ local_file.private_key: Creating...
+ local_file.private_key: Creation complete after 0s [id=09b2d28b06e734968e64f6654223e9af82a564e9]
+ aws_iam_role.ec2_role: Creating...
+ aws_key_pair.deployer: Creating...
+ aws_vpc.main: Creating...
+ aws_key_pair.deployer: Creation complete after 1s [id=travelmemory-key]
+ aws_iam_role.ec2_role: Creation complete after 2s [id=travelmemory-ec2-role]
+ aws_iam_role_policy_attachment.ssm_policy: Creating...
+ aws_iam_instance_profile.ec2_profile: Creating...
+ aws_iam_role_policy_attachment.ssm_policy: Creation complete after 1s [id=travelmemory-ec2-role-20260703022109211500000001]
+ aws_vpc.main: Still creating... [00m10s elapsed]
+ aws_iam_instance_profile.ec2_profile: Creation complete after 8s [id=travelmemory-ec2-profile]
+ aws_vpc.main: Creation complete after 15s [id=vpc-0ad26deb958592312]
+ aws_internet_gateway.igw: Creating...
+ aws_subnet.private: Creating...
+ aws_subnet.public: Creating...
+ aws_security_group.web_sg: Creating...
+ aws_subnet.private: Creation complete after 2s [id=subnet-0114880c0492e0908]
+ aws_internet_gateway.igw: Creation complete after 2s [id=igw-07ff6176abc6f7aff]
+ aws_eip.nat: Creating...
+ aws_route_table.public: Creating...
+ aws_route_table.public: Creation complete after 3s [id=rtb-0a976319f48c138cc]
+ aws_eip.nat: Creation complete after 3s [id=eipalloc-0e130b08fb43bfe45]
+ aws_security_group.web_sg: Creation complete after 6s [id=sg-087fd8e63191cba19]
+ aws_security_group.db_sg: Creating...
+ aws_subnet.public: Still creating... [00m10s elapsed]
+ aws_security_group.db_sg: Creation complete after 5s [id=sg-00063a1a4845808c5]
+ aws_instance.db: Creating...
+ aws_subnet.public: Creation complete after 13s [id=subnet-0b413d55b01355794]
+ aws_route_table_association.public: Creating...
+ aws_nat_gateway.nat: Creating...
+ aws_instance.web: Creating...
+ aws_route_table_association.public: Creation complete after 1s [id=rtbassoc-0c810e83e3dc87d12]
+ aws_instance.db: Still creating... [00m10s elapsed]
+ aws_nat_gateway.nat: Still creating... [00m10s elapsed]
+ aws_instance.web: Still creating... [00m10s elapsed]
+ aws_instance.db: Still creating... [00m20s elapsed]
+ aws_nat_gateway.nat: Still creating... [00m20s elapsed]
+ aws_instance.web: Still creating... [00m20s elapsed]
+ aws_instance.db: Still creating... [00m30s elapsed]
+ aws_nat_gateway.nat: Still creating... [00m30s elapsed]
+ aws_instance.web: Still creating... [00m30s elapsed]
+ aws_instance.db: Creation complete after 36s [id=i-03ac3968f425c6099]
+ aws_instance.web: Creation complete after 36s [id=i-05cd8aead947166e7]
+ aws_nat_gateway.nat: Still creating... [00m40s elapsed]
+ aws_nat_gateway.nat: Still creating... [00m50s elapsed]
+ aws_nat_gateway.nat: Still creating... [01m00s elapsed]
+ aws_nat_gateway.nat: Still creating... [01m10s elapsed]
+ aws_nat_gateway.nat: Still creating... [01m20s elapsed]
+ aws_nat_gateway.nat: Still creating... [01m30s elapsed]
+ aws_nat_gateway.nat: Still creating... [01m40s elapsed]
+ aws_nat_gateway.nat: Creation complete after 1m48s [id=nat-00c24273bf10d9345]
+ aws_route_table.private: Creating...
+ aws_route_table.private: Creation complete after 3s [id=rtb-00cfb4be9fb2a837e]
+ aws_route_table_association.private: Creating...
+ aws_route_table_association.private: Creation complete after 1s [id=rtbassoc-06f1716888a10068f]

+ Apply complete! Resources: 20 added, 0 changed, 0 destroyed.

+ Outputs:

+ database_server_private_ip = "10.0.2.22"
+ detected_client_ip = "122.164.165.252"
+ ssh_instruction_db = "ssh -i ./travelmemory-key.pem -o ProxyCommand=\"ssh -i ./travelmemory-key.pem -W %h:%p ubuntu@35.170.59.30\" ubuntu@10.0.2.22"
+ ssh_instruction_web = "ssh -i ./travelmemory-key.pem ubuntu@35.170.59.30"
+ web_server_private_ip = "10.0.1.138"
+ web_server_public_ip = "35.170.59.30"
```

