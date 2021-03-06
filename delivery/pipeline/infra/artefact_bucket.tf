resource "aws_s3_bucket" "artefact_repository" {
  bucket        = "${var.repo_bucket_name}"
  force_destroy = "true"
  acl           = "private"
  versioning {
    enabled = "true"
  }
  tags {
    Name      = "artefact_repository"
    Estate    = "${var.estate}"
    Component = "${var.component}"
  }
}
