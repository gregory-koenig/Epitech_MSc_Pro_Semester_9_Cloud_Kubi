# INSTALL MINIKUBE (wsl2)

- `curl -sLo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64`
- `chmod +x minikube`
- `sudo mkdir -p /usr/local/bin/`
- `sudo install minikube /usr/local/bin/`

# MINIKUBE COMPLETION (ubuntu)

## bash

`source <(minikube completion bash)`

## zsh

`source <(minikube completion zsh)`

# KUBECTL COMPLETION (ubuntu)

## bash

`source <(kubectl completion bash)`

# delete cache

`minikube cache delete`

# START MINIKUBE (wsl2)

- `minikube start --driver=docker --kubernetes-version=v1.16.10`
- `minikube kubectl`
- or just `minikube start`

# KUBECTL service

- create service `kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.10`
- expose `kubectl expose deployment hello-minikube --type=NodePort --port=8080`
- get url `minikube service hello-minikube --url`
- delete service `kubectl delete services hello-minikube`
- delete hello minikube `kubectl delete deployment hello-minikube`
- stop minikube `minikube stop`
- delete local minikube `minikube delete`

# dashboard

## minikube dashboard

- `minikube dashboard`

## dashboard without minikube

- install last dashboard package

  ```shell
  kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/aio/deploy/recommended.yaml
  ```

- launch kubectl proxy

  ```shell
  kubectl proxy
  ```

- Now access Dashboard at:
  [`http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/`](http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/).

## create token user

- create a `admin-user.yaml` file with

  ```yaml
  apiVersion: v1
  kind: ServiceAccount
  metadata:
  name: admin-user
  namespace: kubernetes-dashboard
  ```

- create a `admin-cluster.yaml` file with

  ```yaml
  apiVersion: rbac.authorization.k8s.io/v1
  kind: ClusterRoleBinding
  metadata:
  name: admin-user
  roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
  subjects:
  - kind: ServiceAccount
  name: admin-user
  namespace: kubernetes-dashboard
  ```

- apply 2 file `kubectl apply -f admin-user.yaml admin-cluster.yaml`

- find the user token

  ```shell
  kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}"
  ```

# KUBECTL

## INFO

- use `watch` before get command for auto update or `-w`

## PODS

- get pods `kubectl get pods`
- create pod `kubectl run myshell -it --image=busybox -- sh` (myshell) is pod name and chose docker image
- resume pod `kubectl attach myshell -c myshell -i -t`
- delete pod `kubectl delete pod myshell`
- exec command `kubectl exec monnginx-66c44797b8-bv48n -it -- /bin/bash`

## DEPLOYMENT

- get deploy `kubectl get deploy`
- create deployment `kubectl create deployment monnginx --image=nginx`
- delete deployment `kubectl delete deployment nginx`
- inspect deployment `kubectl describe deployment monnginx`
- scale deployment `kubectl scale deploy monnginx --replicas=2`

## SERVICE (expose port)

- get service `kubectl get service`
- create service `kubectl create service nodeport monnginx --tcp=8080:80`
- delete service `kubectl delete service monnginx`

## FIX `get hpa` > TARGETS > `<unknown>/80%` :

- download last version of kubernetes metrics server

```shell
curl -L https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml --output components.yaml
```

- add (140) `- --kubelet-insecure-tls` line 140 in components.yaml
- apply the components `kubectl apply -f components.yaml`
- get if `kubectl top node` work
- wait ~ 80s before `<unknown>` change to `(some value)%`

# LOADBALANCER

- in new terminal start tunel `minikube tunnel`
- create deployment `kubectl create deployment hello-minikube1 --image=k8s.gcr.io/echoserver:1.4`
- create load balancer `kubectl expose deployment hello-minikube1 --type=LoadBalancer --port=8080`
- check ip `kubectl get svc`

# AUTOSCALER

- create autoscale `kubectl autoscale deployment hello-minikube1 --cpu-percent=50 --min=1 --max=10`
