# WISE² Game Assets

Organize game assets by type and usage:

```
assets/
├── sprites/          # Character, enemy, collectible sprites
│   ├── player/
│   ├── enemies/
│   └── items/
├── backgrounds/      # Level backgrounds and parallax layers
├── audio/
│   ├── music/        # Background music tracks
│   ├── sfx/          # Sound effects
│   └── voice/        # Voice acting
├── fonts/            # Custom game fonts
├── data/             # Level data, enemy definitions
│   ├── levels.json
│   ├── enemies.json
│   └── config.json
└── ui/               # Menu, HUD, pause screen assets
    ├── buttons/
    ├── icons/
    └── panels/
```

## Asset Optimization

- **Sprites**: PNG 8-bit for pixel art, WebP for modern browsers
- **Audio**: MP3 (compatibility), OGG (Vorbis for web)
- **Backgrounds**: WebP with fallback to PNG
- **Fonts**: WOFF2 + WOFF fallback

## Loading Pattern

```javascript
const assetLoader = new BABYLON.AssetsManager(scene);
assetLoader.addMeshTask('player', '', 'assets/', 'player.glb');
assetLoader.onFinish = () => { startGame(); };
assetLoader.load();
```

## Size Guidelines

- Sprite sheets: < 512KB
- Audio tracks: < 2MB (stream in production)
- 3D models: < 5MB total
- Full game: < 50MB (with compression)
