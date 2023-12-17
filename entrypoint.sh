#!/bin/sh

# Replace placeholders in the Nginx template with actual values
sed -e "s/\${DOMAIN}/${DOMAIN}/" \
    -e "s/\${CERT_PATH}/${CERT_PATH}/" \
    -e "s/\${KEY_PATH}/${KEY_PATH}/" \
    /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

# Display the generated nginx.conf for debugging (optional)
cat /etc/nginx/nginx.conf

# Start Nginx
nginx -g 'daemon off;'
