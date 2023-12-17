# Use the official Nginx image as the base image
FROM nginx:alpine

# Copy the index.html file to the default Nginx HTML directory
COPY index.html /usr/share/nginx/html

# Copy the custom nginx.conf.template to the /etc/nginx/ directory
COPY nginx.conf.template /etc/nginx/nginx.conf.template

# Copy the entrypoint.sh script to the image and make it executable
COPY entrypoint.sh /usr/sbin/entrypoint.sh
RUN chmod +x /usr/sbin/entrypoint.sh

# Expose ports 80 and 443
EXPOSE 80
EXPOSE 443

# Set the entry point to the custom script
ENTRYPOINT ["/usr/sbin/entrypoint.sh"]
