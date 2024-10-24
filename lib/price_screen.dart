import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  late CoinData coinData;
  Map<String, double?> cryptoPrices = {};

  @override
  void initState() {
    super.initState();
    coinData = CoinData();
    getData();
  }

  void getData() async {
    try {
      cryptoPrices = await coinData.getCoinData(selectedCurrency);
      setState(() {});
    } catch (e) {
      print('Error: $e');
    }
  }

  List<Widget> getPickerItems() {
    List<Text> picks = [];
    for (String currency in currenciesList) {
      picks.add(Text(currency));
    }
    return picks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ...cryptoList.map((crypto) => Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 $crypto = ${cryptoPrices[crypto] != null ? cryptoPrices[crypto]!.toStringAsFixed(0) : '?'} $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: CupertinoPicker(
              backgroundColor: Colors.blue,
              itemExtent: 32,
              onSelectedItemChanged: (selectedIndex) {
                setState(() {
                  selectedCurrency = currenciesList[selectedIndex];
                  getData();
                });
              },
              children: getPickerItems(),
            ),
          ),
        ],
      ),
    );
  }
}
