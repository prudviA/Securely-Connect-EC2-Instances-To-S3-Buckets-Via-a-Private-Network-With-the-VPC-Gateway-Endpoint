terraform {
    backend "s3" {
        bucket = "my_7bucket4"
        key = "s3/dev/terraform.tfstate"
        region = "us-east-1"
    }

}
