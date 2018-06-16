import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:newmovies/MoviesDetail.dart';
import 'package:newmovies/NewMovies.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static bool needVPN = false;

  static const platform = const MethodChannel('vijayaraghavan.com/vpn');

  @override
  void initState() {
    super.initState();
    fetchJson();

  }

  List<newMovies> newMoviesList;

  Future<List<newMovies>> fetchJson() async {
    try {
      http.Response response =
          await http.get("https://yts.am/api/v2/list_movies.json?limit=50");
      print(response.body);
      var jsonresult = json.decode(response.body);

      print(jsonresult['data']['movies'][0]['year']);
      newMoviesList = List.generate(50, (index) {
        newMovies.count = index;
        return new newMovies.fromJson(jsonresult);
      });

      setState(() {needVPN = false;});
      print(newMoviesList.length);
      for (var i in newMoviesList) {
        print(
            "${i.rating} ${i.year} ${i.title} ${i.background_image_original}");
      }
    } catch (e) {
      print(e.toString());
      setState(() {
        needVPN = true;
      });


    }
    return newMoviesList;
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "New Movies",
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text("New Movies"),
            actions: <Widget>[
              new IconButton(icon: new Icon(Icons.search), onPressed: (){

              })
            ],
          ),
          body: newMoviesList != null
              ? new ListView.builder(
                  itemCount: newMoviesList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                moviesDetails(movies: newMoviesList[index])));
                      },
                      child: Card(
                        elevation: 1.0,
                        child: new Column(
                          children: <Widget>[
                            Hero(
                              tag: newMoviesList[index].title,
                              child: new FadeInImage(
                                  placeholder:
                                      new AssetImage("assets/Movies_Logo.jpg"),
                                  image: new NetworkImage(newMoviesList[index]
                                      .background_image_original)),
                            ),
                            new Padding(
                                padding: const EdgeInsets.only(top: 3.0)),
                            new Text(newMoviesList[index].title),
                          ],
                        ),
                      ),
                    );
                  })
              : (!needVPN
                  ? Center(child: new CircularProgressIndicator())
                  : Center(
                      child: Text("Please Enable VPN"),
                    ))),
    );
  }
}
