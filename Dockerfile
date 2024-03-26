# Use Node.js as base image
FROM node:14-alpine as build

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json to container
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the entire project to container
COPY . .

# Build the React app
RUN npm run build

# Use Nginx as base image for serving the React app
FROM nginx:alpine

# Copy the built app to Nginx default public directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
