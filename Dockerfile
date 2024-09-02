# base image
FROM node:22-alpine as build

# set working directory
WORKDIR /usr/src/app

# install and cache app dependencies
COPY package*.json ./
RUN npm install
COPY . .

# build app
RUN npm install -g @angular/cli
RUN ng build --prod

# stage 2 - the production environment
FROM nginx:alpine
COPY --from=build /usr/src/app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
