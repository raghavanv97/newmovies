import 'dart:async';
//import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:path_provider/path_provider.dart';

import 'package:newmovies/NewMovies.dart';
//import 'package:http/http.dart' as http;

class moviesDetails extends StatelessWidget {
  static const platform =
      const MethodChannel('vijayaraghavan.com/downloadTorrent');

  newMovies movies;

  moviesDetails({this.movies});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(movies.title),
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.all(10.0),
            alignment: Alignment.topCenter,
            height: 300.0,
            width: double.infinity,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  padding: const EdgeInsets.only(right: 10.0),
                  height: 200.0,
                  child: new Hero(
                      tag: movies.title,
                      child: Image.network(movies.background_image_original)),
                ),
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      movies.title,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal),
                    ),
                    new Padding(
                      padding: EdgeInsets.all(10.0),
                    ),
                    new Text(
                      "Release Year : ${movies.year}",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    )
                  ],
                )
              ],
            ),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new OutlineButton(
                onPressed: () {
                  download(movies.download720, movies.title + "[720p]");
                },
                child: new Text("720p"),
              ),
              new OutlineButton(
                onPressed: () {
                  download(movies.download1080, movies.title + "[1080p]");
                },
                child: new Text("1080p"),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future download(String url, String movieTitle) async {
//    http.Response response = await http.get(url);
//    print(response.bodyBytes);
//  var path = _localPath;
//  print(path);
//    http.get(url).then((respone){
//      new File(path).writeAsBytes(respone.bodyBytes);
//    });

    try {
      //Download .torrent file in android/iOS platform communication
      await platform.invokeMethod(
          'downloadTorrentFile', {"url": url, "Title": movieTitle});
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }
/*

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }


  Future<File> get _localFile async {
    final path = await _localPath;
    return new File('$path/movies.torrent');
  }

  */

}
