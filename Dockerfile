# Use the official Nginx image as the base image
FROM nginx:alpine

# Copy the index.html file to the default Nginx HTML directory
COPY index.html /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Set the entry point to start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
