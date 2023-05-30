data "aws_ami" "ubuntu_bionic_ami" {
    most_recent = true
    # ubuntu ami account ID
    owners = ["099720109477"]

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
    }
}

resource "aws_instance" "ec2_instance" {
    ami             = data.aws_ami.ubuntu_bionic_ami.id
    instance_type   = var.instance_type
    key_name        = var.key_name
    availability_zone = var.availability_zone
    security_groups = ["${var.sg_name}"]
    tags = {
            Name = "${var.maintainer}-ec2"
    }
    

    root_block_device {
        delete_on_termination = true
    }

    provisioner "local-exec" {
        command = "echo PUBLIC IP: ${var.public_ip} >> IP_ec2.txt"
    }

    provisioner "remote-exec" {
        inline = [
            "sudo apt update -y",
            "sudo apt install -y nginx",
            "sudo systemctl start nginx",
            "sudo systemctl enable nginx"
        ]
        connection {
            type        = "ssh"
            user        = var.user
            private_key = file("../../${var.key_name}.pem")
            host        = self.public_ip
        }
    }
}