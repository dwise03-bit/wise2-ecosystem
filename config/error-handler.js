/**
 * Global Error Handler & Logger
 */
class ErrorHandler {
  static log(error, context = {}) {
    const errorLog = {
      timestamp: new Date().toISOString(),
      message: error.message,
      stack: error.stack,
      context
    };
    console.error('ERROR:', errorLog);
    return errorLog;
  }

  static handle(error, fallback = 'An error occurred') {
    this.log(error);
    return {
      success: false,
      error: error.message || fallback
    };
  }
}
export default ErrorHandler;
