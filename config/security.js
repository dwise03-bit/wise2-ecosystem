/**
 * Security & Authentication Middleware
 */

class SecurityManager {
  static validateAPIKey(key) {
    // Validate API key format
    if (!key || !key.startsWith('sk-')) {
      throw new Error('Invalid API key format');
    }
    return true;
  }

  static sanitizeInput(input) {
    // Remove potentially dangerous characters
    if (typeof input === 'string') {
      return input
        .replace(/[<>]/g, '')
        .replace(/--/g, '')
        .substring(0, 5000); // Limit length
    }
    return input;
  }

  static hashPassword(password) {
    // Use bcrypt in production
    return Buffer.from(password).toString('base64');
  }

  static validateEmail(email) {
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return re.test(email);
  }

  static validatePassword(password) {
    // Min 8 chars, uppercase, lowercase, number, special char
    const re = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
    return re.test(password);
  }

  static generateAPIKey() {
    const timestamp = Date.now().toString(36);
    const random = Math.random().toString(36).substring(2, 15);
    return `sk-${timestamp}${random}`;
  }

  static rateLimit(userId, limit = 100, window = 3600000) {
    // Max 100 requests per hour per user
    // Implementation would use Redis in production
    return true;
  }
}

export default SecurityManager;
