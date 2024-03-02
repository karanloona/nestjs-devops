# Base image for the build stage
FROM node:18 AS build

# Update and install necessary dependencies
RUN apt-get update && apt-get install -yqq --no-install-recommends ca-certificates curl procps && \
    update-ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy application source code
COPY . .

# Build the application
RUN npm run build micro-project
RUN npm run build project

# Production image
FROM node:18

# Set working directory
WORKDIR /usr/src/app

# Copy node_modules and built microservices from the build stage
COPY --from=build /usr/src/app/node_modules /usr/src/app/node_modules
COPY --from=build /usr/src/app/dist/apps/project/main.js /usr/src/app/project.js
COPY --from=build /usr/src/app/dist/apps/micro-project/main.js /usr/src/app/micro-project.js

# Expose ports
EXPOSE 3002 3003

# Install pm2 globally
RUN npm install -g pm2

# Start the application using PM2
CMD ["pm2-runtime", "start", "project.js", "--name", "project"]
CMD ["pm2-runtime", "start", "micro-project.js", "--name", "micro"]

