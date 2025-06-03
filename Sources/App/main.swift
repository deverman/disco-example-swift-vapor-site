import Vapor

@main
struct HelloWorldApp {
    static func main() async throws {
        var env = try Environment.detect()
        try LoggingSystem.bootstrap(from: &env)

        let app = try await Application.make(env)

        do {
            // Configure port from environment variable or default to 8080
            let port = Environment.get("PORT").flatMap(Int.init) ?? 8080
            app.http.server.configuration.port = port
            app.http.server.configuration.hostname = "0.0.0.0"

            // Define the Hello World route
            app.get { req in
                "Hello, World from Swift Vapor!"
            }

            // Optional health check endpoint for monitoring
            app.get("health") { req in
                ["status": "ok"]
            }

            // Start the server
            try await app.execute()
        } catch {
            try await app.asyncShutdown()
            throw error
        }
    }
}
