FROM swift:5.10-focal

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libssl-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy package files
COPY Package.swift ./
COPY Sources ./Sources

# Build the application
RUN swift build --configuration release

# Expose port
EXPOSE 8080

# Run the application
CMD ["./.build/release/App"]