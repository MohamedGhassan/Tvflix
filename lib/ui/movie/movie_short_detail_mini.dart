import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tvflix/model/genre.dart';
import 'package:tvflix/model/poster.dart';
import 'package:tvflix/ui/movie/movie.dart';
import 'package:tvflix/ui/serie/serie.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../responsive.dart';

class MovieShortDetailMiniWidget extends StatelessWidget {
  Poster? movie;
  String genres = "";

  MovieShortDetailMiniWidget({this.movie}) {
    for (Genre g in movie!.genres) {
      genres = genres + " • " + g.title;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: Responsive.isMobile(context) ? 20 : 50, right: Responsive.isMobile(context) ? 20 : 50,),
      child: Stack(
        children: [
          Container(
            height: 270.h,
            margin:
            EdgeInsets.only(right: MediaQuery.of(context).size.width / 5),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie!.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      // fontSize: 25,
                      fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Text(
                      movie!.rating.toString() + " / 5",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Responsive.isMobile(context) ? 10 : 13.sp,
                          fontWeight: FontWeight.w800),
                    ),
                    RatingBar.builder(
                      initialRating: 3.5,
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
                    Text(
                      "  •   " + movie!.imdb.toString() + " / 10",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w800),
                    ),
                    SizedBox(width: 5),
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
                Text(
                  "${movie!.year} • ${movie!.classification} • ${movie!.duration} ${genres}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 10),
                Text(
                  movie!.description,
                  style: TextStyle(
                      color: Colors.white60,
                      fontSize: 11,
                      height: Responsive.isMobile(context) ? 1.2 : 1.5,
                      fontWeight: FontWeight.normal),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                // SizedBox(height: 20,),
              ],
            ),
          ),
          // SizedBox(height: 20,),
          Positioned(
            right: null,
            bottom: 30.h,
            // bottom: 0,
            child: GestureDetector(
              onTap: () {
                if (movie != null) {
                  Future.delayed(Duration(milliseconds: 50), () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                        (movie!.type == "serie")
                            ? Serie(serie: movie)
                            : Movie(movie: movie),
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
                      height: 35,
                      width: 35,
                      child: Center(
                          child: Icon(Icons.info_outline,
                              size: 20, color: Colors.white)),
                      decoration: BoxDecoration(
                          border: Border(
                              right:
                              BorderSide(width: 1, color: Colors.black12))),
                    ),
                    Expanded(
                        child: Center(
                            child: Text(
                              "More details",
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.w500),
                            )))
                  ],
                ),
                height: 35,
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white30,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
