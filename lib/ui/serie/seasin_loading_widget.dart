import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../responsive.dart';

class SeasonLoadingWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Container(
        color: Color(0xFF1a1a1a),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              // margin:  EdgeInsets.only(right: MediaQuery.of(context).size.width/5,left: MediaQuery.of(context).size.width/5),
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white70,
                    ),
                    margin: EdgeInsets.only(top: 180.h),
                    // width: MediaQuery.of(context).size.width / 1,
                    // height: MediaQuery.of(context).size.height / 1,
                    width: Responsive.isMobile(context) ? 220.w : 110.w,
                    height: Responsive.isMobile(context) ? 200.h : 300.h,
                    child: Image.network(
                      "https://media.discordapp.net/attachments/1075374585987481661/1078357288886222989/512-512.png",
                      fit: BoxFit.cover,
                      // color: Colors.white.withOpacity(0.2),
                      colorBlendMode: BlendMode.modulate,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 150.h,
              child: TextLiquidFill(
                textAlign: TextAlign.center,
                text: 'تلفازك بين يديك',
                waveColor: Color(0xFF0359f8),
                boxBackgroundColor: Color(0xFFffffff),
                // boxBackgroundColor: Color(0xFF0359f8),
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w300,
                ),
                boxHeight: 47.0,
                // boxWidth: 220.w,
                boxWidth: Responsive.isMobile(context) ? 220.w : 110.w,

              ),
            ),
            SizedBox(
              height: 50,
            ),
            Positioned(
              bottom: 50,
              child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white.withOpacity(0.9),
                    strokeWidth: 7,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
