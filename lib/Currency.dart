import 'package:flutter/material.dart';

typedef void CurrencyCallback(String currency);

class CurrencyDropdown extends StatefulWidget {
  final CurrencyCallback onCurrencyChanged;
  final String selectedCurrency;
  final String hint;

  CurrencyDropdown(
      {Key key, @required this.onCurrencyChanged, @required this.hint, @required this.selectedCurrency})
      : super(key: key);

  @override
  _CurrencyDropdownState createState() => _CurrencyDropdownState(
      onCurrencyChanged: this.onCurrencyChanged, hint: this.hint, selectedCurrency: this.selectedCurrency);
}

class _CurrencyDropdownState extends State<CurrencyDropdown> {
  final CurrencyCallback onCurrencyChanged;
  final String hint;

  String selectedCurrency;

  _CurrencyDropdownState(
      {@required this.onCurrencyChanged, @required this.hint, @required this.selectedCurrency});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Text(hint),
      icon: Icon(Icons.arrow_downward),
      value: selectedCurrency,
      iconSize: 24,
      elevation: 16,
      onChanged: (String newCurrency) {
        selectedCurrency = newCurrency;
        onCurrencyChanged(newCurrency);
      },
      items: CurrencyHolder.currencies.map((String currency, double rate) {
        return MapEntry(
            currency,
            DropdownMenuItem(
              value: currency,
              child: Text(currency),
            )
        );
      }).values.toList(),
    );
  }
}

class CurrencyHolder {
  static Map<String, double> currencies = {
    'EUR' : 1.0,
    'SEK' : 0.0977427,
    'USD' : 0.845273,
    'GBP' : 1.12364,
    'CNY' : 0.128277,
    'JPY' : 0.00808749,
    'KRW' : 0.000757060
  };
}