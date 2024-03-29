variable "name" {
  description = "the name of your stack, e.g. \"demo\""
}

variable "environment" {
  description = "the name of your environment, e.g. \"prod\""
  default     = "prod"
}

variable "region" {
  description = "the AWS region in which resources are created, you must set the availability_zones variable as well if you define this value to something other than the default"
  default     = "us-east-1"
}

variable "aws-region" {
  type        = string
  description = "AWS region to launch servers."
  default     = "us-east-1"
}

variable "application-secrets" {
  description = "A map of secrets that is passed into the application. Formatted like ENV_VAR = VALUE"
  type        = map
  default     = {}
}

variable "availability_zones" {
  description = "a comma-separated list of availability zones, defaults to all AZ of the region, if set to something other than the defaults, both private_subnets and public_subnets have to be defined as well"
  default     = ["us-east-1a", "us-east-1b"]
}

variable "cidr" {
  description = "The CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "a list of CIDRs for public subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
  default     = ["10.0.16.0/20"]
}

variable "service_desired_count" {
  description = "Number of tasks running in parallel"
  default     = 2
}

variable "langwire_rails_container_port" {
  description = "The port where the Langwire container port (Rails) is exposed"
  default     = 80
}

variable "langwire_nodejs_container_port" {
  description = "The port where the Langwire container port (NodeJS) is exposed"
  default     = 3000
}

variable "parzu_container_port" {
  description = "The port where the ParZu container is exposed"
  default     = 5003
}

variable "redis_container_port" {
  description = "The port where the Redis container is exposed"
  default     = 6379
}

variable "parzu_image_name" {
  description = "Path to the public docker image of Parzu"
  default     = "rsennrich/parzu"
}

variable "task_cpu" {
  description = "The number of cpu units used by the task"
  default     = 512
}

variable "task_memory" {
  description = "The amount (in MiB) of memory used by the task"
  default     = 2048
}

variable "logs_retention_in_days" {
  type        = number
  default     = 30
  description = "Specifies the number of days you want to retain log events"
}

variable "dynamodb_table_name" {
  type        = string
  description = "Specifies which dynamodb table to write to"
}

variable "bucket_name" {
  type        = string
  description = "Specifies the s3 bucket name to use"
}
