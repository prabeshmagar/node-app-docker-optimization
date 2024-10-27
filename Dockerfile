# Stage 1: Build the application
FROM node:19.3.0-alpine3.17 AS build

WORKDIR /usr/src/pimExport

COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Stage 2: Run the application
FROM node:19.3.0-alpine3.17
WORKDIR /usr/src/pimExport

RUN apk add --no-cache libc6-compat curl bash

COPY package*.json ./
RUN npm ci

COPY --from=build /usr/src/pimExport/dist ./dist

# Expose the default port
EXPOSE 3000

# Add a custom entrypoint script
COPY entrypoint.sh /usr/src/pimExport/entrypoint.sh
RUN chmod +x /usr/src/pimExport/entrypoint.sh

ENTRYPOINT ["/usr/src/pimExport/entrypoint.sh"]
