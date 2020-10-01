import 'package:echo/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:share/share.dart';

class Search extends StatefulWidget {
  @override

  _SearchState createState() => _SearchState();
}


class _SearchState extends State<Search> {
  QuotesModel model = QuotesModel();
  List<Quotes> quotesText;
    @override
  void initState() {
    model.setQuotes();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<List<Quotes>> search(String search) async {
  quotesText = model.quotes.where((test)=>test.text.contains(search)).toList();
  await Future.delayed(Duration(seconds: 2));
  return List.generate(quotesText.length, (int index) {
    
    print(quotesText);
    return Quotes(
      text : model.quotes[index].text,
      author: model.quotes[index].author!=null ? model.quotes[index].author: "Anonymous",
    );
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SearchBar<Quotes>(
            searchBarPadding: EdgeInsets.all(0),
            emptyWidget: Center(child: Text("No Quotes Found!", style: TextStyle(color:Colors.white),)),
            loader: Center(child: CircularProgressIndicator()),
            icon: Icon(Icons.search, color: Colors.blueAccent,),
            textStyle: TextStyle(color:Colors.white),
            cancellationWidget: Text("Cancel", style: TextStyle(color:Colors.blueAccent, fontSize: 16, fontWeight: FontWeight.w400),),
            hintText: "Search Quotes...",
            onSearch: search,
            onItemFound: (Quotes quotes, int index) {
              String quote = quotesText[index].text;
              String author = quotesText[index].author != null ? quotesText[index].author : "Anonymous";

              return GestureDetector(
                child: Card(
                color: Colors.grey.shade900,
                elevation: 5,
                    child: ListTile(
                      dense: false,
                  title: Padding(
                         padding: EdgeInsets.only(bottom: 2.5),
                         child:Text(quote,
                         style: TextStyle(color: Colors.white, fontFamily:"Kalam", fontWeight: FontWeight.w300, fontSize: 17),
                         )
                         ),

                  subtitle: Padding(
                         padding: EdgeInsets.only(bottom: 2.5),
                         child:Text(author,
                          style: TextStyle(color: Colors.blueAccent, fontFamily:"Kalam", fontWeight: FontWeight.w400, fontSize: 16 ),
                         )
                         ),
                ),
              ),
              // onTap: (){
              //   final Size size = MediaQuery.of(context).size;
              //   Share.share(
              //     "$quote\n\n$author",
              //     sharePositionOrigin: Rect.fromLTWH(0, 0, size.width, size.height / 2),
              //     );
              // },
              onLongPress: (){
                final Size size = MediaQuery.of(context).size;
                Share.share(
                  "$quote\n\n$author",
                  sharePositionOrigin: Rect.fromLTWH(0, 0, size.width, size.height / 2),
                  );
              },
              );
            },
          ),
        ),
      ),
      
    );
  }
}