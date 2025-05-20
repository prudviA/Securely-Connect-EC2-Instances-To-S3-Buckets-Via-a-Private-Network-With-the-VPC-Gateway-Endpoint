output "bastion_public_ip" {
    value = aws_instance.bastion_host.public_ip
}

output "private_instance_id" {
    value = aws_instance.private_instance.id
}

output "my-s23-bucket" {
    value = aws_s3_bucket.my_7bucket4.id
}

output "vpc_id" {
    value = aws_vpc.s3_vpc.id
}
output "public_subnet_id" {
    value = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
    value = aws_subnet.private_subnet.id
}

output "s3_vpc_endpoint" {
    value = aws_vpc_endpoint_s3.id
}

output "instance_profile_name" {
    value = aws_iam_instance_profile.s3_profile.name
}