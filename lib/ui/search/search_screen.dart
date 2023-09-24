import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tvflix/model/channel.dart';
import 'package:tvflix/model/country.dart';
import 'package:tvflix/model/poster.dart';
import 'package:tvflix/ui/channel/channel_detail.dart';
import 'package:tvflix/ui/movie/movie.dart';
import 'package:tvflix/ui/serie/serie.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../responsive.dart';

class MovieShortDetailSearchWidget extends StatefulWidget {
  Poster? poster;
  Channel? channel;

  MovieShortDetailSearchWidget({this.poster, this.channel});

  @override
  _MovieShortDetailSearchWidgetState createState() => _MovieShortDetailSearchWidgetState();
}


class _MovieShortDetailSearchWidgetState extends State<MovieShortDetailSearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(
          left: Responsive.isMobile(context) ? 20 : 50,
          right: Responsive.isMobile(context) ? 20 : 50),
      child: Stack(
        children: [
          if (widget.poster != null)
            Container(
              margin:
              EdgeInsets.only(right: MediaQuery.of(context).size.width / 4),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.poster!.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 45,
                        fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: 25),
                  Row(
                    children: [
                      Text(
                        "${widget.poster!.rating}/5",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w800),
                      ),
                      RatingBar.builder(
                        initialRating: widget.poster!.rating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 15.0,
                        ignoreGestures: true,
                        unratedColor: Colors.amber.withOpacity(0.4),
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      SizedBox(width: 10),
                      Text(
                        "  • ${widget.poster!.imdb} / 10 ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w800),
                      ),
                      Container(
                        padding:
                        EdgeInsets.symmetric(vertical: 2, horizontal: 5),
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
                    "${widget.poster!.year} • ${widget.poster?.classification} • ${widget.poster!.duration} • ${widget.poster!.getGenresList()}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: 15),
                  Text(
                    widget.poster!.description,
                    style: TextStyle(
                        color: Colors.white60,
                        fontSize: 11,
                        height: 1.5,
                        fontWeight: FontWeight.normal),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          if (widget.channel != null)
            Container(
              padding: EdgeInsets.only(bottom: 50.sp),
              margin:
              EdgeInsets.only(right: MediaQuery.of(context).size.width / 6),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.channel!.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 45,
                        fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "${widget.channel!.rating}/5",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w800),
                      ),
                      RatingBar.builder(
                        initialRating: widget.channel!.rating!,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 15.0,
                        ignoreGestures: true,
                        unratedColor: Colors.amber.withOpacity(0.4),
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      for (Country g in widget.channel!.countries)
                        Container(
                          child: Row(
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
                        ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        " ${widget.channel!.classification}  ${widget.channel!.getCategoriesList()}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.channel!.description,
                    style: TextStyle(
                        color: Colors.white60,
                        fontSize: 11,
                        height: 1.5,
                        fontWeight: FontWeight.normal),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

          Container(
            padding: EdgeInsets.only(top: 270),
            child: Positioned(
              right: null,
              bottom: 0,
              child: GestureDetector(
                onTap: () {
                  if (widget.channel != null) {
                    Future.delayed(Duration(milliseconds: 50), () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              ChannelDetail(channel: widget.channel),
                          transitionDuration: Duration(seconds: 0),
                        ),
                      );
                    });
                  }
                  if (widget.poster != null) {
                    Future.delayed(Duration(milliseconds: 50), () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                          (widget.poster!.type == "serie")
                              ? Serie(serie: widget.poster)
                              : Movie(movie: widget.poster),
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
                        height: 35.h,
                        width: 35.h,
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
            ),
          )
        ],
      ),
    );
  }
}
