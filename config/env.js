/**
 * Environment Configuration Loader
 */
class ConfigManager {
  constructor() {
    this.config = {
      api: {
        baseURL: 'http://localhost:8000',
        timeout: 30000,
        retryAttempts: 3
      },
      features: {
        vr: true,
        trading: true,
        ai: true,
        print3d: true
      },
      env: 'production'
    };
  }
  get(path) {
    return path.split('.').reduce((o, k) => o?.[k], this.config);
  }
  isProduction() {
    return this.config.env === 'production';
  }
}
const config = new ConfigManager();
export default config;
