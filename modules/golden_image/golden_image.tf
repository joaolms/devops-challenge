data "local_file" "packer_manifest" {
  filename = "${var.manifest_path}/packer-manifest.json"
}
