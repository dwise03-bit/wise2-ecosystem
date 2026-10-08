# ⬡ WISE² Complete Ecosystem

Production-grade platform for Web Design, VR/Games, 3D/Modeling, AI Tools, Trading & IoT.

## Quick Start

```bash
# Install dependencies
npm install

# Development server
npm run dev

# Run tests
npm test

# Production build
npm run build
```

## Environment Setup

```bash
cp .env.example .env
# Edit .env with your API keys
```

## Architecture

```
wise2-ecosystem/
├── config/              # Configuration & setup
│   ├── env.js
│   ├── api-client.js
│   ├── error-handler.js
│   └── telemetry.js
├── tests/               # Unit & integration tests
├── ai-tools/            # Claude, GPT, LLaMA integration
├── trading/             # Stock market & backtesting
├── games/               # VR, Phaser, Babylon.js
├── 3d-viewer/           # 3D modeling & printing
├── mobile/              # iOS/Android PWA
├── embedded/            # ESP32 IoT
└── docs/                # API & user documentation
```

## Features

### 🎨 Web Design
- WISE² design system (hexagonal, green accent)
- Component library
- Video workflow

### 🤖 AI Tools
- Claude/GPT chat interface
- Prompt management
- Token counting & cost tracking

### 📈 Trading
- Real-time dashboard
- Backtesting engine
- Portfolio tracking

### 🎮 Gaming & VR
- WebXR immersive VR
- Phaser 2D games
- Babylon.js 3D engine

### 🎨 3D & Printing
- Model viewer (GLB/GLTF/OBJ)
- Print analyzer
- Blender addon

### 📱 Mobile & IoT
- iOS PWA
- Android app
- ESP32 dashboard

## API Documentation

See `docs/API.md` for complete API reference.

## Testing

```bash
npm test           # Run all tests
npm run test:watch # Watch mode
```

## Performance

- Lighthouse score: 95+
- Page load: <2s
- Bundle size: <100KB (gzipped)

## Production Deployment

```bash
npm run build      # Build artifacts
npm run audit      # Security & performance audit
npm run deploy     # Deploy to production
```

## License

MIT - See LICENSE file
