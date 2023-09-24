import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../responsive.dart';

class SettingSizeWidget extends StatefulWidget {
  bool isFocused = false;
  String title;
  String subtitle;
  IconData icon;
  int size;


  SettingSizeWidget({required this.isFocused, required this.title, required this.subtitle, required this.icon, required this.size});

  @override
  _SettingSizeWidgetState createState() => _SettingSizeWidgetState();
}

class _SettingSizeWidgetState extends State<SettingSizeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7,vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8,right: 15,top: 5,bottom: 5),
            child: Icon(
              widget.icon,
              color: Colors.white,
              size: 18,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 11

                  ),
                ),
                SizedBox(height:3),
                Text(
                  widget.subtitle,
                  style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.normal,
                      fontSize: 10
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40.h,
            child: Container(
                child: Row(
                  children: [

                    Container(
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            if(widget.size > 5)
                              widget.size --;

                            setSize(widget.size);
                          });
                        },
                        child: Icon(
                          Icons.keyboard_arrow_left,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      height: 30.h,
                      width: 30.w,
                      child: Center(
                        child: Text(
                          widget.size.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 15
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            if(widget.size< 45)
                              widget.size++;
                            setSize(widget.size);
                          });
                        },
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        color:  (widget.isFocused)?Colors.black:Colors.white.withOpacity(0),
      ),
    );
  }

  void setSize(int size) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("subtitle_size", size);
  }
}
