# Select the Node.js base image
FROM node:20

# Create the directory structure
RUN mkdir /zeppelin && chown node:node /zeppelin
USER node

# Copy package files and install dependencies
COPY --chown=node:node package.json package-lock.json /zeppelin/
WORKDIR /zeppelin
RUN npm ci

# Copy the application code
COPY --chown=node:node . /zeppelin

# Build the backend and dashboard
WORKDIR /zeppelin/backend
RUN npm run build
WORKDIR /zeppelin/dashboard
RUN npm run build

# Prune dev dependencies
WORKDIR /zeppelin
RUN npm prune --omit=dev
