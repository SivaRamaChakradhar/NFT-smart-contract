# Use a Node version compatible with Hardhat
FROM node:16-alpine

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package.json package-lock.json* ./
RUN npm install

# Copy the rest of the project files
COPY . .

# Compile contracts
RUN npx hardhat compile

# Default command to run tests
CMD ["npx", "hardhat", "test"]
