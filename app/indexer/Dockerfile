FROM node:fermium-alpine

WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install
COPY . .

CMD ["yarn", "start"]
