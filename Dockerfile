# First phase to build based on dependencies
FROM node:alpine
WORKDIR /app
COPY ./package.json ./
RUN npm install
COPY ./ ./
RUN npm run build

# Second phase to copy built files and start nginx
FROM nginx
EXPOSE 80
COPY --from=0 /app/build /usr/share/nginx/html
# Note: nginx will start as the default command in an container ran from 'nginx' image