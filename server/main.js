/**
 * WISE² Central API Server
 * Unified gateway for all ecosystem services
 */

const http = require('http');
const url = require('url');

class WISEServer {
  constructor(port = 8000) {
    this.port = port;
  }

  async handleRequest(req, res) {
    const pathname = url.parse(req.url, true).pathname;

    // CORS headers
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type, X-API-Key');
    res.setHeader('Content-Type', 'application/json');

    if (req.method === 'OPTIONS') {
      res.writeHead(200);
      res.end();
      return;
    }

    // Health checks
    if (pathname === '/health') {
      res.writeHead(200);
      res.end(JSON.stringify({ 
        status: 'healthy', 
        timestamp: new Date().toISOString(),
        uptime: process.uptime()
      }));
      return;
    }

    if (pathname === '/ready') {
      res.writeHead(200);
      res.end(JSON.stringify({ 
        ready: true, 
        services: ['ai', 'trading', '3d', 'auth']
      }));
      return;
    }

    if (pathname === '/metrics') {
      const memory = process.memoryUsage();
      res.writeHead(200);
      res.end(JSON.stringify({
        memory: {
          heapUsed: Math.round(memory.heapUsed / 1024 / 1024),
          heapTotal: Math.round(memory.heapTotal / 1024 / 1024)
        },
        uptime: Math.round(process.uptime()),
        timestamp: new Date().toISOString()
      }));
      return;
    }

    // Route to services
    const routes = {
      '/api/ai': { service: 'ai', status: 'operational' },
      '/api/trading': { service: 'trading', status: 'operational' },
      '/api/models': { service: '3d', status: 'operational' },
      '/api/auth': { service: 'auth', status: 'operational' }
    };

    for (const [route, info] of Object.entries(routes)) {
      if (pathname.startsWith(route)) {
        res.writeHead(200);
        res.end(JSON.stringify(info));
        return;
      }
    }

    // 404
    res.writeHead(404);
    res.end(JSON.stringify({ error: 'Route not found', path: pathname }));
  }

  start() {
    const server = http.createServer((req, res) => {
      this.handleRequest(req, res).catch(err => {
        console.error('Error:', err);
        res.writeHead(500);
        res.end(JSON.stringify({ error: 'Internal server error' }));
      });
    });

    server.listen(this.port, () => {
      console.log(`✅ WISE² API Gateway running on port ${this.port}`);
      console.log(`📡 Health: http://localhost:${this.port}/health`);
    });

    return server;
  }
}

const server = new WISEServer(process.env.PORT || 8000);
server.start();

module.exports = WISEServer;
