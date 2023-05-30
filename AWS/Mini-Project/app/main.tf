provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["./aws_credentials"]
}

# Création du sg
module "sg" {
  source = "../modules/sg"
}

# Création du volume
module "ebs_volume" {
  source    = "../modules/ebs_volume"
  volume_size = 5
}

# Création de l'EIP
module "elastic_ip" {
  source = "../modules/elastic_ip"
}

# Création de l'EC2
module "ec2" {
  source        = "../modules/ec2"
  instance_type = "t2.micro"
  sg_name       = module.sg.output_sg_name

}

#Creation des associations nécessaires
resource "aws_eip_association" "eip_assoc" {
  instance_id   = module.ec2.output_ec2_id
  allocation_id = module.elastic_ip.output_elastic_id
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = module.ebs_volume.output_id_volume
  instance_id = module.ec2.output_ec2_id
}
