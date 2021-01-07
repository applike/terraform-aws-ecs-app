variable "project" {
  type        = string
  default     = null
  description = "Project, which could be your organization name or abbreviation, e.g. 'eg' or 'cp'"
}

variable "environment" {
  type        = string
  default     = null
  description = "Environment, e.g. 'uw2', 'us-west-2', OR 'prod', 'staging', 'dev', 'UAT'"
}

variable "family" {
  type        = string
  default     = null
  description = "Family, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release'"
}

variable "application" {
  type        = string
  default     = null
  description = "Solution application, e.g. 'app' or 'jenkins'"
}

variable "environment_variables" {
  type = list(object({
    name  = string
    value = string
  }))
  description = "The environment variables to pass to the container. This is a list of maps. map_environment overrides environment"
  default     = []
}

variable "secrets" {
  type = list(object({
    name      = string
    valueFrom = string
  }))
  description = "The secrets to pass to the container. This is a list of maps"
  default     = null
}

variable "image_tag" {
  type        = string
  description = "The container image tag for the ECS task definition"
  default     = null
}

variable "enable_image_tag" {
  type        = bool
  description = "Set it to 'true' for parsing in a custom 'image_tag'"
  default     = false
}

variable "target_group_arn" {
  type        = string
  description = "The ARN of the Target Group to which to route traffic"
  default     = ""
}

variable "ulimits" {
  type = list(object({
    name      = string
    hardLimit = number
    softLimit = number
  }))
  description = "Container ulimit settings. This is a list of maps, where each map should contain \"name\", \"hardLimit\" and \"softLimit\""
  default     = null
}