import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tvflix/model/country.dart';
import 'package:tvflix/model/slide.dart';
import 'package:tvflix/responsive.dart';
import 'package:tvflix/ui/channel/channel_detail.dart';
import 'package:tvflix/ui/movie/movie.dart';
import 'package:tvflix/ui/serie/serie.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SlideItemWidget extends StatelessWidget {
  int index;

  Slide slide;

  SlideItemWidget({required this.index, required this.slide});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(
        left: Responsive.isMobile(context) ? 20 : 20,
        right: Responsive.isMobile(context) ? 20 : 20,
        // top: Responsive.isMobile(context) ? 10 : 50,
        // top: Responsive.isMobile(context) ? 70 : 0,
      ),
      child: Stack(
        children: [
          Container(
            margin:
            EdgeInsets.only(
              right: MediaQuery.of(context).size.width / 4,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Responsive.isMobile(context) ? 10 : 20),
                Text(
                  slide.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Responsive.isMobile(context) ? 20 : 45,
                      // fontSize: Responsive.isMobile(context) ? 25 : 45,
                      fontWeight: FontWeight.w900),
                ),
                SizedBox(height: Responsive.isMobile(context) ? 15 : 25),
                if (slide.channel != null || slide.poster != null)
                  Row(
                    children: [
                      Text(
                        ((slide.poster != null)
                            ? slide.poster!.rating
                            : (slide.channel != null)
                            ? slide.channel!.rating
                            : "")
                            .toString() +
                            " / 5",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Responsive.isMobile(context) ? 10 : 13.sp,
                            fontWeight: FontWeight.w800),
                      ),
                      RatingBar.builder(
                        initialRating: ((slide.poster != null)
                            ? slide.poster!.rating
                            : (slide.channel != null)
                            ? slide.channel!.rating!
                            : 0),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: Responsive.isMobile(context) ? 10 : 15.sp,
                        ignoreGestures: true,
                        unratedColor: Colors.amber.withOpacity(0.4),
                        itemPadding: EdgeInsets.symmetric(
                            horizontal: Responsive.isMobile(context) ? 3 : 4),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      SizedBox(width: Responsive.isMobile(context) ? 5 : 10.h),
                      if (slide.poster != null)
                        Text(
                          "•  ${slide.poster!.imdb} / 10 ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w800),
                        ),
                      if (slide.poster != null)
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: Responsive.isMobile(context) ? 3 : 5),
                          decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            "IMDb",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w800),
                          ),
                        )
                    ],
                  ),
                SizedBox(height: 10),
                if (slide.channel != null)
                  Row(
                    children: [
                      Text(
                        " ${slide.channel!.classification}  ${slide.channel!.getCategoriesList()}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w900),
                      ),
                      for (Country g in slide.channel!.countries)
                        Row(
                          children: [
                            Text(
                              " • ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800),
                            ),
                            CachedNetworkImage(imageUrl: g.image, width: 25),
                          ],
                        ),
                    ],
                  ),
                if (slide.poster != null)
                  Text(
                    "${slide.poster!.year} • ${slide.poster!.classification} • ${slide.poster!.duration} • ${slide.poster!.getGenresList()}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w900),
                  ),
                if (slide.channel != null || slide.poster != null)
                  SizedBox(height: Responsive.isMobile(context) ? 15 : 25),
                if (slide.channel != null || slide.poster != null)
                  Text(
                    ((slide.poster != null)
                        ? slide.poster!.description
                        : (slide.channel != null)
                        ? slide.channel!.description
                        : "")
                        .toString(),
                    style: TextStyle(
                        color: Colors.white60,
                        fontSize: Responsive.isMobile(context) ? 11 : 16,
                        height: 1.2,
                        fontWeight: FontWeight.normal),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          Positioned(
            right: null,
            bottom: Responsive.isMobile(context) ? 0 : 70,
            // bottom: 70,
            child: GestureDetector(
              onTap: () {
                if (slide.channel != null) {
                  Future.delayed(Duration(milliseconds: 50), () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            ChannelDetail(channel: slide.channel),
                        transitionDuration: Duration(seconds: 0),
                      ),
                    );
                  });
                }
                if (slide.poster != null) {
                  Future.delayed(Duration(milliseconds: 50), () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                        (slide.poster!.type == "serie")
                            ? Serie(serie: slide.poster)
                            : Movie(movie: slide.poster),
                        transitionDuration: Duration(seconds: 0),
                      ),
                    );
                  });
                }
              },
              child: GestureDetector(
                onTap: () {
                  if (slide.channel != null) {
                    Future.delayed(Duration(milliseconds: 50), () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              ChannelDetail(channel: slide.channel),
                          transitionDuration: Duration(seconds: 0),
                        ),
                      );
                    });
                  }
                  if (slide.poster != null) {
                    Future.delayed(Duration(milliseconds: 50), () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                          (slide.poster!.type == "serie")
                              ? Serie(serie: slide.poster)
                              : Movie(movie: slide.poster),
                          transitionDuration: Duration(seconds: 0),
                        ),
                      );
                    });
                  }
                },
                child: Container(
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        child: Center(
                            child: Icon(Icons.play_arrow,
                                size: 30, color: Colors.white)),
                        decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    width: 1, color: Colors.black12))),
                      ),
                      Expanded(
                          child: Center(
                              child: Text(
                                "Watch Now",
                                style: TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.w500),
                              )))
                    ],
                  ),
                  height: 40,
                  width: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white30,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
