import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tvflix/model/category.dart';
import 'package:tvflix/ui/channel/channels.dart';
import 'package:tvflix/ui/movie/movies.dart';

class CategoryWidget extends StatelessWidget {
  bool isFocused;
  int selected_category;
  int index;
  Category  category;


  CategoryWidget({required this.isFocused,required this.selected_category, required this.index,required this.category});

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
              category.title,
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
                  value:index,
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
        color:  (isFocused)?Colors.black.withOpacity(0.9):Colors.white.withOpacity(0),
      ),
    );
  }
}