resource "aws_s3_bucket" "frontend" {
  bucket = var.frontend_bucket_name
  force_destroy = true
  tags = {
    Name = "frontend"
  }
}