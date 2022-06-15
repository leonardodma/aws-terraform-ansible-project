# Projeto Final - Computação em Núvem

O projeto tem como objetivo estruturar uma infraestrutura com kubernets uitilizando terraform, a fim de fazer Docker conteiners auto-escaláveis para uma aplicação. Para realizar o deploy automático dessa aplicação, foi utilizado o Ansible.

## Para configurar as variáveis de ambiente, com as credencials, foi usado:
```console
$ TF_VAR_AWS_ACCESS_KEY_ID="foo" TF_VAR_AWS_SECRET_ACCESS_KEY="bar" terraform apply
```

## Para aplicar a insfrastrura com o Kubernete Cluster, no diretório raíz do projeto:
```console
$ terraform plan
$ terraform apply
```

## Para fazer o deploy da plicação, auto-escalável, no diretório raíz do projeto:

Foi feito uma [imagem docker](https://hub.docker.com/repository/docker/leonardodma/fastapi-image), com base no projeto feito para a diciplina "Megadados", a partir do [código fonte](https://github.com/leonardodma/ProjetoSQL-Fase2/tree/cloud).

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

Com o Metric Server configurado, é possível testar o auto scale, passando a URL do serviço subido, que no caso é http://a4cea7ba80eee4f16bf825c97749630c-1003223715.us-east-1.elb.amazonaws.com/docs.

```console
$ kubectl run -i --tty load-generator --rm --image=busybox:1.28 --restart=Never -- /bin/sh -c "while sleep 0.001; do wget -q -O- http://a4cea7ba80eee4f16bf825c97749630c-1003223715.us-east-1.elb.amazonaws.com/docs; done"
```

Para observar a escalabilidade:
```console
$ kubectl get horizontalpodautoscaler.autoscaling/fastapi-api --watch
```

# Link da Demonstração 
https://youtu.be/2e0WXBjSkJs
