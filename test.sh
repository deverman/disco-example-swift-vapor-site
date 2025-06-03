#!/bin/bash

# Test script for disco-example-swift-vapor-site
# This script builds and briefly tests the Vapor application

set -e

echo "🚀 Testing Swift Vapor Hello World Application..."

# Check if Swift is installed
if ! command -v swift &> /dev/null; then
    echo "❌ Swift is not installed. Please install Swift 5.10+ first."
    echo "   Visit: https://swift.org/install/"
    exit 1
fi

# Check Swift version
SWIFT_VERSION=$(swift --version | head -n1)
echo "✅ Swift version: $SWIFT_VERSION"

# Resolve dependencies
echo "📦 Resolving Swift packages..."
swift package resolve

# Build the project
echo "🔨 Building project..."
swift build

# Test if build artifacts exist
if [ ! -f ".build/debug/App" ]; then
    echo "❌ Build failed - executable not found"
    exit 1
fi

echo "✅ Build successful!"

# Start the server in background
echo "🌐 Starting server..."
swift run App &
SERVER_PID=$!

# Wait a moment for server to start
sleep 3

# Test the endpoints
echo "🧪 Testing endpoints..."

# Test root endpoint
ROOT_RESPONSE=$(curl -s http://localhost:8080/ || echo "FAILED")
if [ "$ROOT_RESPONSE" = "Hello, World!" ]; then
    echo "✅ Root endpoint (/) works: $ROOT_RESPONSE"
else
    echo "❌ Root endpoint failed. Response: $ROOT_RESPONSE"
fi

# Test health endpoint
HEALTH_RESPONSE=$(curl -s http://localhost:8080/health || echo "FAILED")
if [[ "$HEALTH_RESPONSE" == *'"status":"ok"'* ]]; then
    echo "✅ Health endpoint (/health) works: $HEALTH_RESPONSE"
else
    echo "❌ Health endpoint failed. Response: $HEALTH_RESPONSE"
fi

# Clean up
echo "🧹 Stopping server..."
kill $SERVER_PID 2>/dev/null || true
sleep 1

echo ""
echo "🎉 Test completed!"
echo ""
echo "Your Swift Vapor app is ready for deployment with Disco!"
echo "Next steps:"
echo "  1. Push this code to GitHub"
echo "  2. Run: disco projects:add --name your-app --github username/repo --domain your-domain.com"
echo "  3. Deploy with: git push"
echo ""
echo "Learn more: https://docs.letsdisco.dev"