import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

Future<http.Response> fetchRates() {
  return http.get('http://data.fixer.io/api/latest?access_key=c9adcc50bd651ddb64dcf0a8cb2cb5b8');
}

class Rates {
  final double eur;
  final double sek;
  final double usd;
  final double gbp;
  final double cny;
  final double jpy;
  final double krw;

  Rates({this.eur, this.sek, this.usd, this.gbp, this.cny, this.jpy, this.krw});

  factory Rates.fromJson(Map<String, dynamic> json) {
    return Rates(
      eur: json['eur'],
      sek: json['sek'],
      usd: json['usd'],
      gbp: json['gbp'],
      cny: json['cny'],
      jpy: json['jpy'],
      krw: json['krw'],
    );
  }
}