import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

typedef void CurrencyCallback(String currency);

class CurrencyDropdown extends StatefulWidget {
  final CurrencyCallback onCurrencyChanged;
  final String defaultCurrency;
  final String hint;

  CurrencyDropdown(
      {Key key, @required this.onCurrencyChanged, @required this.hint, this.defaultCurrency})
      : super(key: key);

  @override
  CurrencyDropdownState createState() => CurrencyDropdownState();
}

class CurrencyDropdownState extends State<CurrencyDropdown> {
  String selectedCurrency;
  @override
  void initState() {
    if(widget.defaultCurrency != null) {
      selectedCurrency = widget.defaultCurrency;
    }
    super.initState();
  }

  void setSelectedCurrency(String currency)
  {
    setState(() {
      selectedCurrency = currency;
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() => widget.onCurrencyChanged(selectedCurrency)));
    return DropdownButton<String>(
      //hint: Text(hint),
      icon: Icon(Icons.arrow_downward),
      value: selectedCurrency,
      iconSize: 24,
      elevation: 16,
      onChanged: (String newCurrency) {
        setState(() {
          selectedCurrency = newCurrency;
          widget.onCurrencyChanged(newCurrency);
        });
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
    'SEK' : 10.09163,
    'USD' : 1.21609,
    'GBP' : 0.88560,
    'CNY' : 7.86229,
    'JPY' : 126.06276,
    'KRW' : 1341.54551
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