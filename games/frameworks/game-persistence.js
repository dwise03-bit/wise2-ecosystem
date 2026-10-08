// Game Save/Load System

class GameStorage {
  constructor(storageKey = 'wise2_game') {
    this.storageKey = storageKey;
  }

  save(gameState) {
    try {
      const data = {
        timestamp: Date.now(),
        state: gameState.toJSON(),
        version: '1.0'
      };
      localStorage.setItem(this.storageKey, JSON.stringify(data));
      return true;
    } catch (e) {
      console.error('Save failed:', e);
      return false;
    }
  }

  load() {
    try {
      const data = localStorage.getItem(this.storageKey);
      return data ? JSON.parse(data) : null;
    } catch (e) {
      console.error('Load failed:', e);
      return null;
    }
  }

  clear() {
    localStorage.removeItem(this.storageKey);
  }

  getHighScores(limit = 10) {
    try {
      const scores = localStorage.getItem(this.storageKey + '_scores');
      return scores ? JSON.parse(scores).slice(0, limit) : [];
    } catch (e) {
      return [];
    }
  }

  saveHighScore(playerName, score) {
    try {
      let scores = this.getHighScores(100);
      scores.push({ name: playerName, score, date: new Date().toISOString() });
      scores.sort((a, b) => b.score - a.score);
      localStorage.setItem(this.storageKey + '_scores', JSON.stringify(scores));
      return true;
    } catch (e) {
      return false;
    }
  }
}

// Cloud sync (optional - requires server)
class CloudGameSync {
  constructor(apiEndpoint = '/api/game') {
    this.apiEndpoint = apiEndpoint;
  }

  async syncSave(userId, gameState) {
    try {
      const response = await fetch(`${this.apiEndpoint}/save`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ userId, state: gameState.toJSON() })
      });
      return response.ok;
    } catch (e) {
      console.error('Cloud sync failed:', e);
      return false;
    }
  }

  async loadSave(userId) {
    try {
      const response = await fetch(`${this.apiEndpoint}/load?userId=${userId}`);
      return response.ok ? response.json() : null;
    } catch (e) {
      console.error('Cloud load failed:', e);
      return null;
    }
  }
}

if (typeof module !== 'undefined' && module.exports) {
  module.exports = { GameStorage, CloudGameSync };
}
