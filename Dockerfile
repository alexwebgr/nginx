FROM node:alpine AS builder

RUN apk add --no-cache git
WORKDIR /app
RUN git clone https://github.com/Markex2002/PortFolioWeb-FrontEnd.git .
RUN ls -la

# Install dependencies and build the Angular app
RUN npm install
RUN npm run build

# Production stage with Nginx
FROM nginx:alpine

# Remove default nginx content
RUN rm -rf /usr/share/nginx/html/*

# Copy built application from builder stage
COPY --from=builder /app/dist/app-portfolio/browser /usr/share/nginx/html

RUN ls -la /usr/share/nginx/html/

# Copy custom nginx configuration (optional)
# COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
