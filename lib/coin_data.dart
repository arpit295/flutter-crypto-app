import 'dart:convert';
import 'package:http/http.dart';

List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CHF',
  'EUR',
  'GBP',
  'HKD',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

List<String> cryptoCurrencyList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<dynamic> getCoinData(
      String selectedCurrency, String selectedcrypto) async {
    Response response = await get(Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/$selectedcrypto/$selectedCurrency?apikey=086621f1-8711-4032-9f00-05896f175816'));

    if (response.statusCode == 200) {
      String data = response.body;
      var decodeData = jsonDecode(data);
      var lastPrice = decodeData['rate'];
      return lastPrice;
    } else {
      print(response.statusCode);
      throw 'Problem with the get request';
    }
  }
}
