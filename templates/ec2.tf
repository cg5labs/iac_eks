data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

provider "random" {}

resource "random_pet" "name" {}


resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCKY1FMoHXvdkc5VgNj6sVfswURPwY5NgD5V0lhEFP1quvP90deszyryY9sb4acGPGpea/WyE4td3rRh9MQi6jrIO/Oi5KD5NF3VYYWGdAxAqoe4QNZPYEaAH4CQX6hMzye4eXiGxuoC+/wtlTDvFbHrCUtvvuEvQ1f+w+PKRr0rOC2EZUvdoA2/QV4UdGlbd1DkaWT8W819n6Jmj3VBGTaOUtqDyPJLvZKl4wDEkZhsREAb9kHnRDl1IfvQeWWVMSpQt4RvTJSQKcGy1DHu//c6E2UWZHiMyJ4oGvnZVK5QUh56hTFrvi9Qb+dA8T5Artc4oKEKthKaHgSxeOOw2Zp"
}

resource "aws_instance" "bastion" {
  ami           = data.aws_ami.ubuntu.id
  key_name      = "deployer-key"
  instance_type = "t2.nano"
  monitoring    = true
  vpc_security_group_ids = [aws_security_group.bastion-sg.id]

  tags = {
    Name = random_pet.name.id
  }

}

resource "aws_security_group" "bastion-sg" {
  name = "${random_pet.name.id}-sg"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

