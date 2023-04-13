# Enable CloudWatch Agent
resource "aws_iam_role_policy_attachment" "attach_cw_policy" {
  role       = aws_iam_role.default.id
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}
