import 'package:echo/search.dart';
import 'package:flutter/material.dart';
import 'package:echo/model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:share/share.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Quotes(),
    ));

class Quotes extends StatefulWidget {
  @override
  _QuotesState createState() => _QuotesState();
}

class _QuotesState extends State<Quotes> {
  QuotesModel model = QuotesModel();

  @override
  void initState() {
    model.setQuotes();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<QuotesModel>(
      model: model,
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade900,
          title: Text("Echo", style: TextStyle(
            fontFamily: "Kalam", fontWeight: FontWeight.w600
          ),),
          centerTitle: true,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: (){
              print("Search Icon Tapped!");
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Search()));
            }),
          ],
        ),
        drawer: Drawer(
          child: Container(
            color: Colors.grey.shade900,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    title: Text(
                      "API:",
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      "https://type.fit/api/quotes",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Developed By:",
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      "Tahsin Ismail",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                ]),
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) => Container(
            child: ScopedModelDescendant<QuotesModel>(
              builder: (context, child, model) {
                model = model;
                return model.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: model.quotes.length,
                        itemBuilder: (BuildContext context, int index) {
                          String quote = model.quotes[index].text;
                          String author = model.quotes[index].author != null ? model.quotes[index].author : "Anonymous";
                          return GestureDetector(
                              child: Card(
                              elevation: 5.0,
                              color: Colors.grey.shade900,
                              child: ListTile(
                                dense: false,
                                title: model.quotes[index].text != null
                                    ? Padding(
                                        padding: EdgeInsets.only(bottom: 2.5),
                                        child: Text(
                                          quote,
                                          style: TextStyle(color: Colors.white, fontFamily:"Kalam", fontWeight: FontWeight.w300, fontSize: 17),
                                        ))
                                    : Padding(
                                        padding: EdgeInsets.only(bottom: 2.5),
                                        child: Text(
                                          "They Said So Much, Now It's Your Turn!",
                                          style: TextStyle(color: Colors.red),
                                        )),
                               
                                subtitle: model.quotes[index].author != null 
                                    ? Padding(
                                        padding: EdgeInsets.only(top: 2.5),
                                        child: Text(
                                          author,
                                          style:
                                              TextStyle(color: Colors.blueAccent, fontFamily:"Kalam", fontWeight: FontWeight.w400, fontSize: 16 ),
                                        ))
                                    : Padding(
                                        padding: EdgeInsets.only(top: 2.5),
                                        child: Text(
                                          "Anonymous",
                                          style: TextStyle(color: Colors.blueAccent, fontFamily:"Kalam", fontWeight: FontWeight.w400, fontSize: 16 ),
                                        )),
                              ),
                            ),

                            // onTap: (){
                            // final Size size = MediaQuery.of(context).size;
                            //   Share.share(
                            //   "$quote\n\n$author",
                            //   sharePositionOrigin: Rect.fromLTWH(0, 0, size.width, size.height / 2),
                            //      );
                            //     },
                            onLongPress: (){
                            final Size size = MediaQuery.of(context).size;
                            Share.share(
                            "$quote\n\n$author",
                            sharePositionOrigin: Rect.fromLTWH(0, 0, size.width, size.height / 2),
                              );
                                },
                            

                          );
                        },
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
