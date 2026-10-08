// WISE² Game Framework Configuration

const GameConfig = {
  // Display settings
  display: {
    width: 1920,
    height: 1080,
    fullscreen: true,
    scale: 'FIT_TO_WINDOW'
  },

  // Game settings
  game: {
    name: 'WISE² Game',
    version: '1.0.0',
    author: 'WISE2'
  },

  // Physics
  physics: {
    gravity: 300,
    friction: 0.5,
    bounce: 0.3
  },

  // Rendering
  graphics: {
    pixelArt: true,
    antiAlias: false,
    shadowsEnabled: false
  },

  // Audio
  audio: {
    masterVolume: 0.8,
    musicVolume: 0.6,
    sfxVolume: 0.8
  },

  // Input
  input: {
    keyboardEnabled: true,
    mouseEnabled: true,
    touchEnabled: true,
    gamepadEnabled: true
  },

  // Gameplay
  gameplay: {
    difficulty: 'normal', // easy, normal, hard
    startLevel: 1,
    maxLevels: 10,
    lives: 3
  }
};

// Game state manager
class GameState {
  constructor() {
    this.score = 0;
    this.level = 1;
    this.lives = 3;
    this.highScore = localStorage.getItem('highScore') || 0;
    this.isPaused = false;
  }

  addScore(points) {
    this.score += points;
    if (this.score > this.highScore) {
      this.highScore = this.score;
      localStorage.setItem('highScore', this.score);
    }
  }

  loseLife() {
    this.lives--;
    return this.lives > 0;
  }

  nextLevel() {
    this.level++;
    return this.level <= GameConfig.gameplay.maxLevels;
  }

  reset() {
    this.score = 0;
    this.level = 1;
    this.lives = 3;
  }

  pause() {
    this.isPaused = !this.isPaused;
  }

  toJSON() {
    return {
      score: this.score,
      level: this.level,
      lives: this.lives,
      highScore: this.highScore
    };
  }
}

// Export for use in game modules
if (typeof module !== 'undefined' && module.exports) {
  module.exports = { GameConfig, GameState };
}
