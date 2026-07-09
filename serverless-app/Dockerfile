# --- Stage 1: Build dependencies ---
FROM node:20-alpine AS builder

# Install build tools required for native C++ modules (isolated-vm)
RUN apk add --no-cache python3 make g++

# Install pnpm globally
RUN npm install -g pnpm

WORKDIR /app

COPY serverless-app/package.json serverless-app/pnpm-lock.yaml* ./

# Install and compile production dependencies
RUN pnpm install --prod

# --- Stage 2: Runtime image ---
FROM node:20-alpine

# Set node environment to production
ENV NODE_ENV=production

WORKDIR /app

# Copy package.json and the compiled node_modules from the builder stage
COPY --from=builder --chown=node:node /app/package.json ./
COPY --from=builder --chown=node:node /app/node_modules ./node_modules

# Run as the unprivileged non-root node user
USER node

EXPOSE 8080

CMD ["node", "index.js"]
