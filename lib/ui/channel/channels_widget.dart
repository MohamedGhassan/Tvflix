import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tvflix/model/channel.dart';
import 'package:tvflix/responsive.dart';
import 'package:tvflix/ui/channel/channel_detail.dart';
import 'package:tvflix/ui/channel/channel_widget.dart';
import 'package:tvflix/ui/home/home.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ChannelsWidget extends StatefulWidget {
  List<Channel> channels = [];

  String title;
  double size;

  int posty;
  int postx;
  int jndex;
  ItemScrollController scrollController;

  ChannelsWidget(
      {required this.posty,
      required this.postx,
      required this.jndex,
      required this.scrollController,
      required this.size,
      required this.title,
      required this.channels});

  @override
  _ChannelsWidgetState createState() => _ChannelsWidgetState();
}

class _ChannelsWidgetState extends State<ChannelsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.isMobile(context) ? 80 : 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
                left: Responsive.isMobile(context) ? 20 : 20),
            height: 20,
            child: Text(
              widget.title,
              style: TextStyle(
                  color: (widget.jndex == widget.posty)
                      ? Colors.white
                      : Colors.white60,
                  fontSize: widget.size,
                  fontWeight: FontWeight.w900),
            ),
          ),
          SizedBox(height: 5),
          Container(
            height: Responsive.isMobile(context) ? 55 : 75,
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              // From this behaviour you can change the behaviour
              child: ScrollablePositionedList.builder(
                itemCount: widget.channels.length,
                itemScrollController: widget.scrollController,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(left: (0 == index) ? 10 : 0),
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.posty = widget.jndex;
                            widget.postx = index;
                            Future.delayed(Duration(milliseconds: 250), () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          ChannelDetail(
                                              channel: widget.channels[index]),
                                  transitionDuration: Duration(seconds: 0),
                                ),
                              );
                            });
                          });
                        },
                        child: ChannelWidget(
                            isFocus: ((widget.posty == widget.jndex &&
                                widget.postx == index)),
                            channel: widget.channels[index])),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
