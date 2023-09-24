import 'package:flutter/material.dart';
import 'package:tvflix/model/category_movie.dart';

class CategoryMovieWidget extends StatelessWidget {
  bool? isFocused;
  int? selected_category;
  int? index;
  CategoryMovie? categoryMovi;

  CategoryMovieWidget({this.isFocused,this.selected_category, this.index,this.categoryMovi});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7,vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              categoryMovi!.title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          Container(
            child: Theme(
              data: ThemeData.dark(),
              child: Radio(
                value:index!,
                activeColor: Colors.white,
                groupValue: selected_category, onChanged: (int? value) {  },
              ),
            ),
            decoration: BoxDecoration(
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        color:  (isFocused!)?Colors.black.withOpacity(0.9):Colors.white.withOpacity(0),
      ),
    );
  }
}