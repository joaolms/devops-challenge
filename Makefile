golden-image:
	packer validate packer.json
	packer build packer.json

apply:
	terraform init
	terraform validate
	terraform plan

destroy:
	terraform destroy