
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tvflix/model/channel.dart';

import '../../responsive.dart';

class ChannelWidget extends StatelessWidget {
  bool isFocus ;
  Channel channel ;
  ChannelWidget({required this.isFocus,required this.channel});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Responsive.isMobile(context) ? 0 : 10,vertical: 10),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        child: ClipRRect(
            child: CachedNetworkImage(
              imageUrl: channel.image,
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(5)
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Colors.blueGrey,
          border: (isFocus)?Border.all(color: Colors.purple,width: 2):Border.all(color: Colors.transparent,width: 0),
          boxShadow: [
            BoxShadow(
                color: (isFocus)?Colors.purple:Colors.white.withOpacity(0),
                offset: Offset(0,0),
                blurRadius: 6
            ),
          ],
        ),
        width: Responsive.isMobile(context) ? 115 :136,
        // width: Responsive.isMobile(context) ? 90 :136,
      ),
    );
  }
}