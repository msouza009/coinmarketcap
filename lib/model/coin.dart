import 'package:intl/intl.dart';

class Coin {
  final String name;
  final String symbol;
  final double priceUsd;
  final double priceBrl;
  final String dateAdded;

  Coin({
    required this.name,
    required this.symbol,
    required this.priceUsd,
    required this.priceBrl,
    required this.dateAdded,
  });

factory Coin.fromMap(Map<String, dynamic> map) {
  final priceUsd = map['quote']?['USD']?['price']?.toDouble() ?? 0.0;
  final dolarHoje = 5.30; 

  return Coin(
    name: map['name'] ?? '',
    symbol: map['symbol'] ?? '',
    priceUsd: priceUsd,
    priceBrl: (priceUsd * dolarHoje),
    dateAdded: map['date_added'] ?? '',
  );
}

}
