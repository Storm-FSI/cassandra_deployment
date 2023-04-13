#!/usr/bin/env bash
exec > >(tee /var/log/packer-provisioning.log | logger -t user-data -s 2>/dev/console) 2>&1

yum update -y
