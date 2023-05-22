golden-image:
	test -e packer-manifest.json || touch packer.manifest.json
	packer init modules/golden_image/
	packer validate -var-file variables.pkrvars.hcl modules/golden_image/
	packer build -var-file variables.pkrvars.hcl modules/golden_image/

check:
	test -e packer-manifest.json || touch packer.manifest.json
	terraform init
	terraform validate

apply: check
	terraform apply -auto-approve

destroy:
	terraform destroy -auto-approve
