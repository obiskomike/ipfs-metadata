# Stage 1: Build the Go application
FROM golang:1.21-alpine AS builder

# Set the current working directory in the container
WORKDIR /app

# Copy go.mod and go.sum files and download dependencies
COPY go.mod go.sum ./
RUN go mod tidy

# Copy the entire source code into the container
COPY . .

# Build the Go application
RUN go build -o nft-metadata-scraper .

# Stage 2: Create a smaller runtime image
FROM alpine:3.17

# Install ca-certificates to allow the Go app to make HTTPS requests
RUN apk --no-cache add ca-certificates

# Set the working directory in the container
WORKDIR /root/

# Copy the compiled Go binary from the builder stage
COPY --from=builder /app/nft-metadata-scraper .

# Only copy the environment file if necessary
COPY .env .env
COPY data data
# Expose the port on which the Go app will run (e.g., 8080)
EXPOSE 8080

# Run the Go application
CMD ["./nft-metadata-scraper"]
