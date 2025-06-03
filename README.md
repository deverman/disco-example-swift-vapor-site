# Swift Vapor Hello World Example for Disco

A minimal Swift web application using the Vapor framework that serves a simple "Hello, World!" page, designed to be deployed using [Disco](https://docs.letsdisco.dev).

## Features

- Simple "Hello, World!" response at `/`
- Health check endpoint at `/health`
- Built with Swift's modern concurrency (async/await)
- Optimized for deployment with Disco
- Minimal dependencies and lightweight structure

## Prerequisites

- **Swift 5.10+** - [Install Swift](https://swift.org/install/)
- **Disco CLI** - [Install Disco](https://docs.letsdisco.dev)
- **Server with SSH access** (for deployment)
- **Domain name** (for deployment)

## Quick Start

### 1. Clone and Setup

```bash
git clone <your-repo-url>
cd disco-example-swift-vapor-site
```

### 2. Install Dependencies

```bash
swift package resolve
```

### 3. Run Locally

```bash
swift run App
```

The server will start on `http://localhost:8080`. You should see:
- `http://localhost:8080/` → "Hello, World!"
- `http://localhost:8080/health` → `{"status": "ok"}`

## Deployment with Disco

### Prerequisites for Deployment

1. **Server Setup**: You need a server you can SSH into (VPS from Hetzner, Digital Ocean, or even a Raspberry Pi)
2. **Domain Name**: Register a domain with providers like Porkbun, Namecheap, or easydns.com
3. **Disco Installation**: Install Disco on your server following the [documentation](https://docs.letsdisco.dev)

### Deploy Your App

1. **Add your project to Disco:**

```bash
disco projects:add \
    --name swift-hello-world \
    --github yourusername/disco-example-swift-vapor-site \
    --domain your-domain.com
```

2. **Deploy by pushing to GitHub:**

```bash
git add .
git commit -m "Initial commit"
git push origin main
```

Your app will be automatically built and deployed! 🚀

### Monitor Deployment

```bash
# View deployment logs
disco deploy:output --project swift-hello-world

# Check project status
disco projects:list
```

## Project Structure

```
disco-example-swift-vapor-site/
├── Package.swift              # Swift Package Manager configuration
├── Sources/
│   └── App/
│       └── main.swift        # Main application entry point
├── disco.json                # Disco deployment configuration
├── Dockerfile                # Container configuration for deployment
├── README.md                 # This file
└── .gitignore               # Git ignore rules
```

## Configuration

### Environment Variables

- `PORT` - Server port (defaults to 8080)

### Disco Configuration

The `disco.json` file configures the deployment:

```json
{
    "version": "1.0",
    "services": {
        "web": {
            "port": 8080
        }
    }
}
```

## Development

### Adding New Routes

Edit `Sources/App/main.swift` to add new routes:

```swift
app.get("about") { req async -> String in
    "About page"
}
```

### Testing

Test your application locally:

```bash
# Run the app
swift run App

# In another terminal, test endpoints
curl http://localhost:8080/
curl http://localhost:8080/health
```

## Troubleshooting

### Build Issues

- Ensure you have Swift 5.10+ installed: `swift --version`
- Clear package cache: `swift package clean`
- Resolve dependencies: `swift package resolve`

### Deployment Issues

- Check deployment logs: `disco deploy:output --project your-project-name`
- Verify your `disco.json` configuration
- Ensure your server meets the [system requirements](https://docs.letsdisco.dev)

## Why Disco?

- **Cost Effective**: Host multiple sites for a single fee instead of paying per project
- **Lightning Fast**: Deployments in seconds, not minutes
- **Simple Setup**: Push to GitHub and your changes go live automatically
- **Own Your Infrastructure**: No vendor lock-in, deploy to your own servers

## Learn More

- [Vapor Documentation](https://vapor.codes)
- [Disco Documentation](https://docs.letsdisco.dev)
- [Swift Documentation](https://swift.org/documentation/)

## License

This project is provided as an example and is free to use and modify.