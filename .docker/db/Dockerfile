FROM postgres:14-alpine

# Install PostgreSQL contrib package
RUN apk add --no-cache postgresql-contrib

# Copy the custom entrypoint script to create a database based on environment variables
COPY init-db.sh /docker-entrypoint-initdb.d/

# Set permissions for the script (optional but recommended)
RUN chmod +x /docker-entrypoint-initdb.d/init-db.sh
