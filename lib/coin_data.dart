import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<Map<String, double?>> getCoinData(String selectedCurrency) async {
    String apiKey = '8D5BC4B5-019C-4052-8F08-54DFFDD9D052';
    Map<String, double?> cryptoPrices = {};

    for (String crypto in cryptoList) {
      String url =
          'https://rest.coinapi.io/v1/exchangerate/$crypto/$selectedCurrency?apikey=$apiKey';
      try {
        http.Response response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          var decodedData = jsonDecode(response.body);
          cryptoPrices[crypto] = decodedData['rate'];
        } else {
          print('Error: ${response.statusCode} for $crypto');
          cryptoPrices[crypto] = null;
        }
      } catch (e) {
        print('Error: $e for $crypto');
        cryptoPrices[crypto] = null;
      }
    }
    return cryptoPrices;
  }
}
