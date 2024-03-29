import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'Currency.dart';

class MainAppPage extends StatefulWidget {
  MainAppPage({Key key}) : super(key: key);

  @override
  _MainAppPageState createState() => _MainAppPageState();
}

class UserPosition {
  double latitude;
  double longitude;

  @override
  String toString() {
    return latitude.toString() + ', ' + longitude.toString();
  }

  Future<String> getCurrencyString() async {
    final response = await http.get('https://api.opencagedata.com/geocode/v1/json?key=1710e48cd0304aebbec7a7698fbea888&q=$latitude,$longitude');
    dynamic responseJson = json.decode(response.body);
    return responseJson['results'][0]['annotations']['currency']['iso_code'];
  }
}

class _MainAppPageState extends State<MainAppPage> {
  final amountController = TextEditingController();

  String fromCurrency;
  String toCurrency;
  double amount = 0.0;
  Future<RateList> futureRates;
  Future<Position> futurePosition;

  GlobalKey<CurrencyDropdownState> _fromCurrencyDropdown = GlobalKey();

  UserPosition userCoordinates = UserPosition();

  @override
  void initState() {
    super.initState();
    futureRates = getRateList();
    loadCurrencyHolderData();
    fromCurrency = null;

    _determinePosition().then((value) => setState(() {
      userCoordinates.latitude = value.latitude;
      userCoordinates.longitude = value.longitude;
    })).then((value) {
      userCoordinates.getCurrencyString().then((value) => setState(() { _fromCurrencyDropdown.currentState.setSelectedCurrency(value); }));
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    amountController.dispose();
    super.dispose();
  }

  void loadCurrencyHolderData(){
    CurrencyHolder.currencies.forEach((k, v) {
      futureRates.then((value) => CurrencyHolder.currencies[k] = value.rates[k]);
    });
  }

  FutureBuilder<RateList> findCurrencyRate (String cur){
    return  FutureBuilder<RateList>(
      future: futureRates,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data.rates[cur].toStringAsFixed(5));
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default
        return CircularProgressIndicator();
      },
    );
  }

  void updateFromCurrency(String currency) => setState(() => fromCurrency = currency);
  void updateToCurrency(String currency) => setState(() => toCurrency = currency);

  void onAmountChanged(String string) => setState(() => amount =
      double.tryParse(amountController.text.replaceAll(' ', '')) ?? 0.0);

  double currencyConversion(
      String fromCurrency, String toCurrency, double amount) =>
      (fromCurrency != null && toCurrency != null )
          ? ((amount * CurrencyHolder.currencies[toCurrency]) / CurrencyHolder.currencies[fromCurrency])
          : 0.0;

  String getInputCurrencyName() =>
      (fromCurrency != null) ? ' ' + fromCurrency : '';

  String getResultCurrencyName() =>
      (toCurrency != null) ? ' ' + toCurrency : '';

  String getResultFormatted() =>
      currencyConversion(fromCurrency, toCurrency, amount).toStringAsFixed(3) +
          getResultCurrencyName();

  void openExchangeRatesPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Exchange Rates'),
          ),
          body: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    DataTable(
                      columnSpacing: 40,
                      columns: const <DataColumn>[

                        DataColumn(
                          label: Text(
                            '  ',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),

                        DataColumn(
                          label: Text(
                            'EUR',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),

                        DataColumn(
                          label: Text(
                            'SEK',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),

                        DataColumn(
                          label: Text(
                            'USD',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),

                        DataColumn(
                          label: Text(
                            'GBP',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),

                        DataColumn(
                          label: Text(
                            'CNY',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),

                        DataColumn(
                          label: Text(
                            'JPY',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),

                        DataColumn(
                          label: Text(
                            'KRW',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                      rows:  <DataRow>[



                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('EUR')),
                            DataCell(Text(currencyConversion('EUR', 'EUR', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('EUR', 'SEK', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('EUR', 'USD', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('EUR', 'GBP', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('EUR', 'CNY', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('EUR', 'JPY', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('EUR', 'KRW', 1).toStringAsFixed(5))),
                          ],
                        ),

                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('SEK')),
                            DataCell(Text(currencyConversion('SEK', 'EUR', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('SEK', 'SEK', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('SEK', 'USD', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('SEK', 'GBP', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('SEK', 'CNY', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('SEK', 'JPY', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('SEK', 'KRW', 1).toStringAsFixed(5))),
                          ],
                        ),

                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('USD')),
                            DataCell(Text(currencyConversion('USD', 'EUR', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('USD', 'SEK', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('USD', 'USD', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('USD', 'GBP', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('USD', 'CNY', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('USD', 'JPY', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('USD', 'KRW', 1).toStringAsFixed(5))),
                          ],
                        ),

                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('GBP')),
                            DataCell(Text(currencyConversion('GBP', 'EUR', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('GBP', 'SEK', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('GBP', 'USD', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('GBP', 'GBP', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('GBP', 'CNY', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('GBP', 'JPY', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('GBP', 'KRW', 1).toStringAsFixed(5))),
                          ],
                        ),

                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('CNY')),
                            DataCell(Text(currencyConversion('CNY', 'EUR', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('CNY', 'SEK', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('CNY', 'USD', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('CNY', 'GBP', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('CNY', 'CNY', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('CNY', 'JPY', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('CNY', 'KRW', 1).toStringAsFixed(5))),
                          ],
                        ),

                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('JPY')),
                            DataCell(Text(currencyConversion('JPY', 'EUR', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('JPY', 'SEK', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('JPY', 'USD', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('JPY', 'GBP', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('JPY', 'CNY', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('JPY', 'JPY', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('JPY', 'KRW', 1).toStringAsFixed(5))),
                          ],
                        ),

                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('KRW')),
                            DataCell(Text(currencyConversion('KRW', 'EUR', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('KRW', 'SEK', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('KRW', 'USD', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('KRW', 'GBP', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('KRW', 'CNY', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('KRW', 'JPY', 1).toStringAsFixed(5))),
                            DataCell(Text(currencyConversion('KRW', 'KRW', 1).toStringAsFixed(5))),
                          ],
                        ),
                      ],
                    ),
                  ]
              )
          ),
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Currency Converter'),
          actions: [
            IconButton(
              icon: Icon(Icons.table_view_outlined),
              onPressed: () {
                openExchangeRatesPage(context);
              },
            ),
          ],
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      width: 200,
                      child: TextField(
                        controller: amountController,
                        decoration: InputDecoration(
                          hintText: 'Amount',
                          suffixText: getInputCurrencyName(),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: onAmountChanged,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 16),
                      child: CurrencyDropdown(
                        key: _fromCurrencyDropdown,
                        onCurrencyChanged: updateFromCurrency,
                        hint: 'From',
                      ),
                    ),
                    Icon(
                      Icons.arrow_right_alt,
                      size: 32,
                      color: Colors.grey[700],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      child: CurrencyDropdown(
                        onCurrencyChanged: updateToCurrency,
                        hint: 'To',
                        defaultCurrency: 'SEK',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      color: Colors.green[200],
                      padding: EdgeInsets.all(4),
                      margin: EdgeInsets.only(top: 16),
                      child: Text(
                        getResultFormatted(),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container (
                      margin: EdgeInsets.only(top: 16),
                      child: Text(
                        userCoordinates.toString(),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permission is permanently denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permission is denied (actual value: $permission).');
      }
    }

    return await Geolocator.getCurrentPosition();
  }
}