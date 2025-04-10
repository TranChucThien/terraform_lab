variable "project_name" {
  description = "Project name for the EKS cluster"
  type        = string
  default     = "tct"

}

variable "desired_size" {
  description = "Desired size of the EKS node group"
  type        = number
  default     = 2

}

variable "min_size" {
  description = "Minimum size of the EKS node group"
  type        = number
  default     = 1

}

variable "max_size" {
  description = "Maximum size of the EKS node group"
  type        = number
  default     = 3

}


variable "aws_iam_role_arn" {
  description = "IAM role ARN for the EKS cluster"
  type        = string
  default     = "arn:aws:iam::492804330065:user/thien_tran_devops" # Set this to the IAM role ARN for the EKS cluster
  
}