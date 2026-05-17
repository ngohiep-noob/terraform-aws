resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "artifact" {
  bucket = "${var.project_name}-artifact-${random_id.bucket_suffix.hex}"
  tags   = merge(local.common_tags, { Name = "${var.project_name}-artifact-bucket" })
}

resource "aws_s3_bucket_versioning" "artifact" {
  bucket = aws_s3_bucket.artifact.id

  versioning_configuration {
    status = "Enabled"
  }
}