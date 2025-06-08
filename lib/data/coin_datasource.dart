import 'dart:convert';
import 'package:http/http.dart' as http;

class CoinDataSource {
  final String _baseUrl = 'https://pro-api.coinmarketcap.com/v2/cryptocurrency/quotes/latest';
  final String _apiKey = 'a227b507-ba60-4124-87a8-975dc4442d7a';

Future<Map<String, dynamic>> fetchCoins(String symbols) async {
    final url = Uri.parse('$_baseUrl?symbol=$symbols');
    final response = await http.get(
      url,
      headers: {
        'Accepts': 'application/json',
        'X-CMC_PRO_API_KEY': _apiKey,
      },
    );

    print('STATUS CODE: ${response.statusCode}');
    print('RESPONSE BODY: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      print('DATA PARSED: $data');
      return data;
    } else {
      print('ERRO: ${response.statusCode} - ${response.body}');
      throw Exception('Erro ao buscar moedas');
    }
  }
}
