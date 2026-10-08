/**
 * WISE² Trading Backtesting Engine
 * Simulate trading strategies with historical data
 */

class BacktestEngine {
  constructor(initialCapital = 100000) {
    this.initialCapital = initialCapital;
    this.portfolio = {
      cash: initialCapital,
      holdings: {},
      equity: initialCapital
    };
    this.trades = [];
    this.performance = [];
  }

  /**
   * Run backtest on historical data
   */
  async runBacktest(data, strategy) {
    this.portfolio = {
      cash: this.initialCapital,
      holdings: {},
      equity: this.initialCapital
    };
    this.trades = [];
    this.performance = [];

    for (let i = 100; i < data.length; i++) {
      const bar = data[i];
      const historical = data.slice(Math.max(0, i - 100), i);

      // Execute strategy
      const signal = strategy(bar, historical, this.portfolio);

      if (signal) {
        this.executeTrade(signal, bar);
      }

      // Record equity
      this.updateEquity(bar);
    }

    return this.getResults();
  }

  executeTrade(signal, bar) {
    const { action, symbol, quantity } = signal;
    const price = bar.close;

    if (action === 'BUY') {
      const cost = quantity * price;
      if (this.portfolio.cash >= cost) {
        this.portfolio.cash -= cost;
        this.portfolio.holdings[symbol] = 
          (this.portfolio.holdings[symbol] || 0) + quantity;
        
        this.trades.push({
          date: bar.date,
          action: 'BUY',
          symbol,
          quantity,
          price,
          total: cost
        });
      }
    } else if (action === 'SELL') {
      const held = this.portfolio.holdings[symbol] || 0;
      if (held >= quantity) {
        const proceeds = quantity * price;
        this.portfolio.cash += proceeds;
        this.portfolio.holdings[symbol] -= quantity;
        
        this.trades.push({
          date: bar.date,
          action: 'SELL',
          symbol,
          quantity,
          price,
          total: proceeds
        });
      }
    }
  }

  updateEquity(bar) {
    let equity = this.portfolio.cash;
    for (const [symbol, quantity] of Object.entries(this.portfolio.holdings)) {
      equity += quantity * bar.close;
    }
    
    this.portfolio.equity = equity;
    this.performance.push({
      date: bar.date,
      equity,
      cash: this.portfolio.cash
    });
  }

  getResults() {
    const finalEquity = this.portfolio.equity;
    const totalReturn = (finalEquity - this.initialCapital) / this.initialCapital;
    
    // Calculate metrics
    const equityValues = this.performance.map(p => p.equity);
    const maxDrawdown = this.calculateMaxDrawdown(equityValues);
    const sharpeRatio = this.calculateSharpeRatio(equityValues);
    const winRate = this.calculateWinRate();

    return {
      summary: {
        initialCapital: this.initialCapital,
        finalEquity: finalEquity,
        totalReturn: totalReturn,
        totalReturnPercent: (totalReturn * 100).toFixed(2),
        trades: this.trades.length,
        winRate: winRate
      },
      metrics: {
        maxDrawdown: (maxDrawdown * 100).toFixed(2),
        sharpeRatio: sharpeRatio.toFixed(2),
        profitFactor: this.calculateProfitFactor()
      },
      trades: this.trades,
      performance: this.performance
    };
  }

  calculateMaxDrawdown(equityValues) {
    let maxDrawdown = 0;
    let peak = equityValues[0];

    for (const equity of equityValues) {
      if (equity > peak) {
        peak = equity;
      }
      const drawdown = (peak - equity) / peak;
      if (drawdown > maxDrawdown) {
        maxDrawdown = drawdown;
      }
    }

    return maxDrawdown;
  }

  calculateSharpeRatio(equityValues) {
    // Simplified Sharpe ratio (daily returns)
    const returns = [];
    for (let i = 1; i < equityValues.length; i++) {
      returns.push((equityValues[i] - equityValues[i-1]) / equityValues[i-1]);
    }

    const avgReturn = returns.reduce((a, b) => a + b, 0) / returns.length;
    const variance = returns.reduce((a, r) => a + Math.pow(r - avgReturn, 2), 0) / returns.length;
    const stdDev = Math.sqrt(variance);

    return stdDev > 0 ? avgReturn / stdDev * Math.sqrt(252) : 0;
  }

  calculateWinRate() {
    const closedTrades = this.trades.filter((t, i) => {
      return i + 1 < this.trades.length && 
             this.trades[i + 1].action !== t.action;
    });

    if (closedTrades.length === 0) return 0;

    let wins = 0;
    for (let i = 0; i < closedTrades.length; i += 2) {
      if (i + 1 < closedTrades.length) {
        const buyPrice = closedTrades[i].price;
        const sellPrice = closedTrades[i + 1].price;
        if (sellPrice > buyPrice) wins++;
      }
    }

    return (wins / (closedTrades.length / 2)) * 100;
  }

  calculateProfitFactor() {
    let gains = 0, losses = 0;

    for (const trade of this.trades) {
      if (trade.action === 'SELL') {
        // Simplified - would need matching buy orders
        gains += trade.total * 0.1;
      }
    }

    return losses > 0 ? gains / losses : 0;
  }
}

// Example strategies
const Strategies = {
  movingAverageCrossover: (bar, historical, portfolio) => {
    const ma20 = historical.slice(-20).reduce((a, b) => a + b.close, 0) / 20;
    const ma50 = historical.slice(-50).reduce((a, b) => a + b.close, 0) / 50;

    if (ma20 > ma50 && !portfolio.holdings['SPY']) {
      return { action: 'BUY', symbol: 'SPY', quantity: 10 };
    } else if (ma20 < ma50 && portfolio.holdings['SPY']) {
      return { action: 'SELL', symbol: 'SPY', quantity: 10 };
    }
    return null;
  },

  rsiStrategy: (bar, historical, portfolio) => {
    // RSI > 70 = oversold (sell), RSI < 30 = oversold (buy)
    const rsi = calculateRSI(historical);
    
    if (rsi < 30 && !portfolio.holdings['QQQ']) {
      return { action: 'BUY', symbol: 'QQQ', quantity: 5 };
    } else if (rsi > 70 && portfolio.holdings['QQQ']) {
      return { action: 'SELL', symbol: 'QQQ', quantity: 5 };
    }
    return null;
  }
};

function calculateRSI(data, period = 14) {
  const changes = [];
  for (let i = 1; i < data.length; i++) {
    changes.push(data[i].close - data[i - 1].close);
  }

  const gains = changes.filter(c => c > 0).reduce((a, b) => a + b, 0) / period;
  const losses = Math.abs(changes.filter(c => c < 0).reduce((a, b) => a + b, 0) / period);

  const rs = losses > 0 ? gains / losses : 0;
  return 100 - (100 / (1 + rs));
}

if (typeof module !== 'undefined' && module.exports) {
  module.exports = { BacktestEngine, Strategies };
}
