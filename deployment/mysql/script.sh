#helm install mysql --set mysqlRootPassword=rootpassword,mysqlUser=mysql,mysqlPassword=my-password,mysqlDatabase=mydatabase bitnami/mysql -f mysql-pv.yaml -f mysql-pvc.yaml -f mysql.yaml

helm delete mysql
kubectl delete pvc --all;

helm install mysql bitnami/mysql -f mysql-pv.yaml -f mysql-pvc.yaml -f mysql.yaml

# This will be the example used in the Gitlab
# helm install mysql --set auth.rootPassword=rootpass1,auth.database=db_host1 bitnami/mysql -f mysql-pv.yaml -f mysql-pvc.yaml -f mysql.yaml
