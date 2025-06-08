import '../data/coin_datasource.dart';
import '../model/coin.dart';

class CoinRepository {
  final CoinDataSource dataSource;

  CoinRepository(this.dataSource);

  Future<List<Coin>> getCoins(String symbols) async {
    final data = await dataSource.fetchCoins(symbols);
    List<Coin> result = [];

    data.forEach((_, coinList) {
      if (coinList is List && coinList.isNotEmpty) {
        final coinMap = coinList[0]; // pega o primeiro item da lista
        result.add(Coin.fromMap(coinMap));
      }
    });

    return result;
  }
}
