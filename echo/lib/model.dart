import 'package:echo/apiService.dart';
import 'package:scoped_model/scoped_model.dart';

class Quotes {
  String author;
  String text;
  Quotes({this.author, this.text});
}

class QuotesModel extends Model {
  bool isLoading = true;
  bool processing = false;
  bool isExist = true;
  String author;
  String text;
  List<Quotes> quotes;
  var dataFromResponse;
  QuotesModel({this.author, this.text});

  Future setQuotes() async {
    dataFromResponse = await getQuotes();
    print(dataFromResponse.toString());

    if (dataFromResponse != null) {
      print(dataFromResponse.toString());
      List<Quotes> fetchedQuotes = [];
      dataFromResponse.forEach((q) {
        fetchedQuotes.add(
          new Quotes(
            author: q["author"],
            text: q["text"],
          ),
        );
      });

      this.quotes = fetchedQuotes;
    } else {
      this.isExist = false;
      print("No Quotes!");
    }

    this.isLoading = false;
    notifyListeners();
  }
}
