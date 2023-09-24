import 'package:tvflix/model/poster.dart';

class CategoryMovie{
  int id;
  String title;
  List<Poster>? posters;

  CategoryMovie({required this.id, required this.title,this.posters});
  factory CategoryMovie.fromJson(Map<String, dynamic> parsedJson){

    List<Poster> posters =  [];
    if(parsedJson['posters'] != null)
    for(Map<String,dynamic> i in parsedJson['posters']){
      Poster poster = Poster.fromJson(i);
      posters.add(poster);
      }

    return CategoryMovie(
        id: parsedJson['id'],
        title : parsedJson['title'],
        posters : posters
    );
  }
}