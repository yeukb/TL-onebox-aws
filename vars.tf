variable "aws_access_key" { }

variable "aws_secret_key" { }

variable "vpc_name" { }

variable "region" { }

variable "adminUsername" { }

variable "adminPassword" { }

variable "aws_ssh_key" { }

variable "AllowedSourceIPRange" { }

variable "vmName" {
    default = "onebox"
}

variable "vmSize" { }

variable "vpc_cidr" {
    default = "10.100.0.0/16"
}

variable "linux_subnet" {
    default = "10.100.100.0/24"
}

variable "linux_ip" {
    default = "10.100.100.10"
}

variable "twistlock_download_url" { }

variable "license_key" { }

variable "ubuntu_version" {
  default = "20.04"
}
