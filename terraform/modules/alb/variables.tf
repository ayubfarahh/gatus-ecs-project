variable "vpc_id" {
  type = string

}

variable "pub_subnets" {
  type = list(string)

}

variable "acm_arn" {
  type = string
  
}