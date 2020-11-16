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
  String fromCurrency = 'EUR';
  String toCurrency = 'EUR';

  Widget inputSection = Container(
    padding: const EdgeInsets.all(16),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Amount',
            ),
          ),
        ),
        CurrencyDropdownWidget(),
        CurrencyDropdownWidget(),
      ],
    )
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Currency Converter'),
        ),
        body: Column(
          children: [
            inputSection,
          ],
        ),
    );
  }
}

class CurrencyDropdownWidget extends StatefulWidget {
  CurrencyDropdownWidget({Key key, String value}) : super(key: key);

  @override
  _CurrencyDropdownState createState() => _CurrencyDropdownState();
}

class _CurrencyDropdownState extends State<CurrencyDropdownWidget> {
  String dropdownValue = 'EUR';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['EUR', 'SEK', 'USD', 'GBP', 'CNY', 'JPY', 'KRW']
          .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
      }).toList(),
    );
  }
}