include "root"{
  path = find_in_parent_folders()
}
dependencies {
  paths = ["../network"]
}
dependency "vpc" {
  config_path = "../network"
  /*
  skip_outputs = true
  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    vpc_id = "fake-vpc-id"
    private_subnet_ids = "fake-subnets"
    alarm_sns_topic = "fake-topic"
  }
  */
}
inputs = {
  vpc_id = dependency.vpc.outputs.vpc_id
  private_subnet_ids =  split(",", dependency.vpc.outputs.private_subnet_ids)
  alarm_sns_topic = dependency.vpc.outputs.alarm_sns_topic
}
