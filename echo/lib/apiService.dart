import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

getQuotes() async {
  var quotesResponse;

  String url = "https://type.fit/api/quotes";

  var response =
      await http.get(url, headers: {"Content-Type": "application/json"});

  print(response);

  if (response.statusCode == 200) {
    quotesResponse = convert.jsonDecode(response.body);
    print(quotesResponse.toString());
  } else {
    print("Quotes Not Fetched From The Rest API");
  }

  return quotesResponse;
}
