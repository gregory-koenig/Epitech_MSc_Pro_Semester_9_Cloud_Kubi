# # BUILD
# FROM node:9.11.2 as build
FROM node:9.11.2

WORKDIR /usr/local/app
COPY package*.json /usr/local/app
RUN npm install
COPY . /usr/local/app

EXPOSE 4200
CMD [ "npm", "run", "start" ]


# RUN npm run build:prod

# NGINX
# FROM nginx:alpine

# COPY nginx.conf /etc/nginx/conf.d/default.conf
# COPY --from=build /usr/local/app/dist/front /usr/share/nginx/html
# ENV API_URL=localhost

# EXPOSE 80
