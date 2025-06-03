# Multi-stage build for optimized Swift Vapor deployment
FROM swift:5.10-jammy as builder

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libssl-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy dependency files FIRST (better caching)
COPY Package.swift Package.resolved ./

# Fetch dependencies (cached unless Package.* changes)
RUN swift package resolve

# Copy source code AFTER dependencies
COPY Sources ./Sources

# Build with optimizations
RUN swift build --configuration release --static-swift-stdlib

# Production stage - smaller final image
FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy only the built binary
COPY --from=builder /app/.build/release/App ./App

# Security: non-root user
RUN useradd --user-group --create-home --system --skel /dev/null --home-dir /app vapor
RUN chown -R vapor:vapor /app
USER vapor

EXPOSE 8080
CMD ["./App"]
