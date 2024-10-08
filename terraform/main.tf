terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "4.0"
        }
    }
    backend "s3" {
        bucket = "TO_BE_DEFINED_LATER"
        key = "aws/ec2-deploy/terraform.tfstate"
        region = "TO_BE_DEFINED_LATER"
    }
}
provider "aws" {
    region = var.region
}
resource "aws_instance" "server" {
    ami = "ami-0e86e20dae9224db8"
    instance_type = "t2.micro"
    key_name = aws_key_pair.deployer.key_name
    vpc_security_group_ids = [aws_security_group.maingoup.id]
    iam_instance_profile = aws_iam_instance_profile.ec2-profile.name
    connection {
        type = "ssh"
        host = self.public_ip
        user = "ubuntu"
        private_key = var.private_key
        timeout = "4m"
    }
    tags = {
        "name" = "DeployVM"
    }
}
resource "aws_iam_instance_profile" "ec2-profile"{
    name = "ec2-profile"
    role = "EC2-ECR-AUTH"
}

resource "aws_security_group" "maingoup" {
    egress = [
        {
            cidr_blocks      = ["0.0.0.0/0"]
            description      = ""
            from_port        = 0
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "-1"
            security_groups  = []
            self             = false
            to_port          = 0
        }
    ]
    ingress = [
                {
            cidr_blocks      = ["0.0.0.0/0"]
            description      = ""
            from_port        = 22
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 22
        },
        {
            cidr_blocks      = ["0.0.0.0/0"]
            description      = ""
            from_port        = 80
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 80
        }
    ]
}


resource "aws_key_pair" "deployer"{
    key_name   = var.key_name
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDCHnkMaUmdnhyuJ7qKZREQmoT6qUvf2MvA1HqCpiMAFaQnjalx9etqHgpfE7yahypy1YyiL9/cOsUdUfsaD6eBvHQ3ko761E6Md5MrdR1Xhl/8arE3HfwgkMOWYLtNlfI1qzE8EBfVstk9SdlCgOvcm/91evpAqD7OuzbdamWjw0TeZJP2d5vcM6CijrpkMIcRjlZ6jvrdrk6SOighI23WQbufHdYk5E9cTRlf9Az88qnobTvZ7P+Lf191d3RIhH4cfptOLp1H4qgjaYJ2ZKKu93RlBu6croCV9z//Nzr7XEjMJT3h9oIC8KYLcfkhjuJMEhEbQIQEz8xHmOi2N3bpdgLc1n7DmMYibstJHlyzt8ztHJSxBTZY/I5s1BtEHTzgUAVXG4w5EmIlcQ62Dt0AEwJ/1lrqp47+03Ov9/DesvkSe6NlFW/0GZOyvnSc7H7E7KW1KSy7FD3tybQn59LpNNcenHyeSsc2yYbruje7MLdk+Ih0BgJnKCVpzr6f7RM= junu@abrar-21141023"
}

output "instance_public_ip" {
    value     = aws_instance.server.public_ip
    sensitive = true
}