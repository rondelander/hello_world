FROM node:14-alpine as builder

# Create and set the working directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Copy package.json
COPY package.json ./
COPY .pnp.cjs ./
COPY .yarn ./

# Install dependencies
RUN yarn install --frozen-lockfile

# Copy the rest of the application code
COPY . .

# Compile TypeScript to JavaScript
RUN yarn build

# Start a new stage
FROM node:14-alpine

# Create and set the working directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Copy only the necessary files from the previous stage
COPY --from=builder /usr/src/app/dist /usr/src/app
COPY --from=builder /usr/src/app/node_modules /usr/src/app/node_modules
COPY --from=builder /usr/src/app/package*.json /usr/src/app/

# Expose the port that the application will run on
EXPOSE 3000

# Start the application
CMD [ "node", "app.js" ]
