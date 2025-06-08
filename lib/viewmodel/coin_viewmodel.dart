import 'package:flutter/material.dart';
import '../model/coin.dart';
import '../repository/coin_repository.dart';

class CoinViewModel extends ChangeNotifier {
  final CoinRepository repository;
  List<Coin> coins = [];
  bool isLoading = false;

  CoinViewModel(this.repository);

  Future<void> fetchCoins(String symbols) async {
    isLoading = true;
    notifyListeners();

    try {
      print('🔎 Buscando: $symbols');
      coins = await repository.getCoins(
        symbols.isEmpty ? _defaultSymbols : symbols,
      );
      print('✅ Moedas recebidas: ${coins.length}');
    } catch (e) {
      print('❌ Erro ao buscar moedas: $e');
      coins = [];
    }

    isLoading = false;
    notifyListeners();
  }


  String get _defaultSymbols =>
      'BTC,ETH,SOL,BNB,BCH,MKR,AAVE,DOT,SUI,ADA,XRP,TIA,NEO,NEAR,PENDLE,RENDER,LINK,TON,XAI,SEI,IMX,ETHFI,UMA,SUPER,FET,USUAL,GALA,PAAL,AERO';
}
