import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../viewmodel/coin_viewmodel.dart';
import '../model/coin.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final vm = Provider.of<CoinViewModel>(context, listen: false);
      vm.fetchCoins('');
    });
  }

  String formatDate(String iso) {
    final date = DateTime.tryParse(iso);
    if (date == null) return iso;
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  String formatCurrencyBRL(double value) {
    return NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(value);
  }

  String formatCurrencyUSD(double value) {
    return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(value);
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CoinViewModel>(context);
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Crypto Tracker',
          style: TextStyle(
            color: Colors.amber,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Buscar (ex: BTC,ETH)',
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFF1E1E1E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.amber),
                  onPressed: () {
                    vm.fetchCoins(controller.text.trim().toUpperCase());
                  },
                ),
              ),
            ),
          ),
          if (vm.isLoading)
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(color: Colors.amber),
              ),
            )
          else if (vm.coins.isEmpty)
            const Expanded(
              child: Center(
                child: Text(
                  'Nenhuma moeda encontrada.',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: vm.coins.length,
                itemBuilder: (_, i) {
                  final coin = vm.coins[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: GestureDetector(
                      onTap: () => showModalBottomSheet(
                        backgroundColor: Colors.black,
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        builder: (_) => _coinDetail(coin),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1E1E),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 6,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${coin.name} (${coin.symbol})',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'USD: ${formatCurrencyUSD(coin.priceUsd)}',
                                  style: const TextStyle(color: Colors.greenAccent),
                                ),
                                Text(
                                  'BRL: ${formatCurrencyBRL(coin.priceBrl)}',
                                  style: const TextStyle(color: Colors.amber),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _coinDetail(Coin coin) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Color(0xFF1E1E1E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${coin.name} (${coin.symbol})',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.amber,
            ),
          ),
          const SizedBox(height: 16),
          Text('Data de adição: ${formatDate(coin.dateAdded)}', style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 8),
          Text('Preço em USD: ${formatCurrencyUSD(coin.priceUsd)}', style: const TextStyle(color: Colors.greenAccent)),
          Text('Preço em BRL: ${formatCurrencyBRL(coin.priceBrl)}', style: const TextStyle(color: Colors.amber)),
        ],
      ),
    );
  }
}
