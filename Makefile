golden-image:
	packer init ./modules/golden_image/webserver.pkr.hcl
	packer validate ./modules/golden_image/webserver.pkr.hcl
	packer build ./modules/golden_image/webserver.pkr.hcl

check:
	terraform init
	terraform validate

apply: check
	terraform apply -auto-approve

destroy:
	terraform destroy -auto-approve
