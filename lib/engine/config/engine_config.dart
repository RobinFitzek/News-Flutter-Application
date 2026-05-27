/// Engine configuration mirroring News/core/config.py
class EngineConfig {
  EngineConfig._();

  static const double eurToUsd = 1.08;

  static const Map<String, double> defaultMonthlyBudgetEur = {
    'perplexity': 5.0,
    'gemini': 5.0,
  };

  static const Map<String, double> quantCompositeWeights = {
    'valuation': 0.30,
    'technical': 0.25,
    'momentum': 0.25,
    'quality': 0.20,
  };

  static const double anomalyZThreshold = 2.0;
  static const int opportunityThreshold = 70;
  static const int cautionThreshold = 30;
  static const String benchmarkTicker = 'SPY';

  static const Map<String, double> pipelineStageSplit = {
    'stage1': 0.0,
    'stage2': 0.60,
    'stage3': 0.40,
  };

  static const Map<String, List<String>> sectorPeers = {
    'Technology': ['AAPL', 'MSFT', 'GOOGL', 'META', 'NVDA', 'AVGO', 'ORCL', 'CRM'],
    'Healthcare': ['JNJ', 'UNH', 'PFE', 'ABBV', 'MRK', 'LLY', 'TMO', 'ABT'],
    'Financial Services': ['JPM', 'BAC', 'WFC', 'GS', 'MS', 'BLK', 'SCHW', 'AXP'],
    'Consumer Cyclical': ['AMZN', 'TSLA', 'HD', 'MCD', 'NKE', 'SBUX', 'LOW', 'TJX'],
    'Consumer Defensive': ['PG', 'KO', 'PEP', 'WMT', 'COST', 'CL', 'MDLZ', 'GIS'],
    'Industrials': ['CAT', 'DE', 'UNP', 'HON', 'MMM', 'GE', 'BA', 'RTX'],
    'Energy': ['XOM', 'CVX', 'COP', 'SLB', 'EOG', 'MPC', 'PSX', 'VLO'],
    'Communication Services': ['GOOGL', 'META', 'DIS', 'NFLX', 'CMCSA', 'T', 'VZ', 'TMUS'],
    'Utilities': ['NEE', 'DUK', 'SO', 'D', 'AEP', 'SRE', 'EXC', 'XEL'],
    'Real Estate': ['PLD', 'AMT', 'EQIX', 'SPG', 'O', 'PSA', 'DLR', 'WELL'],
    'Basic Materials': ['LIN', 'APD', 'SHW', 'ECL', 'NEM', 'FCX', 'NUE', 'DOW'],
  };

  static const Map<String, Map<String, double>> geminiPricing = {
    'gemini-2.0-flash': {'input': 0.15, 'output': 0.60},
    'gemini-2.5-flash': {'input': 0.15, 'output': 0.60},
    'gemini-2.5-flash-lite': {'input': 0.10, 'output': 0.40},
    'sonar-pro': {'input': 1.0, 'output': 1.0, 'searchPer1000': 5.0},
  };
}
