#!/bin/zsh

# helm repo add elastic https://helm.elastic.co

# Delete app
# helm delete elasticsearch -n app --wait;
# helm delete rabbitmq -n app --wait;
# helm delete mysql -n app --wait;
# helm delete kubi-api -n app --wait;
# helm delete kubi-front -n app --wait;
# helm delete kubi-indexer -n app --wait;
# helm delete reporting -n app --wait;

# Deploy app
kubectl apply -f ./secret.yaml
helm install elasticsearch elastic/elasticsearch --create-namespace -n app -f elasticsearch/elasticsearch.yaml --wait;
helm install rabbitmq --create-namespace --namespace app -f rabbitmq/rabbitmq.yaml bitnami/rabbitmq --wait;
helm install mysql --create-namespace --namespace app bitnami/mysql -f mysql/mysql-pv.yaml -f mysql/mysql-pvc.yaml -f mysql/mysql.yaml --wait;
helm install kubi-api --create-namespace --namespace app app-backend/ --wait;
helm install kubi-front --create-namespace --namespace app app-frontend/ --wait;
helm install kubi-indexer --create-namespace --namespace app app-indexer/ --wait;
helm install kubi-reporting --create-namespace --namespace app app-reporting/ --wait;
