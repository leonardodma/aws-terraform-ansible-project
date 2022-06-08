# Projeto Final - Computação em Núvem

O projeto tem como objetivo estruturar uma infraestrutura com kubernets uitilizando terraform, a fim de fazer Docker conteiners auto-escaláveis para uma aplicação. Para realizar o deploy automático dessa aplicação, foi utilizado o Ansible.


## Para aplicar a insfrastrura com o Kubernete Cluster, no diretório raíz do projeto:
```console
$ cd ./terraform
$ export AWS_ACCESS_KEY_ID="anaccesskey"
$ export AWS_SECRET_ACCESS_KEY="asecretkey"
$ export AWS_REGION="us-west-1"
$ terraform plan
$ terraform apply
```

## Para fazer o deploy auto-escalável, no diretório raíz do projeto:
```console
$ cd ./deploy
$ ansible-playbook playbook.yml
```

## Configurar o metrics Server, para poder observer o Auto Scale
```console
$ kubectl edit deploy -n kube-system metrics-server
```

Esse comando abrirá um arquivo de configuração, o qual permite que o metric server consiga observar os parâmentros do auto-scale. Será necessário adicionar as linhas seguintes, abaixo da linha "- --metric-resolution=15s", na mesma identação que "args:":

```yml
command:
    - /metrics-server
    - --kubelet-insecure-tls
```

Após isso, adicionar a linha seguinte, abaixo da linha "dnsPolicy: ClusterFirst":

```yml
hostNetwork: true
```

Com o Metric Server configurado, é possível testar o auto scale, passando a URL do serviço subido, que no caso é http://af24069e6d97b4ab789a96ee6cb4aa9e-2031127855.us-east-1.elb.amazonaws.com/docs.

```console
$ kubectl run -i --tty load-generator --rm --image=busybox:1.28 --restart=Never -- /bin/sh -c "while sleep 0.001; do wget -q -O- http://af24069e6d97b4ab789a96ee6cb4aa9e-2031127855.us-east-1.elb.amazonaws.com/docs; done"
```