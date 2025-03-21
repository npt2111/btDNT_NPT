import 'dart:convert';
import 'package:http/http.dart' as http;

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

const List<String> cryptoList = ['BTC', 'ETH', 'LTC'];

const String coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const String apiKey = 'YOUR-API-KEY-HERE';

class CoinData {
  Future<Map<String, String>> getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};

    for (String crypto in cryptoList) {
      String requestURL = '$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey';

      try {
        final Uri url = Uri.parse(requestURL);
        http.Response response = await http.get(url);

        if (response.statusCode == 200) {
          var decodedData = jsonDecode(response.body);
          double price = decodedData['rate'];
          cryptoPrices[crypto] = price.toStringAsFixed(2);
        } else {
          print('Error: ${response.statusCode}');
          throw Exception('Lỗi khi lấy dữ liệu từ API');
        }
      } catch (e) {
        print('Exception: $e');
      }
    }
    return cryptoPrices;
  }
}
