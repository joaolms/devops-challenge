golden-image:
	packer validate packer.json
	packer build packer.json

check:
	terraform init
	terraform validate
	terraform plan

apply:
	terraform apply

destroy:
	terraform destroy
