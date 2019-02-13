#-------------------------------
# Create ProxiSuite-Experimental EC2 Instances
#-------------------------------
# Security Group for the Suite Server node
resource "aws_security_group" "suite_app_sg" {
  name        = "suite-ec2-sg"
  description = "Security group for the ProxiSuite-Experimental App Server"

  // suite-system - Singapore
  vpc_id = "${data.terraform_remote_state.vpc.vpc_id}"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Project = "ProxiSuite-Experimental"
  }
}

# Create Keypair
resource "aws_key_pair" "suite_app_public_key" {
  key_name   = "suite-ec2-public-key"
  public_key = "${file(var.suite_app_public_key)}"
}

# ProxiSuite-Experimental Dev Server 
resource "aws_instance" "suite_app" {
  instance_type = "${var.suite_app_ec2_type}"
  key_name      = "${aws_key_pair.suite_app_public_key.key_name}"

#  // Ubuntu 18.04 LTS AMI Singapore Region - ami-0c5199d385b432989
  ami = "ami-0c5199d385b432989"

  vpc_security_group_ids = ["${aws_security_group.suite_app_sg.id}"]

#  // public subnet
  subnet_id = "${data.terraform_remote_state.vpc.public_subnet_ids[0]}" 

  associate_public_ip_address = true
  disable_api_termination     = false

  tags = {
    Name = "${terraform.workspace}-suite-app"
  }
}
