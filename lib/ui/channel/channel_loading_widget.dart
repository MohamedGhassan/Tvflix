import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../responsive.dart';

class ChannelLoadingWidget extends StatelessWidget {
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
      // return Positioned(
      //   bottom: 0,
      //   left: 45,
      //   right: 45,
      //   child: Container(
      //     width: MediaQuery.of(context).size.width,
      //     height:  MediaQuery.of(context).size.height -70,
      //     child: Container(
      //       child: Wrap(
      //         children: [
      //           Stack(
      //             children: [
      //               Container(
      //                 height: 190,
      //                 margin:  EdgeInsets.only(right: MediaQuery.of(context).size.width/5),
      //                 child: Column(
      //                   mainAxisSize: MainAxisSize.max,
      //                   mainAxisAlignment: MainAxisAlignment.start,
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     SizedBox(height: 10),
      //                     Container(
      //                       width: 300,
      //                       height: 35,
      //                       color: Colors.white70,
      //                     ),
      //                     SizedBox(height: 30),
      //                     Row(
      //                       children: [
      //                         Container(
      //                           width: 45,
      //                           height: 18,
      //                           color: Colors.white70,
      //                         ),
      //                         SizedBox(width: 5),
      //                         Container(
      //                           width: 110,
      //                           height: 18,
      //                           color: Colors.white70,
      //                         ),
      //                         SizedBox(width: 10),
      //                       ],
      //                     ),
      //                     SizedBox(height: 10),
      //                     Row(
      //                       children: [
      //                         Container(
      //                           width: 70,
      //                           height: 18,
      //                           color: Colors.white70,
      //                         ),
      //                         SizedBox(width: 5),
      //                         Container(
      //                           width: 70,
      //                           height: 18,
      //                           color: Colors.white70,
      //                         ),
      //                         SizedBox(width: 10),
      //                         Container(
      //                           width: 70,
      //                           height: 18,
      //                           color: Colors.white70,
      //                         ),
      //
      //                         SizedBox(width: 5),
      //                         Container(
      //                           width: 70,
      //                           height: 18,
      //                           color: Colors.white70,
      //                         ),
      //                         SizedBox(width: 5),
      //                         Container(
      //                           width: 40,
      //                           height: 18,
      //                           color: Colors.white70,
      //                         ),
      //                         SizedBox(width: 5),
      //                         Container(
      //                           width: 40,
      //                           height: 18,
      //                           color: Colors.white70,
      //                         ),
      //                         SizedBox(width: 5),
      //                         Container(
      //                           width: 40,
      //                           height: 18,
      //                           color: Colors.white70,
      //                         ),
      //                       ],
      //                     ),
      //                     SizedBox(height: 15),
      //                     Container(
      //                       width: 650,
      //                       height: 10,
      //                       color: Colors.white70,
      //                     ),
      //                     SizedBox(height: 5),
      //                     Container(
      //                       width: 650,
      //                       height: 10,
      //                       color: Colors.white70,
      //                     ),
      //                     SizedBox(height: 5),
      //                     Container(
      //                       width: 400,
      //                       height: 10,
      //                       color: Colors.white70,
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //
      //               Positioned(
      //                 right: 15,
      //                 bottom: 35,
      //                 child: Container(
      //                   child: Row(
      //                     children: [
      //                       Container(
      //                         height: 35,
      //                         width: 35,
      //                         decoration: BoxDecoration(
      //                             border: Border(right: BorderSide(width: 1,color:Colors.black12))
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                   height: 35,
      //                   width: 140,
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(0),
      //                     color: Colors.white70,
      //                   ),
      //                 ),
      //               )
      //             ],
      //           ),
      //           Container(
      //             margin: EdgeInsets.only(bottom: 15),
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 Row(
      //                   children: [
      //                     Container(
      //                       margin: EdgeInsets.only(right: 5),
      //                       color: Colors.white70,
      //                       width: 120,
      //                       height: 30,
      //                     ),
      //                     Container(
      //                       color: Colors.white70,
      //                       width: 120,
      //                       height: 30,
      //                     ),
      //                   ],
      //                 ),
      //
      //                 Row(
      //                   children: [
      //
      //                     Container(
      //                       margin: EdgeInsets.only(left: 2),
      //                       color: Colors.white70,
      //                       width: 80,
      //                       height: 30,
      //                     ),
      //                     Container(
      //                       margin: EdgeInsets.only(left: 2),
      //                       color: Colors.white70,
      //                       width: 80,
      //                       height: 30,
      //                     ),
      //                     Container(
      //                       margin: EdgeInsets.only(left: 2),
      //                       color: Colors.white70,
      //                       width: 80,
      //                       height: 30,
      //                     ),
      //                     Container(
      //                       margin: EdgeInsets.only(left: 2),
      //                       color: Colors.white70,
      //                       width: 80,
      //                       height: 30,
      //                     ),
      //                   ],
      //                 ),
      //
      //               ],
      //             ),
      //           ),
      //           Container(
      //             margin: EdgeInsets.only(bottom: 15),
      //             child: Row(
      //               children: [
      //                 Expanded(
      //                   child: Container(
      //                     color: Colors.white70,
      //                     height: 65
      //                   ),
      //                 ),
      //                 Expanded(
      //                   child: Container(
      //                     margin: EdgeInsets.only(left: 15),
      //                     color: Colors.white70,
      //                     height: 65,
      //                   ),
      //                 ),
      //                 Expanded(
      //                   child: Container(
      //                     margin: EdgeInsets.only(left: 15),
      //                     color: Colors.white70,
      //                     height: 65,
      //                   ),
      //                 ),
      //                 Expanded(
      //                   child: Container(
      //                     margin: EdgeInsets.only(left: 15),
      //                     color: Colors.white70,
      //                     height: 65,
      //                   ),
      //                 ),
      //                 Expanded(
      //                   child: Container(
      //                     margin: EdgeInsets.only(left: 15),
      //                     color: Colors.white70,
      //                     height: 65,
      //                   ),
      //                 ),
      //                 Expanded(
      //                   child: Container(
      //                     margin: EdgeInsets.only(left: 15),
      //                     color: Colors.white70,
      //                     height: 65,
      //                   ),
      //                 ),
      //
      //               ],
      //             ),
      //           ),
      //           Container(
      //             margin: EdgeInsets.only(bottom: 15),
      //             child: Row(
      //               children: [
      //                 Expanded(
      //                   child: Container(
      //                     color: Colors.white70,
      //                     height: 65,
      //                   ),
      //                 ),
      //                 Expanded(
      //                   child: Container(
      //                     margin: EdgeInsets.only(left: 15),
      //                     color: Colors.white70,
      //                     height: 65,
      //                   ),
      //                 ),
      //                 Expanded(
      //                   child: Container(
      //                     margin: EdgeInsets.only(left: 15),
      //                     color: Colors.white70,
      //                     height: 65,
      //                   ),
      //                 ),
      //                 Expanded(
      //                   child: Container(
      //                     margin: EdgeInsets.only(left: 15),
      //                     color: Colors.white70,
      //                     height: 65,
      //                   ),
      //                 ),
      //                 Expanded(
      //                   child: Container(
      //                     margin: EdgeInsets.only(left: 15),
      //                     color: Colors.white70,
      //                     height: 65,
      //                   ),
      //                 ),
      //                 Expanded(
      //                   child: Container(
      //                     margin: EdgeInsets.only(left: 15),
      //                     color: Colors.white70,
      //                     height: 65,
      //                   ),
      //                 ),
      //
      //               ],
      //             ),
      //           ),
      //           Container(
      //             margin: EdgeInsets.only(bottom: 15),
      //             child: Row(
      //               children: [
      //                 Expanded(
      //                   child: Container(
      //                     color: Colors.white70,
      //                     height: 65,
      //                   ),
      //                 ),
      //                 Expanded(
      //                   child: Container(
      //                     margin: EdgeInsets.only(left: 15),
      //                     color: Colors.white70,
      //                     height: 65,
      //                   ),
      //                 ),
      //                 Expanded(
      //                   child: Container(
      //                     margin: EdgeInsets.only(left: 15),
      //                     color: Colors.white70,
      //                     height: 65,
      //                   ),
      //                 ),
      //                 Expanded(
      //                   child: Container(
      //                     margin: EdgeInsets.only(left: 15),
      //                     color: Colors.white70,
      //                     height: 65,
      //                   ),
      //                 ),
      //                 Expanded(
      //                   child: Container(
      //                     margin: EdgeInsets.only(left: 15),
      //                     color: Colors.white70,
      //                     height: 65,
      //                   ),
      //                 ),
      //                 Expanded(
      //                   child: Container(
      //                     margin: EdgeInsets.only(left: 15),
      //                     color: Colors.white70,
      //                     height: 65,
      //                   ),
      //                 ),
      //
      //               ],
      //             ),
      //           ),
      //
      //         ],
      //       ),
      //     ),
      //   ),
      // );

  }
}
