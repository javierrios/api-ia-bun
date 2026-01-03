//console.log("Hello via Bun!");
const server
= Bun.serve({
    port: process.env.PORT || 3000,
    hostname: process.env.HOST || '0.0.0.0',
    fetch: async (req) => {
        return new Response('Hello World');
    },
    websocket: {
        message: (ws, message) => {
            ws.send(message);
        },
    },
});
console.log(`Server is running on ${server.url}:${server.port} `  
 );
