
resource "aws_iam_user" "api_user" {
  count = "${length(var.spin_api_users)}"
  name = "${var.spin_api_users[count.index]}"
  force_destroy = true
}

resource "aws_iam_group" "spin_api_users" {
  name = "spin_api_users-${var.component}"
}

resource "aws_iam_group_membership" "spin_api_users" {
  name = "api_user-membership-${var.component}"
  users = [ "${aws_iam_user.api_user.*.name}" ]
  group = "${aws_iam_group.spin_api_users.name}"
}

resource "aws_iam_group_policy" "rights_to_assume_role" {
  name  = "rights_to_assume_role-${var.component}"
  group = "${aws_iam_group.spin_api_users.id}"
  policy = <<ENDOFPOLICY
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Action": [ "iam:GetUser", "iam:GetRole" ],
    "Resource": "*"
  }
}
ENDOFPOLICY
}

resource "aws_iam_access_key" "api_user" {
  count = "${length(var.spin_api_users)}"
  user    = "${aws_iam_user.api_user.*.name[count.index]}"
  pgp_key = "${var.pgp_key_for_secrets}"
}

output "api_user_arn" {
  value = ["${aws_iam_user.api_user.*.arn}"]
}

output "aws_access_key_id" {
  value = "${aws_iam_access_key.api_user.*.id}"
}

output "aws_secret_access_key_encrypted" {
  value = "${aws_iam_access_key.api_user.*.encrypted_secret}"
}

