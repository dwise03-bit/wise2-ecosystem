# WISE² API Reference

## Base URL: http://localhost:8000/api

### Authentication
All requests require: `X-API-Key: your-key`

### AI Endpoints
- `POST /ai/chat` - Chat with AI model
- `POST /ai/embeddings` - Generate embeddings
- `GET /prompts` - List saved prompts

### Trading Endpoints
- `GET /trading/portfolio` - Get portfolio
- `GET /trading/market/:symbol` - Get market data
- `POST /trading/backtest` - Run backtest

### 3D Model Endpoints
- `GET /models` - List models
- `POST /models/upload` - Upload model
- `POST /models/:id/analyze` - Analyze model
- `POST /models/:id/print` - Prepare for printing

## Response Format
```json
{
  "success": true,
  "data": {},
  "error": null
}
```
