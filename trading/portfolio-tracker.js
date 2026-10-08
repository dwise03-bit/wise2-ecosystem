/**
 * WISE² Portfolio Tracker
 * Real-time portfolio monitoring and reporting
 */

class PortfolioTracker {
  constructor() {
    this.holdings = new Map();
    this.transactions = [];
  }

  addHolding(symbol, shares, avgCost, purchaseDate) {
    this.holdings.set(symbol, {
      symbol,
      shares,
      avgCost,
      purchaseDate,
      currentPrice: avgCost,
      notes: ''
    });
  }

  addTransaction(symbol, action, shares, price, date, commission = 0) {
    this.transactions.push({
      symbol,
      action,
      shares,
      price,
      date,
      commission,
      total: (shares * price) + commission
    });
  }

  getPortfolioValue(prices) {
    let totalValue = 0;
    for (const [symbol, holding] of this.holdings) {
      const price = prices[symbol] || holding.currentPrice;
      totalValue += holding.shares * price;
    }
    return totalValue;
  }

  getGainLoss() {
    let totalCost = 0;
    let totalValue = 0;

    for (const [symbol, holding] of this.holdings) {
      const cost = holding.shares * holding.avgCost;
      const value = holding.shares * holding.currentPrice;
      totalCost += cost;
      totalValue += value;
    }

    return {
      totalCost,
      totalValue,
      gainLoss: totalValue - totalCost,
      gainLossPercent: (totalValue - totalCost) / totalCost
    };
  }

  getSectorAllocation() {
    const sectors = {
      'Technology': ['AAPL', 'MSFT', 'NVDA', 'AMD'],
      'Finance': ['JPM', 'BAC', 'GS'],
      'Healthcare': ['JNJ', 'UNH', 'PFE'],
      'Energy': ['XOM', 'CVX'],
      'Consumer': ['AMZN', 'WMT', 'CRM']
    };

    const allocation = {};
    let totalValue = 0;

    for (const [symbol, holding] of this.holdings) {
      const value = holding.shares * holding.currentPrice;
      totalValue += value;
      
      for (const [sector, symbols] of Object.entries(sectors)) {
        if (symbols.includes(symbol)) {
          allocation[sector] = (allocation[sector] || 0) + value;
        }
      }
    }

    return Object.entries(allocation).map(([sector, value]) => ({
      sector,
      value,
      percent: (value / totalValue) * 100
    }));
  }

  rebalance(targetAllocation) {
    const currentAllocation = this.getSectorAllocation();
    const trades = [];

    for (const [sector, target] of Object.entries(targetAllocation)) {
      const current = currentAllocation.find(a => a.sector === sector);
      const currentPercent = current ? current.percent : 0;
      
      if (Math.abs(currentPercent - target) > 5) {
        trades.push({
          sector,
          currentPercent,
          targetPercent: target,
          action: currentPercent < target ? 'BUY' : 'SELL'
        });
      }
    }

    return trades;
  }

  exportReport() {
    return {
      holdings: Array.from(this.holdings.values()),
      transactions: this.transactions,
      gainLoss: this.getGainLoss(),
      sectorAllocation: this.getSectorAllocation()
    };
  }
}

if (typeof module !== 'undefined' && module.exports) {
  module.exports = { PortfolioTracker };
}
