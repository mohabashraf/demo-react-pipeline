FROM node:13.12.0-alpine

# set working directory
WORKDIR /frontendApp

# add `/app/node_modules/.bin` to $PATH
ENV PATH /frontendApp/node_modules/.bin:$PATH

# install app dependencies
COPY ./package.json ./
RUN npm install --silent
RUN npm install react-scripts@3.4.1 -g --silent

RUN node -v

# add app
COPY . ./

# start app
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=0 frontendApp/build /usr/share/nginx/html