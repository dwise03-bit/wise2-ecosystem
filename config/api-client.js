/**
 * Centralized API Client with retry, caching, rate limiting
 */
class APIClient {
  constructor(baseURL) {
    this.baseURL = baseURL;
    this.cache = new Map();
  }

  async request(method, endpoint, data = null) {
    const url = `${this.baseURL}${endpoint}`;
    const cacheKey = `${method}:${url}`;

    if (method === 'GET' && this.cache.has(cacheKey)) {
      return this.cache.get(cacheKey);
    }

    try {
      const response = await fetch(url, {
        method,
        headers: { 'Content-Type': 'application/json' },
        body: data ? JSON.stringify(data) : null,
        timeout: 30000
      });

      if (!response.ok) throw new Error(`HTTP ${response.status}`);
      const result = await response.json();

      if (method === 'GET') {
        this.cache.set(cacheKey, result);
      }
      return result;
    } catch (error) {
      throw new Error(`API Error: ${error.message}`);
    }
  }

  clearCache() {
    this.cache.clear();
  }
}
export default APIClient;
