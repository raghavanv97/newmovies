import 'package:flutter/material.dart';


class newMovies{
  static int count = 0;
  String download720;
  String download1080;
  String title;
  var year;
  var rating;
  String background_image_original;

  newMovies({this.title, this.year, this.rating, this.background_image_original,
    this.download720, this.download1080});

  factory newMovies.fromJson(Map<String, dynamic> json){
    return new newMovies(
        title: json['data']['movies'][count]['title'] ,
        year: json['data']['movies'][count]['year'] ,
        rating: json['data']['movies'][count]['rating'] ,
        background_image_original: json['data']['movies'][count]['large_cover_image'],
        download720: json['data']['movies'][count]['torrents'][0]['hash'],
        download1080: json['data']['movies'][count]['torrents'][1]['hash']


    );
  }

}