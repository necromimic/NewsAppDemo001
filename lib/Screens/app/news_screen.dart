import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as Http;
import '../Login/components/background.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  var jsonData;
  List<ThailandNewsData> dataList = [];
  Future<String> _GetNewsAPI() async {
    var response = await Http.get(
      'https://newsapi.org/v2/top-headlines?country=th&apiKey=5fb86db5805444939302cd9db4c1b72d'
    );
    jsonData = json.decode(utf8.decode(response.bodyBytes));
    
    for (var data in jsonData['articles']) {
      print(data['title']);
    }
    
    return 'ok';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Thailand News'),
        ),
        body: Background(
          child: FutureBuilder(
            future: _GetNewsAPI(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView(
            children: <Widget>[
              Card(
                child: Image.network(
                  'https://c.tenor.com/_4YgA77ExHEAAAAd/rick-roll.gif'),
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
                margin: EdgeInsets.all(15),
              ),
            ],
              } else {
                return Container(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        ),
      ),
    );
  }
}

class ThailandNewsData {
  String title;
  String description;
  String urlToImage;
  ThailandNewsData(this.title, this.description, this.urlToImage);
}