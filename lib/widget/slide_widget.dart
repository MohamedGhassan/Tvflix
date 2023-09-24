import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tvflix/model/channel.dart';
import 'package:tvflix/model/poster.dart';
import 'package:tvflix/model/slide.dart';
import 'package:tvflix/ui/movie/movie.dart';
import 'package:tvflix/ui/movie/movie_short_detail.dart';
import 'package:tvflix/widget/slide_item_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../responsive.dart';

class SlideWidget extends StatefulWidget {

  CarouselController? carouselController;
  int? posty;
  int? postx;
  int? side_current;
  List<Slide>? slides;
  Function? move;
  Poster? poster;
  Channel? channel;

  SlideWidget({this.carouselController, this.posty, this.postx, this.side_current, this.slides, this.move,this.channel,this.poster});

  @override
  _SlideWidgetState createState() => _SlideWidgetState();
}

class _SlideWidgetState extends State<SlideWidget> {

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      // top: (widget.posty! < 0)? 130 : 40,
      top: Responsive.isMobile(context) ? (widget.posty! < 0)? 120.h : 70.h : 150.h,
      left: 0,
      right: 0,
      height: (widget.posty! < 0)?(MediaQuery.of(context).size.height/2)-1:(MediaQuery.of(context).size.height/2) - 45,
      duration: Duration(milliseconds: 200),
      child: Container(
        height: (widget.posty! <0)?(MediaQuery.of(context).size.height/2)-1:(MediaQuery.of(context).size.height/2) - 45,
        child: Stack(
          children: [
            if(widget.slides!.length>0)
            Positioned(
              bottom: Responsive.isMobile(context) ? 150.h : 25.h,
              right: 50,
              child:
              AnimatedOpacity(
                opacity: (widget.posty! < 0)? 1 : 0,
                duration: Duration(milliseconds: 200),
                child:AnimatedSmoothIndicator(
                  activeIndex: widget.side_current!,
                  count:  widget.slides!.length,
                  effect:  ExpandingDotsEffect(
                      dotHeight: 7,
                      dotWidth: 7,
                      dotColor: Colors.white24,
                      activeDotColor: Colors.purple
                  ),
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: (widget.posty! < 0)? 1 : 0,
              duration: Duration(milliseconds: 200),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: CarouselSlider.builder(
                  itemCount: widget.slides!.length,
                  carouselController:widget.carouselController ,
                  options: CarouselOptions(
                      autoPlay: true,
                      viewportFraction:1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          widget.side_current = index;
                        });
                        widget.move!(index);
                      }
                  ),
                  itemBuilder: (ctx, index, realIdx) {
                    return SlideItemWidget(index:index,slide: widget.slides![index]);
                  },
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: (widget.posty! < 0)? 0 : 1,
              duration: Duration(milliseconds: 200),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: MovieShortDetailWidget(poster:widget.poster,channel:widget.channel),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
