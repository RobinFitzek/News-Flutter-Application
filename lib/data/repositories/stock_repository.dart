import '../../models/stock_prediction.dart';

abstract class StockRepository {
  Future<StockPrediction> getPrediction(String symbol);
  Future<List<StockPrediction>> getPredictions();
  Future<void> refreshData(String symbol);
}

class StockRepositoryImpl implements StockRepository {
  @override
  Future<StockPrediction> getPrediction(String symbol) async {
    throw UnimplementedError('getPrediction not yet implemented');
  }

  @override
  Future<List<StockPrediction>> getPredictions() async {
    throw UnimplementedError('getPredictions not yet implemented');
  }

  @override
  Future<void> refreshData(String symbol) async {
    throw UnimplementedError('refreshData not yet implemented');
  }
}
