# Input variable definitions

variable "aws_region" {
  description = "AWS region for all resources."
  type        = string
  default     = "us-east-1"
}
variable "vpc_cidr" {
  description = "Vpc cidr"
  type        = string
  default     = "10.0.0.0/16"
}
variable "environment" {
  description = "environment"
  type        = string
  default     = "dev"
}
variable "public_subnets_cidr" {
  description = "public_subnets"
  type        = string
  default     = "10.99.0.0/24"
}
variable "availability_zones" {
  description = "availability_zones"
  type        = string
  default     = "us-east-1"
}
variable "private_subnets_cidr" {
  description = "private_subnets"
  type        = string
  default     = "10.99.3.0/24"
}

variable "kms_master_key" {
  description = "kms_master_key"
  type        = string
  default     = "nuvalencekey"
}

variable "aws_s3control_bucket_lifecycle_configuration" {
  description = "nuva-bucket"
  type        = string
  default     = "nuva-bucket"
}