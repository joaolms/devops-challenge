locals {
  default_content = ""
}

data "local_file" "packer_manifest" {
  filename = fileexists("${var.manifest_path}/packer-manifest.json") ? file("${var.manifest_path}/packer-manifest.json") : local.default_content
}
