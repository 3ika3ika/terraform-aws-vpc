variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "region" {
  description = "ID of the VPC"  
}

variable "instance_type" {
  description = "ID of the VPC"
  type        = string
  default     = "t2.micro"
}



variable "subnet_ids" {
  description = "ID of the VPC"
  type        = list(string)
}

variable "name" {
  description = "The name of the VPC"
  type        = string
}

variable "key_name" {
  type        = string
}