import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'coin_data.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  bool showSpinner = true;

  DropdownButton<String> androidDropDownButton() {
    return DropdownButton<String>(
        value: selectedCurrency,
        items: [
          DropdownMenuItem(
            child: Text('USD'),
            value: 'USD',
          ),
          DropdownMenuItem(
            child: Text('EUR'),
            value: 'EUR',
          ),
          DropdownMenuItem(
            child: Text('GBP'),
            value: 'GBP',
          ),
          DropdownMenuItem(
            child: Text('AUD'),
            value: 'AUD',
          ),
          DropdownMenuItem(
            child: Text('BRL'),
            value: 'BRL',
          ),
          DropdownMenuItem(
            child: Text('CAD'),
            value: 'CAD',
          ),
          DropdownMenuItem(
            child: Text('CHF'),
            value: 'CHF',
          ),
          DropdownMenuItem(
            child: Text('HKD'),
            value: 'HKD',
          ),
          DropdownMenuItem(
            child: Text('INR'),
            value: 'INR',
          ),
          DropdownMenuItem(
            child: Text('JPY'),
            value: 'JPY',
          ),
          DropdownMenuItem(
            child: Text('MXN'),
            value: 'MXN',
          ),
          DropdownMenuItem(
            child: Text('NOK'),
            value: 'NOK',
          ),
          DropdownMenuItem(
            child: Text('NZD'),
            value: 'NZD',
          ),
          DropdownMenuItem(
            child: Text('PLN'),
            value: 'PLN',
          ),
          DropdownMenuItem(
            child: Text('SEK'),
            value: 'SEK',
          ),
          DropdownMenuItem(
            child: Text('SGD'),
            value: 'SGD',
          ),
          DropdownMenuItem(
            child: Text('ZAR'),
            value: 'ZAR',
          ),
        ],
        onChanged: (value) {
          setState(() {
            selectedCurrency = value!;
            getData();
          });
        });
  }

  CupertinoPicker iOSPicker() {
    return CupertinoPicker(
      itemExtent: 40,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          getData();
        });
      },
      children: [
        Text('USD'),
        Text('BRL'),
        Text('CAD'),
        Text('CHF'),
        Text('EUR'),
        Text('GBP'),
        Text('HKD'),
        Text('INR'),
        Text('JPY'),
        Text('MXN'),
        Text('NOK'),
        Text('NZD'),
        Text('PLN'),
        Text('SEK'),
        Text('SGD'),
        Text('AUD'),
        Text('ZAR'),
      ],
    );
  }

  Widget? getPicker() {
    if (Platform.isIOS) {
      return iOSPicker();
    } else if (Platform.isAndroid) {
      return androidDropDownButton();
    }
  }

  String bitCoinValue = '?';
  String ethereumCoinValue = '?';
  String litecoinCoinValue = '?';

  void getData() async {
    setState(() {
      showSpinner = true;
    });
    try {
      double btcdata = await CoinData().getCoinData(selectedCurrency, 'BTC');
      double ethdata = await CoinData().getCoinData(selectedCurrency, 'ETH');
      double ltcdata = await CoinData().getCoinData(selectedCurrency, 'LTC');

      setState(() {
        bitCoinValue = btcdata.toStringAsFixed(0);
        ethereumCoinValue = ethdata.toStringAsFixed(0);
        litecoinCoinValue = ltcdata.toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }
    setState(() {
      showSpinner = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('💰 Coin Ticker 💰'),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 1),
                      spreadRadius: 0.2,
                      blurRadius: 3)
                ], color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.fromLTRB(18, 15, 18, 15),
                margin: EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                child: Center(
                  child: Text(
                    '1 BTC = $bitCoinValue $selectedCurrency',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 1),
                      spreadRadius: 0.2,
                      blurRadius: 3)
                ], color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.fromLTRB(18, 15, 18, 15),
                margin: EdgeInsets.symmetric(
                  horizontal: 28,
                ),
                child: Center(
                  child: Text(
                    '1 ETH = $ethereumCoinValue $selectedCurrency',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 1),
                      spreadRadius: 0.2,
                      blurRadius: 3)
                ], color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.fromLTRB(18, 15, 18, 15),
                margin: EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                child: Center(
                  child: Text(
                    '1 LTC = $litecoinCoinValue $selectedCurrency',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              Spacer(),
              Container(
                width: double.infinity,
                color: Colors.blue,
                height: 100,
                child: Center(
                  child: getPicker(),
                ),
              ),
            ],
          ),
          if (showSpinner == true)
            Center(
              child: SpinKitWave(
                color: Colors.orange,
                size: 100.0,
              ),
            ),
        ],
      ),
    );
  }
}
