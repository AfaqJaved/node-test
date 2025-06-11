# Step 1: Build the app
FROM node:20 AS builder

WORKDIR /app

COPY . .

RUN npm install -g pnpm && pnpm install && pnpm run build

# Step 2: Run the app with a smaller image
FROM node:20-slim

WORKDIR /app

COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package*.json ./

RUN npm install -g pnpm && pnpm install --prod

EXPOSE 3000

CMD ["node", "dist/main.js"]
