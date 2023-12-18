# Use the official Nginx image as the base image
FROM nginx:alpine

# Install Certbot
RUN apk add --no-cache certbot

# Copy the index.html file to the default Nginx HTML directory
COPY index.html /usr/share/nginx/html

# Copy the custom nginx.conf file to the /etc/nginx/ directory
COPY nginx.conf /etc/nginx/nginx.conf

# Expose ports 80 and 443
EXPOSE 80
EXPOSE 443

# Set the entry point to start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
