# BUILD PHASE

# tag the first phase container as 'builder'
FROM node:16-alpine as builder 
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# ^^ THIS WILL BE COMPILED IN ./app/build

# RUN PHASE

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# no need to manually start an nginx container, it starts by default