# Epitech_MSc_Pro_Semester_9_Cloud_Kubi
Take the helm

# DOCKER

## RUN frontend

- `https://www.indellient.com/blog/how-to-dockerize-an-angular-application-with-nginx/`
- `docker build -t ng-docker-front front`
- `docker run -d -p 8080:80 ng-docker-front:latest`

## RUN backend

- `docker build -t ng-docker-back back`
- `docker run -d -p 8081:80 ng-docker-back`
