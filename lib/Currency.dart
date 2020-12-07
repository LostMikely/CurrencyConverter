import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

Future<RateList> getRateList() async {
  final response = await http.get('http://data.fixer.io/api/latest?access_key=c9adcc50bd651ddb64dcf0a8cb2cb5b8');

  if(response.statusCode == 200){
    return RateList.fromJson(json.decode(response.body));

  } else {

    return null;
  }
}


class RateList{
  final bool success;
  final int timestamp;
  final String base;
  final String date;
  final Map<String, dynamic> rates;


  RateList({this.success, this.timestamp, this.base, this.date, this.rates});

  factory RateList.fromJson(Map<String, dynamic> json){
    return RateList(
        success: json["success"],
        timestamp: json["timestamp"],
        base: json["base"],
        date: json["date"],
        rates: json["rates"]
    );
  }
}