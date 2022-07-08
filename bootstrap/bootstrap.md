# Table of Contents

1. [KUBERNETES BASICS](#kubernetes-basics)
   1. [RUN FOREST, RUN!](#run-forest-run)
   2. [COMMUNICATE](#communicate)
      1. [Environment](#environment)
      2. [Networking](#networking)
      3. [Addressing](#addressing)

# KUBERNETES BASICS

## RUN FOREST, RUN!

### with command line

Create your first pod

```shell
kubectl run forest --image=samber/hello-world-nodejs
```

Print the application logs

```shell
kubectl describe pod forest
```

Then find a way to execute a shell command in

```shell
kubectl exec forest -it -- sh
```

### with yaml

```shell
kubectl get pod forest -o yaml > forest.yaml
```

```shell
kubectl apply -f forest.yaml
```

### now, delete this pod.

```shell
kubectl delete pod forest
```

---

## COMMUNICATE

### Environment

```shell
kubectl run hello-world --image=samber/hello-world-nodejs --env=PORT=8080
```

```shell
kubectl exec hello-world -- printenv
```

### Networking

Display the IP of this container

```shell
kubectl get pods hello-world -o wide
```

Forward pod port to localhost,

```shell
kubectl port-forward hello-world 8080
```

### Addressing

`When you destroy and recreate your pod many times, do you get the same container IP?` => NO (incrementing port ?)

Find a way to create an internal DNS

```shell
kubectl expose pod hello-world --port=8080
```

Start another container and send an HTTP request to hello-world DNS

```shell
kubectl run debian-get --image=debian -- sleep 600;
kubectl exec debian-get -it -- bash
apt update
apt install curl --y
curl hello-world:8080 -> Hello World!
```

---

## PERSIST

```shell
kubectl apply -f persist/persistent-volume.yaml
kubectl apply -f persist/persistent-volume-claim.yaml
kubectl apply -f persist/persistent-pods.yaml
```

## DEPLOYMENTS

---
