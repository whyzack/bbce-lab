resource "aws_ecr_repository" "ecr" {
  for_each = var.ecr
  name                 = each.value.name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

variable "ecr" {
  type = map(object({
    name = string
  }))
    default = {
      frontend = {
        name = "bbce_front"
      }
      reader = {
        name = "bbce_reader"
      }
      writer = {
        name = "bbce_writer"
      }
    }
}