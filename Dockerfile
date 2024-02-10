# Base image
FROM node:18

# Create app directory
WORKDIR /usr/src/app

# A wildcard is used to ensure both package.json AND package-lock.json are copied
COPY package*.json ./

RUN npm i -g pm2

# Install app dependencies
RUN npm install

# Bundle app source
COPY . .


# Creates a "dist" folder with the production build
RUN npm run build

# Expose the port on which the app will run
EXPOSE 3000

# Start the application using PM2
CMD ["npm", "run", "start"]