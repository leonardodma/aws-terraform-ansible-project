# Projeto Final - Computação em Núvem

O projeto tem como objetivo estruturar uma infraestrutura com kubernets uitilizando terraform, a fim de fazer Docker conteiners auto-escaláveis para uma aplicação. Para realizar o deploy automático dessa aplicação, foi utilizado o Ansible.


## Para aplicar a insfrastrura com o Kubernete Cluster, no diretório raíz do projeto:
```console
$ cd ./terraform
$ export AWS_ACCESS_KEY_ID="anaccesskey"
$ export AWS_SECRET_ACCESS_KEY="asecretkey"
$ export AWS_REGION="us-west-2"
$ terraform plan
$ terraform apply
```

## Para fazer o deploy auto-escalável, no diretório raíz do projeto:
```console
$ cd ./deploy
$ ansible-playbook playbook.yml
```