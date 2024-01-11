resource "aws_instance" "my_instance" {
  ami           = "ami-0a7cf821b91bcccbc"
  count = 1
  instance_type = "t2.micro"
  key_name      = "RJAWS"

  tags = {
    Name = "First_Terraform_resource_creation"
  }
}