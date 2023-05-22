# nttdata-challenge

<h1 align="center">NTTDATA Challenge 👋</h1>

### ✨ [Demo](/)

## Input variables

network_cidr = "172.16.0.0/16"
n_subnets    = 6
name         = "galp"
tags = {
  "iac" = "true"
  "environment" = "demo"
}


```sh
make golden-image
```

## Terraform

```sh
make apply
```

## Adicionando o contexto do nosso cluster ao kubectl

```bash
aws eks --region us-east-1 update-kubeconfig --name nome-do-cluster
aws eks --region us-east-1 update-kubeconfig --name k8s-demo
```

```bash
kubectl get nodes
```

## Deploy o Ingress

```bash
kubectl apply -f kubernetes/traefik/ingress.yml
```

## Deploy demo services

* [Whois App](https://github.com/msfidelis/microservice-nadave-whois)
* [Faker App](https://github.com/msfidelis/microservice-nadave-fake-person)
* [Pudim](https://github.com/msfidelis/pudim)

```bash
kubectl apply -f kubernetes/apps/whois.yml
kubectl apply -f kubernetes/apps/faker.yml
kubectl apply -f kubernetes/apps/pudim.yml
```

## Deploy do Metric Server

```bash
kubectl apply -f kubernetes/metric-server/metric-server.yml
```

## Author

👤 **Matheus Fidelis**

* Website: https://raj.ninja
* Twitter: [@fidelissauro](https://twitter.com/fidelissauro)
* Github: [@msfidelis](https://github.com/msfidelis)
* LinkedIn: [@msfidelis](https://linkedin.com/in/msfidelis)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!<br />Feel free to check [issues page](/issues). 

## Show your support

Give a ⭐️ if this project helped you!

## 📝 License

Copyright © 2020 [Matheus Fidelis](https://github.com/msfidelis).<br />
This project is [MIT](LICENSE) licensed.

***
_This README was generated with ❤️ by [readme-md-generator](https://github.com/kefranabg/readme-md-generator)_