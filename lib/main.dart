import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      home: MainAppPage(),
    );
  }
}

class MainAppPage extends StatefulWidget {
  MainAppPage({Key key}) : super(key: key);

  @override
  _MainAppPageState createState() => _MainAppPageState();
}

class _MainAppPageState extends State<MainAppPage> {
  final amountController = TextEditingController();

  Currency fromCurrency;
  Currency toCurrency;
  double amount = 0.0;

  Future<http.Response> fetchRates() {
    return http.get('http://data.fixer.io/api/latest?access_key=c9adcc50bd651ddb64dcf0a8cb2cb5b8');
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    amountController.dispose();
    super.dispose();
  }

  void updateFromCurrency(Currency currency) =>
      setState(() => fromCurrency = currency);

  void updateToCurrency(Currency currency) =>
      setState(() => toCurrency = currency);

  void onAmountChanged(String string) => setState(() => amount =
      double.tryParse(amountController.text.replaceAll(' ', '')) ?? 0.0);

  double currencyConversion(
          Currency fromCurrency, Currency toCurrency, double amount) =>
      (fromCurrency != null && toCurrency != null)
          ? ((amount * fromCurrency.rate) / toCurrency.rate)
          : 0.0;

  String getInputCurrencyName() =>
      (fromCurrency != null) ? ' ' + fromCurrency.name : '';

  String getResultCurrencyName() =>
      (toCurrency != null) ? ' ' + toCurrency.name : '';

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
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curEur, _CurrencyDropdownState.curEur, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curEur, _CurrencyDropdownState.curSek, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curEur, _CurrencyDropdownState.curUsd, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curEur, _CurrencyDropdownState.curGbp, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curEur, _CurrencyDropdownState.curCny, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curEur, _CurrencyDropdownState.curJpy, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curEur, _CurrencyDropdownState.curKrw, 1).toStringAsFixed(5))),
                  ],
                ),

                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('SEK')),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curSek, _CurrencyDropdownState.curEur, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curSek, _CurrencyDropdownState.curSek, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curSek, _CurrencyDropdownState.curUsd, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curSek, _CurrencyDropdownState.curGbp, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curSek, _CurrencyDropdownState.curCny, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curSek, _CurrencyDropdownState.curJpy, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curSek, _CurrencyDropdownState.curKrw, 1).toStringAsFixed(5))),
                  ],
                ),

                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('USD')),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curUsd, _CurrencyDropdownState.curEur, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curUsd, _CurrencyDropdownState.curSek, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curUsd, _CurrencyDropdownState.curUsd, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curUsd, _CurrencyDropdownState.curGbp, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curUsd, _CurrencyDropdownState.curCny, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curUsd, _CurrencyDropdownState.curJpy, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curUsd, _CurrencyDropdownState.curKrw, 1).toStringAsFixed(5))),
                  ],
                ),

                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('GBP')),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curGbp, _CurrencyDropdownState.curEur, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curGbp, _CurrencyDropdownState.curSek, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curGbp, _CurrencyDropdownState.curUsd, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curGbp, _CurrencyDropdownState.curGbp, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curGbp, _CurrencyDropdownState.curCny, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curGbp, _CurrencyDropdownState.curJpy, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curGbp, _CurrencyDropdownState.curKrw, 1).toStringAsFixed(5))),
                  ],
                ),

                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('CNY')),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curCny, _CurrencyDropdownState.curEur, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curCny, _CurrencyDropdownState.curSek, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curCny, _CurrencyDropdownState.curUsd, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curCny, _CurrencyDropdownState.curGbp, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curCny, _CurrencyDropdownState.curCny, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curCny, _CurrencyDropdownState.curJpy, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curCny, _CurrencyDropdownState.curKrw, 1).toStringAsFixed(5))),
                  ],
                ),

                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('JPY')),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curJpy, _CurrencyDropdownState.curEur, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curJpy, _CurrencyDropdownState.curSek, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curJpy, _CurrencyDropdownState.curUsd, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curJpy, _CurrencyDropdownState.curGbp, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curJpy, _CurrencyDropdownState.curCny, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curJpy, _CurrencyDropdownState.curJpy, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curJpy, _CurrencyDropdownState.curKrw, 1).toStringAsFixed(5))),
                  ],
                ),

                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('KRW')),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curKrw, _CurrencyDropdownState.curEur, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curKrw, _CurrencyDropdownState.curSek, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curKrw, _CurrencyDropdownState.curUsd, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curKrw, _CurrencyDropdownState.curGbp, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curKrw, _CurrencyDropdownState.curCny, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curKrw, _CurrencyDropdownState.curJpy, 1).toStringAsFixed(5))),
                    DataCell(Text(currencyConversion(_CurrencyDropdownState.curKrw, _CurrencyDropdownState.curKrw, 1).toStringAsFixed(5))),
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
                        // toCurrency.name is null at first, do something about this.
                        getResultFormatted(),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

typedef void CurrencyCallback(Currency currency);

class CurrencyDropdown extends StatefulWidget {
  final CurrencyCallback onCurrencyChanged;
  final String hint;

  CurrencyDropdown(
      {Key key, @required this.onCurrencyChanged, @required this.hint})
      : super(key: key);

  @override
  _CurrencyDropdownState createState() => _CurrencyDropdownState(
      onCurrencyChanged: this.onCurrencyChanged, hint: this.hint);
}

class _CurrencyDropdownState extends State<CurrencyDropdown> {
  final CurrencyCallback onCurrencyChanged;
  final String hint;

  static Currency curEur = Currency('EUR', 1.0);
  static Currency curSek = Currency('SEK', 0.0977427);
  static Currency curUsd = Currency('USD', 0.845273);
  static Currency curGbp = Currency('GBP', 1.12364);
  static Currency curCny = Currency('CNY', 0.128277);
  static Currency curJpy = Currency('JPY', 0.00808749);
  static Currency curKrw = Currency('KRW', 0.000757060);
  static List<Currency> currencies = [
    curEur,
    curSek,
    curUsd,
    curGbp,
    curCny,
    curJpy,
    curKrw
  ];
  Currency selectedCurrency;

  _CurrencyDropdownState(
      {@required this.onCurrencyChanged, @required this.hint});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Currency>(
      hint: Text(hint),
      icon: Icon(Icons.arrow_downward),
      value: selectedCurrency,
      iconSize: 24,
      elevation: 16,
      onChanged: (Currency newCurrency) {
        onCurrencyChanged(newCurrency);
        selectedCurrency = newCurrency;
      },
      items: currencies.map((Currency currency) {
        return DropdownMenuItem<Currency>(
          value: currency,
          child: Text(currency.name),
        );
      }).toList(),
    );
  }
}

class Currency {
  final String name;
  final double rate;

  const Currency(this.name, this.rate);
}
