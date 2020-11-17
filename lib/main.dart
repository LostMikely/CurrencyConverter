import 'package:flutter/material.dart';

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
  Currency fromCurrency = Currency('SEK', 1.00);
  Currency toCurrency;
  final amountController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    amountController.dispose();
    super.dispose();
  }

  void updateFromCurrency(Currency currency) => setState(() => amountController.text = currency.name);
  void updateToCurrency(Currency currency) => setState(() => toCurrency = currency);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter'),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: amountController,
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 8),
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
              margin: EdgeInsets.only(left: 8),
              child: CurrencyDropdown(
                onCurrencyChanged: updateToCurrency,
                hint: 'To',
              ),
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

  CurrencyDropdown({Key key, @required this.onCurrencyChanged, @required this.hint}) : super(key: key);

  @override
  _CurrencyDropdownState createState() => _CurrencyDropdownState(onCurrencyChanged: this.onCurrencyChanged, hint: this.hint);
}

class _CurrencyDropdownState extends State<CurrencyDropdown> {
  final CurrencyCallback onCurrencyChanged;
  final String hint;

  // 'GBP', 'CNY', 'JPY', 'KRW'
  static Currency curEur = Currency('EUR', 0.19);
  static Currency curSek = Currency('SEK', 1.00);
  static Currency curUsd = Currency('USD', 0.20);
  static List<Currency> currencies = [curEur, curSek, curUsd];
  Currency selectedCurrency = curEur;

  _CurrencyDropdownState({@required this.onCurrencyChanged, @required this.hint});


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