data "local_file" "packer_manifest" {
  filename = "${var.manifest_path}/packer-manifest.json"
}

resource "terraform_data" "bootstrap" {
  triggers_replace = [
    var.vpc_id
  ]

  provisioner "local-exec" {
    command = "make golden-image"
  }
}
