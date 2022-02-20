resource "aws_s3_bucket" "bucket" {
  bucket = "nuvalence-bucket2022"
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = "nuvalence-bucket2022"
  acl    = "private"
}

resource "aws_s3_bucket_lifecycle_configuration" "bucket-config" {
  bucket = "nuvalence-bucket2022"
  rule {
    id = "log"

    expiration {
      days = 30
    }

    filter {
      and {
        prefix = "log/"

        tags = {
          rule      = "log"
          autoclean = "true"
        }
      }
    }

    status = "Enabled"
    transition {
      days          = 20
      storage_class = "GLACIER"
    }
  }

  rule {
    id = "tmp"

    filter {
      prefix = "tmp/"
    }

    expiration {
      date = "2023-01-13T00:00:00Z"
    }

    status = "Enabled"
  }
}

resource "aws_s3_bucket" "versioning_bucket" {
  bucket = "nuvalence-bucket2022"
}

resource "aws_s3_bucket_acl" "versioning_bucket_acl" {
  bucket = "nuvalence-bucket2022"
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = "nuvalence-bucket2022"
  versioning_configuration {
    status = "Enabled"
  }
}
