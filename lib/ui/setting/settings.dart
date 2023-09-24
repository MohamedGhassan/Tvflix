import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tvflix/key_code.dart';
import 'package:tvflix/responsive.dart';
import 'package:tvflix/ui/pages/contact.dart';
import 'package:tvflix/ui/pages/privacy.dart';
import 'package:tvflix/ui/setting/setting_bg_widget.dart';
import 'package:tvflix/ui/setting/setting_color_widget.dart';
import 'package:tvflix/ui/setting/setting_size_widget.dart';
import 'package:tvflix/ui/setting/setting_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';

import '../auth/auth.dart';
import '../auth/profile.dart';
import '../auth/profile_item_widget.dart';
import '../auth/subscriptions.dart';
import '../channel/channels.dart';
import '../home/home.dart';
import '../home/mylist.dart';
import '../movie/movies.dart';
import '../serie/series.dart';
import 'package:need_resume/need_resume.dart';

class Settings extends StatefulWidget {
  int? posty;
  int? postx;
  int? selectedItem;

  // Image? image;
  bool? logged;
  Image? image = Image.asset("assets/images/profile.jpg");

  Settings(
      {this.posty, this.postx, this.selectedItem, this.image, this.logged});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int _subtitle_size = 33;
  int _subtitle_color = 0;
  int _subtitle_background = 0;

  FocusNode main_focus_node = FocusNode();
  double pos_y = 0;
  double pos_x = 0;
  bool infos = false;
  bool? logged;
  bool? subscribe;
  String name = "";
  String type = "";
  Image image = Image.asset("assets/images/profile.jpg");

  String email = "";

  late SharedPreferences prefs;

  // @override
  // void onResume() {
  //   // TODO: implement onResume
  //   super.onResume();
  //   getLogged();
  // }
  getLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    widget.logged = await prefs.getBool("LOGGED_USER");

    if (widget.logged == true) {
      String? img = await prefs.getString("IMAGE_USER");
      widget.image = Image.network(img!);
    } else {
      widget.logged = false;
      widget.image = Image.asset("assets/images/profile.jpg");
    }
    setState(() {

    });
  }

  getLogged2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    logged = prefs.getBool("LOGGED_USER");

    if (logged == true) {
      String? img = prefs.getString("IMAGE_USER");
      image = Image.network(img!);
      name = prefs.getString("NAME_USER")!;
      email = prefs.getString("USERNAME_USER")!;
      type = prefs.getString("TYPE_USER")!;
      subscribe =
      (prefs.getString("NEW_SUBSCRIBE_ENABLED") == "FALSE") ? false : true;
      setState(() {

      });
    } else {
      logged = false;
      image = Image.asset("assets/images/profile.jpg");
    }
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLogged2();
    initSettings();
    Future.delayed(Duration.zero, () {
      FocusScope.of(context).requestFocus(main_focus_node);
    });
  }

  // String name = "";
  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: main_focus_node,
      onKey: (RawKeyEvent event) {
        if (event is RawKeyDownEvent && event.data is RawKeyEventDataAndroid) {
          RawKeyDownEvent rawKeyDownEvent = event;
          RawKeyEventDataAndroid rawKeyEventDataAndroid =
          rawKeyDownEvent.data as RawKeyEventDataAndroid;
          print("Focus Node 0 ${rawKeyEventDataAndroid.keyCode}");
          switch (rawKeyEventDataAndroid.keyCode) {
            case KEY_CENTER:
              _goToPrivacyPolicy();
              _goToContactUs();
              break;
            case KEY_UP:
              if (pos_y > 0) {
                pos_y--;
              }
              break;
            case KEY_DOWN:
              if (pos_y < 5) {
                pos_y++;
              }
              break;
            case KEY_LEFT:
              if (pos_y == 0) {
                if (_subtitle_size > 5) _subtitle_size--;

                prefs.setInt("subtitle_size", _subtitle_size);
              }
              if (pos_y == 1) {
                if (_subtitle_color > 0)
                  _subtitle_color--;
                else
                  _subtitle_color = 10;

                prefs.setInt("subtitle_color", _subtitle_color);
              }

              if (pos_y == 2) {
                if (_subtitle_background > 0)
                  _subtitle_background--;
                else
                  _subtitle_background = 10;
              }
              break;
            case KEY_RIGHT:
              if (pos_y == 0) {
                if (_subtitle_size < 45) _subtitle_size++;

                prefs.setInt("subtitle_size", _subtitle_size);
              }
              if (pos_y == 1) {
                if (_subtitle_color < 10)
                  _subtitle_color++;
                else
                  _subtitle_color = 0;

                prefs.setInt("subtitle_color", _subtitle_color);
              }
              if (pos_y == 2) {
                if (_subtitle_background < 11)
                  _subtitle_background++;
                else
                  _subtitle_background = 0;

                prefs.setInt("subtitle_background", _subtitle_background);
              }
              break;
            default:
              break;
          }
          setState(() {});
        }
      },
      child: Scaffold(
          backgroundColor: Theme
              .of(context)
              .scaffoldBackgroundColor,
          body: Stack(
            children: [
              FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: AssetImage("assets/images/background.jpeg"),
                  fit: BoxFit.cover),
              ClipRRect(
                // Clip it cleanly.
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    color: Colors.black.withOpacity(0.1),
                    alignment: Alignment.center,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: -5,
                top: -5,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset(0, 0),
                          blurRadius: 5),
                    ],
                  ),
                  width: Responsive.isMobile(context) ? MediaQuery
                      .of(context)
                      .size
                      .width / 1.5 : MediaQuery
                      .of(context)
                      .size
                      .width / 2.5,
                  child: Container(
                    width: double.infinity,
                    color: Colors.black54,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(color: Colors.black54,),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 20,
                                right: 20,
                                top: Responsive.isMobile(context) ? 75 : 30,
                                bottom: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Container(
                                //   width: 100,
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(0.0),
                                //     child:  Image.asset("assets/images/profile.jpg"),
                                //   ),
                                // ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      widget.postx = 7;
                                      widget.posty = -2;
                                      if (widget.logged == true) {
                                        Future.delayed(
                                            Duration(milliseconds: 200), () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Auth()));
                                          // PageRouteBuilder(
                                          //   pageBuilder: (context, animation1, animation2) => Auth(),
                                          //   transitionDuration: Duration(seconds: 0),
                                          // );
                                          // push(
                                          //   context,
                                          //   PageRouteBuilder(
                                          //     pageBuilder: (context, animation1,
                                          //         animation2) => Profile(),
                                          //     transitionDuration: Duration(
                                          //         seconds: 0),
                                          //   ),
                                          // );
                                        });
                                      } else {
                                        Future.delayed(
                                            Duration(milliseconds: 200), () {
                                          // push(
                                          //   context,
                                          //   PageRouteBuilder(
                                          //     pageBuilder: (context, animation1, animation2) => Auth(),
                                          //     transitionDuration: Duration(seconds: 0),
                                          //   ),
                                          // );
                                          // PageRouteBuilder(
                                          //   pageBuilder: (context, animation1, animation2) => Profile(),
                                          //   transitionDuration: Duration(seconds: 0),
                                          // );
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Profile()));
                                        });
                                      }
                                    });
                                  },
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        widget.postx = 7;
                                        widget.posty = -2;
                                        if (widget.logged == true) {
                                          Future.delayed(
                                              Duration(milliseconds: 200), () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Auth()));
                                            // PageRouteBuilder(
                                            //   pageBuilder: (context, animation1, animation2) => Profile(),
                                            //   transitionDuration: Duration(seconds: 0),
                                            // );

                                            // push(
                                            //   context,
                                            //   PageRouteBuilder(
                                            //     pageBuilder: (context, animation1, animation2) => Profile(),
                                            //     transitionDuration: Duration(seconds: 0),
                                            //   ),
                                            // );
                                          });
                                          /// هاد السطر لما بدي اسجل بخليه اوث، هو الي بس بلعب فيه
                                        } else {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Auth()));
                                          // PageRouteBuilder(
                                          //   pageBuilder: (context, animation1, animation2) => Auth(),
                                          //   transitionDuration: Duration(seconds: 0),
                                          // );
                                          // Future.delayed(
                                          //     Duration(milliseconds: 200), () {
                                          //   Navigator.push(
                                          //     context,
                                          //     PageRouteBuilder(
                                          //       pageBuilder: (context, animation1, animation2) => Profile(),
                                          //       transitionDuration: Duration(seconds: 0),
                                          //     ),
                                          //   );
                                          // });
                                        }
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.white.withOpacity(
                                                  0.4),
                                              offset: Offset(0, 0),
                                              blurRadius: 5
                                          ),
                                        ],
                                      ),
                                      height: Responsive.isMobile(context)
                                          ? 50
                                          : 80,
                                      child:
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.white.withOpacity(
                                                    0.4),
                                                offset: Offset(0, 0),
                                                blurRadius: 5
                                            ),
                                          ],),
                                        // height: Responsive.isMobile(context)
                                        //     ? 50
                                        // : 100,
                                        child: Image(
                                          image: AssetImage(
                                              'assets/images/myimage.jpg'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      // ClipRRect(
                                      //     child: image,
                                      //     borderRadius:  BorderRadius.circular(5)
                                      // ),
                                    ),
                                  ),
                                ),

                                // ProfileItemWidget(subtitle: name),
                                // ProfileItemWidget(title: "Name"),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  name,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900
                                  ),
                                ),
                                Spacer(),
                                CircleAvatar(
                                    radius: Responsive.isMobile(context)
                                        ? 15
                                        : 20,
                                    backgroundColor: Colors.white,
                                    child: IconButton(icon: Icon(
                                      Icons.close,
                                      color: Colors.black,
                                      // size: 15,
                                      size: Responsive.isMobile(context) ? 15 : 25,
                                    ), onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    )
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black87,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, left: 10, bottom: 10),
                            child: Row(
                              children: [
                                // Icon(Icons.settings,
                                //     color: Colors.white70, size: 35),
                                SizedBox(width: 10),
                                Text(
                                  "BROWES",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.black.withOpacity(0.6),
                          child: Column(
                            children: [
                              // InkWell(
                              //   onTap: () {
                              //     setState(() {
                              //       widget.postx = 1;
                              //       widget.posty = -2;
                              //       Future.delayed(
                              //           Duration(milliseconds: 200), () {
                              //         if (widget.selectedItem != 1) {
                              //           Navigator.pushReplacement(
                              //             context,
                              //             PageRouteBuilder(
                              //               pageBuilder: (context, animation1,
                              //                   animation2) => Home(),
                              //               transitionDuration: Duration(
                              //                   seconds: 0),
                              //             ),
                              //           );
                              //         }
                              //       });
                              //     });
                              //   },
                              //   child: ListTile(
                              //     leading: Icon(
                              //       Icons.home_outlined, color: Colors.white,
                              //       size: 25,),
                              //     title: Container(
                              //       decoration: BoxDecoration(
                              //         // borderRadius: BorderRadius.circular(20),
                              //         // color:(widget.selectedItem == 1)? (widget.posty == -2 && widget.postx == 1)?Colors.white:Colors.white70:(widget.posty == -2 && widget.postx == 1)?Colors.white24:Colors.transparent,
                              //       ),
                              //       child: Text("Home", style: TextStyle(
                              //           color: (widget.selectedItem == 1)
                              //               ? Colors.black
                              //               : (widget.posty == -2 &&
                              //               widget.postx == 1)
                              //               ? Colors.white
                              //               : Colors.white60,
                              //           fontSize: 14,
                              //           fontWeight: FontWeight.w500
                              //       ),),
                              //     ),
                              //   ),
                              // ),
                              // InkWell(
                              //   onTap: () {
                              //     setState(() {
                              //       widget.postx = 2;
                              //       widget.posty = -2;
                              //       Future.delayed(
                              //           Duration(milliseconds: 200), () {
                              //         if (widget.selectedItem != 2) {
                              //           Navigator.pushReplacement(
                              //             context,
                              //             PageRouteBuilder(
                              //               pageBuilder: (context, animation1,
                              //                   animation2) => Movies(),
                              //               transitionDuration: Duration(
                              //                   seconds: 0),
                              //             ),
                              //           );
                              //         }
                              //       });
                              //     });
                              //   },
                              //   child: ListTile(
                              //     leading: Icon(
                              //       Icons.movie_creation_outlined,
                              //       color: Colors.white,
                              //       size: 25,),
                              //     title: Text("Movies", style: TextStyle(
                              //         color: (widget.selectedItem == 2)
                              //             ? Colors.black
                              //             : (widget.posty == -2 &&
                              //             widget.postx == 2)
                              //             ? Colors.white
                              //             : Colors.white60,
                              //         fontSize: 15,
                              //         fontWeight: FontWeight.w500
                              //     ),),
                              //   ),
                              // ),
                              // InkWell(
                              //   onTap: () {
                              //     setState(() {
                              //       widget.postx = 3;
                              //       widget.posty = -2;
                              //       Future.delayed(
                              //           Duration(milliseconds: 200), () {
                              //         if (widget.selectedItem != 3) {
                              //           Navigator.pushReplacement(
                              //             context,
                              //             PageRouteBuilder(
                              //               pageBuilder: (context, animation1,
                              //                   animation2) => Series(),
                              //               transitionDuration: Duration(
                              //                   seconds: 0),
                              //             ),
                              //           );
                              //         }
                              //       });
                              //     });
                              //   },
                              //   child: ListTile(
                              //     leading: Icon(
                              //       Icons.slideshow, color: Colors.white,
                              //       size: 25,),
                              //     title: Text("Shows", style: TextStyle(
                              //         color: (widget.selectedItem == 3)
                              //             ? Colors.black
                              //             : (widget.posty == -2 &&
                              //             widget.postx == 3)
                              //             ? Colors.white
                              //             : Colors.white60,
                              //         fontSize: 15,
                              //         fontWeight: FontWeight.w500
                              //     ),),
                              //   ),
                              // ),
                              // InkWell(
                              //   onTap: () {
                              //     setState(() {
                              //       widget.postx = 4;
                              //       widget.posty = -2;
                              //       Future.delayed(
                              //           Duration(milliseconds: 200), () {
                              //         if (widget.selectedItem != 4) {
                              //           Navigator.pushReplacement(
                              //             context,
                              //             PageRouteBuilder(
                              //               pageBuilder: (context, animation1,
                              //                   animation2) => Channels(),
                              //               transitionDuration: Duration(
                              //                   seconds: 0),
                              //             ),
                              //           );
                              //         }
                              //       });
                              //     });
                              //   },
                              //   child: ListTile(
                              //     leading: Icon(
                              //       Icons.live_tv, color: Colors.white,
                              //       size: 25,),
                              //     title: Text("Live TV", style: TextStyle(
                              //         color: (widget.selectedItem == 4)
                              //             ? Colors.black
                              //             : (widget.posty == -2 &&
                              //             widget.postx == 4)
                              //             ? Colors.white
                              //             : Colors.white60,
                              //         fontSize: 15,
                              //         fontWeight: FontWeight.w500
                              //     ),),
                              //   ),
                              // ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    widget.postx = 7;
                                    widget.posty = -2;
                                    if (widget.logged == true) {
                                      Future.delayed(
                                          Duration(milliseconds: 200), () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Auth()));
                                        // push(
                                        //   context,
                                        //   PageRouteBuilder(
                                        //     pageBuilder: (context, animation1,
                                        //         animation2) => Profile(),
                                        //     transitionDuration: Duration(
                                        //         seconds: 0),
                                        //   ),
                                        // );
                                      });
                                    } else {
                                      Future.delayed(
                                          Duration(milliseconds: 200), () {
                                        // push(
                                        //   context,
                                        //   PageRouteBuilder(
                                        //     pageBuilder: (context, animation1, animation2) => Auth(),
                                        //     transitionDuration: Duration(seconds: 0),
                                        //   ),
                                        // );
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Profile()));
                                      });
                                    }
                                  });
                                },
                                child: ListTile(
                                  leading: Icon(
                                    Icons.person_outline_outlined,
                                    color: Colors.white,
                                    size: 25,),
                                  title: Text("My Profile", style: TextStyle(
                                      color: (widget.selectedItem == 5) ? Colors
                                          .black : (widget.posty == -2 &&
                                          widget.postx == 5)
                                          ? Colors.white
                                          : Colors.white60,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500
                                  ),),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    widget.postx = 5;
                                    widget.posty = -2;
                                    if (widget.logged != true) {
                                      Future.delayed(
                                          Duration(milliseconds: 200), () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MyList()));
                                        // push(
                                        //   context,
                                        //   PageRouteBuilder(
                                        //     pageBuilder: (context, animation1, animation2) => Auth(),
                                        //     transitionDuration: Duration(seconds: 0),
                                        //   ),
                                        // );
                                      });
                                    } else {
                                      Future.delayed(
                                          Duration(milliseconds: 200), () {
                                        Navigator.pushReplacement(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation1,
                                                animation2) => Auth(),
                                            transitionDuration: Duration(
                                                seconds: 0),
                                          ),
                                        );
                                      });
                                    }
                                  });
                                },
                                child: ListTile(
                                  leading: Icon(
                                    Icons.favorite_border, color: Colors.white,
                                    size: 25,),
                                  title: Text("My List", style: TextStyle(
                                      color: (widget.selectedItem == 5) ? Colors
                                          .black : (widget.posty == -2 &&
                                          widget.postx == 5)
                                          ? Colors.white
                                          : Colors.white60,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500
                                  ),),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    widget.postx = 5;
                                    widget.posty = -2;
                                    if (widget.logged != true) {
                                      Future.delayed(
                                          Duration(milliseconds: 200), () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Subscriptions()));
                                        // push(
                                        //   context,
                                        //   PageRouteBuilder(
                                        //     pageBuilder: (context, animation1, animation2) => Auth(),
                                        //     transitionDuration: Duration(seconds: 0),
                                        //   ),
                                        // );
                                      });
                                    } else {
                                      Future.delayed(
                                          Duration(milliseconds: 200), () {
                                        Navigator.pushReplacement(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation1,
                                                animation2) => Subscriptions(),
                                            transitionDuration: Duration(
                                                seconds: 0),
                                          ),
                                        );
                                      });
                                    }
                                  });
                                },
                                child: ListTile(
                                  leading: Icon(
                                    Icons.star_border, color: Colors.white,
                                    size: 25,),
                                  title: Text("Subscriptions", style: TextStyle(
                                      color: (widget.selectedItem == 5) ? Colors
                                          .black : (widget.posty == -2 &&
                                          widget.postx == 5)
                                          ? Colors.white
                                          : Colors.white60,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500
                                  ),),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black87,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: Responsive.isMobile(context) ? 10 : 20,
                                left: 10,
                                bottom: 10),
                            child: Row(
                              children: [
                                // Icon(Icons.settings,
                                //     color: Colors.white70, size: 35),
                                SizedBox(width: 10),
                                Text(
                                  "Settings",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              color: Colors.black.withOpacity(0.6),
                              child: Column(
                                children: [
                                  //SettingSubtitleWidget(icon: Icons.subtitles,title: "Subtitles",isFocused: (pos_y == 0),subtitle: "Movies and series subtitles",enabled: _subtitle_enabled),
                                  SettingSizeWidget(
                                      icon: Icons.text_fields,
                                      title: "Subtitle size",
                                      isFocused: (pos_y == 0),
                                      subtitle: "Subtitle text size",
                                      size: _subtitle_size),
                                  SettingColorWidget(
                                      icon: Icons.text_format,
                                      title: "Subtitle color",
                                      isFocused: (pos_y == 1),
                                      subtitle: "Subtitle text color",
                                      color: _subtitle_color),
                                  SettingBackgroundWidget(
                                      icon: Icons.format_color_fill,
                                      title: "Subtitle Background color",
                                      isFocused: (pos_y == 2),
                                      subtitle: "Subtitle text background color",
                                      color: _subtitle_background),
                                  SettingWidget(
                                      icon: Icons.lock,
                                      title: "Privacy Policy",
                                      isFocused: (pos_y == 3),
                                      subtitle:
                                      "Privacy policy / terms and conditions ",
                                      action: () {
                                        setState(() {
                                          pos_y = 3;
                                        });
                                        _goToPrivacyPolicy();
                                      }),
                                  SettingWidget(
                                      icon: Icons.email,
                                      title: "Contact us",
                                      isFocused: (pos_y == 4),
                                      subtitle: "support and report bugs",
                                      action: () {
                                        setState(() {
                                          pos_y = 4;
                                        });
                                        _goToContactUs();
                                      }),
                                  SettingWidget(
                                      icon: Icons.info,
                                      title: "Versions",
                                      isFocused: (pos_y == 5),
                                      subtitle: "2.3",
                                      action: () {}),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  /* void _toggleSubtitles() {
    if(pos_y == 0 ){
      setState(() {
        _subtitle_enabled = !_subtitle_enabled;

      });
    }
  }*/

  void _goToPrivacyPolicy() {
    if (pos_y == 3) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => Privacy(),
          transitionDuration: Duration(seconds: 0),
        ),
      );
    }
  }

  void _goToContactUs() {
    if (pos_y == 4) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => Contact(),
          transitionDuration: Duration(seconds: 0),
        ),
      );
    }
  }

  void initSettings() async {
    prefs = await SharedPreferences.getInstance();
    //_subtitle_enabled  =  prefs.getBool("subtitle_enabled");
    _subtitle_size = prefs.getInt("subtitle_size")!;
    _subtitle_color = prefs.getInt("subtitle_color")!;
    _subtitle_background = prefs.getInt("subtitle_background")!;
    setState(() {});
  }
}
