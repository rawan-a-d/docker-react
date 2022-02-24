# Production file
# Make an image that runs the application specifically in production

# Build phase
# install dependencies and build our application (create a compact folder with only what we need)
# will result in a build directory
FROM node:16-alpine as builder

WORKDIR '/app'

COPY package.json .

RUN npm install

COPY . .

RUN npm run build

# /app/build <---- all the stuff we care about


# Run phase
# https://hub.docker.com/_/nginx
FROM nginx

# Elastic beanstalk will look for this instruction and will map to this port (NOT REQUIRED ANYMORE)
#EXPOSE 80

# Copy build folder from other phase called builder to /user/share/nginx/html
COPY --from=builder /app/build /usr/share/nginx/html

# we don't need to set up a command, because the default command of the container starts nginx