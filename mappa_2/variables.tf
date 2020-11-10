variable "env" {
  type = string
  default = "dev"
}

variable "project_name" {
  type = string
  default = "test_mappa_2"
}

variable "resource_tags" {
  type    = map(string)
  default = {}
}