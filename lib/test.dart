import 'dart:convert' as convert;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:need_resume/need_resume.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvflix/api/api_rest.dart';
import 'package:tvflix/model/channel.dart' as model;
import 'package:tvflix/model/genre.dart';
import 'package:tvflix/model/poster.dart';
import 'package:tvflix/model/slide.dart';
import 'package:tvflix/responsive.dart';
import 'package:tvflix/ui/auth/auth.dart';
import 'package:tvflix/ui/auth/profile.dart';
import 'package:tvflix/ui/channel/channel_detail.dart';
import 'package:tvflix/ui/channel/channels.dart';
import 'package:tvflix/ui/home/home.dart';
import 'package:tvflix/ui/home/mylist.dart';
import 'package:tvflix/ui/movie/movie.dart';
import 'package:tvflix/ui/movie/movies.dart' as mmm;
import 'package:tvflix/ui/movie/movies.dart';
import 'package:tvflix/ui/search/search.dart';
import 'package:tvflix/ui/serie/serie.dart';
import 'package:tvflix/ui/serie/series.dart';
import 'package:tvflix/ui/setting/settings.dart';

/// A [StatelessWidget] which demonstrates
/// how to consume and interact with a [CounterBloc].
class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends ResumableState<Test> {
  List<Genre> genres = [];
  List<Slide> slides = [];
  List<model.Channel> channels = [];

  int postx = 1;
  int posty = -2;
  int side_current = 0;
  CarouselController _carouselController = CarouselController();
  ItemScrollController _scrollController = ItemScrollController();
  List<ItemScrollController> _scrollControllers = [];
  List<int> _position_x_line_saver = [];
  List<int> _counts_x_line_saver = [];
  FocusNode home_focus_node = FocusNode();
  Poster? selected_poster;
  model.Channel? selected_channel;

  List<Poster> postersList = [];

  bool _visibile_loading = false;
  bool _visibile_error = false;
  bool _visibile_success = false;
  bool? logged;
  Image image = Image.asset("assets/images/profile.jpg");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      FocusScope.of(context).requestFocus(home_focus_node);
      _getList();
      getLogged();
    });
  }

  @override
  void onResume() {
    // TODO: implement onResume
    super.onResume();
    getLogged();
  }

  getLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    logged = await prefs.getBool("LOGGED_USER");

    if (logged == true) {
      image = Image.network(await prefs.getString("IMAGE_USER")!);
    } else {
      logged = false;
      image = Image.asset("assets/images/profile.jpg");
    }
    setState(() {
      print(logged);
    });
  }

  void _getList() async {
    _counts_x_line_saver.clear();
    _position_x_line_saver.clear();
    _scrollControllers.clear();
    _showLoading();
    var response = await apiRest.getHomeData();
    if (response == null) {
      _showTryAgain();
    } else {
      if (response.statusCode == 200) {
        var jsonData = convert.jsonDecode(response.body);
        if (jsonData["slides"] != null) {
          for (Map<String, dynamic> slide_map in jsonData["slides"]) {
            Slide slide = Slide.fromJson(slide_map);
            slides.add(slide);
          }
        }
        if (jsonData["channels"] != null) {
          for (Map<String, dynamic> channel_map in jsonData["channels"]) {
            model.Channel channel = model.Channel.fromJson(channel_map);
            channels.add(channel);
          }
          if (channels.length > 0) {
            ItemScrollController controller = new ItemScrollController();
            _scrollControllers.add(controller);
            _position_x_line_saver.add(0);
            _counts_x_line_saver.add(channels.length);

            genres.add(new Genre(id: -3, title: "title", posters: []));
          }
        }
        if (jsonData["genres"] != null) {
          for (Map<String, dynamic> genre_map in jsonData["genres"]) {
            Genre genre = Genre.fromJson(genre_map);
            if (genre.posters!.length > 0) {
              genres.add(genre);
              ItemScrollController controller = new ItemScrollController();
              _scrollControllers.add(controller);
              _position_x_line_saver.add(0);
              _counts_x_line_saver.add(genre.posters!.length);
            }
          }
        }

        _showData();
      } else {
        _showTryAgain();
      }
    }
    setState(() {});
  }

  int currentIndex = 3;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.movie_creation_outlined,
      ),
      label: 'Movies',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.slideshow_sharp,
      ),
      label: 'Shows',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.slideshow_sharp,
      ),
      label: 'Shows',
    ),
    // BottomNavigationBarItem(
    //   icon: Icon(
    //     Icons.live_tv,
    //   ),
    //   label: 'Live TV',
    // ),
  ];
  List<Widget> screen = [
    Channels(),
    Series(),
    Movies(),
    Home(),
  ];
  void changeBottomNavBar(int index) {
    currentIndex = index;
    // emit(NewsBottomNavState());
    if (index == 0) Channels();
    if (index == 1) Series();
    if (index == 2) Movies();
    if (index == 3) Home();

    // if (index == 3) Channels();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      bottomNavigationBar:
      Stack(
        children:[
          Container(
            padding: EdgeInsets.only(left: 5.w,right: 5.w),
            // color: Colors.black,
            child: GNav(
              selectedIndex: 3,
              backgroundColor: Colors.black,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.grey.shade800,
              gap: 8,
              onTabChange: (index)
              {
                setState(()
                {
                  changeBottomNavBar(index);
                });
              },
              padding: EdgeInsets.only(bottom: 10,right: 15,left: 15,top: 10),
              tabs: const[
                GButton(icon: Icons.live_tv, text: "Live TV",),
                GButton(icon: Icons.slideshow_sharp, text: "Shows",),
                GButton(icon: Icons.movie_creation_outlined, text: "Movies"),
                GButton(icon: Icons.home, text: "Home",),
              ],
            ),
          ),
        ],
      ),
      // Padding(
      //   padding: const EdgeInsets.only(bottom: 60),
      //   child: BottomNavigationBar(
      //     type: BottomNavigationBarType.fixed,
      //     currentIndex: currentIndex,
      //     onTap: (index)
      //     {setState((){
      //       currentIndex = index;
      //     });
      //     },
      //     items: bottomItems,
      //   ),
      // ),

      body: screen[currentIndex]
    );
  }
  void _goToMovies() {
    if (posty == -2 && postx == 2) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => mmm.Movies(),
          transitionDuration: Duration(seconds: 0),
        ),
      );
    }
  }

  void _goToSearch() {
    if (posty == -2 && postx == 0) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => Search(),
          transitionDuration: Duration(seconds: 0),
        ),
      );
      FocusScope.of(context).requestFocus(null);
    }
  }
  void _goToMyList() {
    if (posty == -2 && postx == 5) {
      if (logged == true) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => MyList(),
            transitionDuration: Duration(seconds: 0),
          ),
        );
        FocusScope.of(context).requestFocus(null);
      } else {
        push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => Auth(),
            transitionDuration: Duration(seconds: 0),
          ),
        );
      }
    }
  }

  void _goToProfile() {
    if (posty == -2 && postx == 7) {
      if (logged == true) {
        push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => Profile(),
            transitionDuration: Duration(seconds: 0),
          ),
        );
      } else {
        push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => Auth(),
            transitionDuration: Duration(seconds: 0),
          ),
        );
      }
    }
  }

  void _goToSeries() {
    if (posty == -2 && postx == 3) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => Series(),
          transitionDuration: Duration(seconds: 0),
        ),
      );
    }
  }

  void _goToChannels() {
    if (posty == -2 && postx == 4) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => Channels(),
          transitionDuration: Duration(seconds: 0),
        ),
      );
    }
  }

  void _goToSettings() {
    if (posty == -2 && postx == 6) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => Settings(),
          transitionDuration: Duration(seconds: 0),
        ),
      );
      FocusScope.of(context).requestFocus(null);
    }
  }

  void _goToMovieDetail() {
    if (posty >= 0) {
      if (genres[posty] != null) {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
            (genres[posty].posters![postx].type == "serie")
                ? Serie(serie: genres[posty].posters![postx])
                : Movie(movie: genres[posty].posters![postx]),
            transitionDuration: Duration(seconds: 0),
          ),
        );
        FocusScope.of(context).requestFocus(null);
      }
    }
  }

  void _goToChannelDetail() {
    if (posty == 0 && channels.length > 0) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              ChannelDetail(channel: channels[postx]),
          transitionDuration: Duration(seconds: 0),
        ),
      );
      FocusScope.of(context).requestFocus(null);
    }
  }

  Future _scrollToIndexXY(int x, int y) async {
    _scrollControllers[y].scrollTo(
        index: x,
        duration: Duration(milliseconds: 500),
        alignment: 0.04,
        curve: Curves.fastOutSlowIn);
    _scrollController.scrollTo(
        index: y,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOutQuart);
  }

  void _showLoading() {
    setState(() {
      _visibile_loading = true;
      _visibile_error = false;
      _visibile_success = false;
    });
  }

  void _showTryAgain() {
    setState(() {
      _visibile_loading = false;
      _visibile_error = true;
      _visibile_success = false;
    });
  }

  void _showData() {
    setState(() {
      _visibile_loading = false;
      _visibile_error = false;
      _visibile_success = true;
    });
  }

  void _tryAgain() {
    if (_visibile_error && posty == -1) {
      _getList();
    }
  }

  void _openSlide() {
    if (!_visibile_error && posty == -1) {
      Slide slide = slides[side_current];
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
              (slide.poster?.type == "serie")
                  ? Serie(serie: slide.poster)
                  : Movie(movie: slide.poster),
              transitionDuration: Duration(seconds: 0),
            ),
          );
        });
      }
    }
  }

  Widget _tryAgainWidget() {
    return Positioned(
      bottom: 0,
      left: 45,
      right: 45,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error,
                  color: Colors.white,
                ),
                SizedBox(width: 5),
                Text(
                  "Something wrong !",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              "Please check your internet connexion and try again  !",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                setState(() {
                  posty = -1;
                  Future.delayed(Duration(milliseconds: 100), () {
                    _tryAgain();
                    posty = -2;
                  });
                });
              },
              child: Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 40,
                  width: 250,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white54, width: 1),
                    color: (_visibile_error && posty == -1)
                        ? Colors.white
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: (_visibile_error && posty == -1)
                                ? Colors.black
                                : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.refresh,
                            color: (_visibile_error && posty == -1)
                                ? Colors.white
                                : Colors.black,
                          )),
                      Expanded(
                        child: Center(
                          child: Text(
                            "Try Again",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: (_visibile_error && posty == -1)
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget getBackgroundImage() {
    if (posty < 0 && slides.length > 0)
      return CachedNetworkImage(
          imageUrl: slides[side_current].image,
          fit: BoxFit.cover,
          width: Responsive.isMobile(context) ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width,
          height: Responsive.isMobile(context)
          // ? MediaQuery.of(context).size.height / 2.8.h
              ? MediaQuery.of(context).size.height / 2.1.h
              : MediaQuery.of(context).size.height,
          // width: 800.w,
          // height: 500.h,
          fadeInDuration: Duration(seconds: 1));
    if (posty == 0 && channels.length > 0)
      return CachedNetworkImage(
          imageUrl: channels[postx].image,
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fadeInDuration: Duration(seconds: 1));
    if (posty > 0 && genres.length > 0)
      return Container(
        color: Colors.black,
        child: CachedNetworkImage(
            imageUrl: genres[posty].posters![postx].cover,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fadeInDuration: Duration(seconds: 1)),
      );
    return Container(
      color: Colors.black,
    );
  }
}

// class MyBehavior extends ScrollBehavior {
//   @override
//   Widget buildViewportChrome(
//       BuildContext context, Widget child, AxisDirection axisDirection) {
//     return child;
//   }
// }


// import 'dart:convert' as convert;
//
// import 'package:carousel_slider/carousel_controller.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_app_tv/api/api_rest.dart';
// import 'package:flutter_app_tv/model/channel.dart' as model;
// import 'package:flutter_app_tv/model/genre.dart';
// import 'package:flutter_app_tv/model/poster.dart';
// import 'package:flutter_app_tv/model/slide.dart';
// import 'package:flutter_app_tv/ui/channel/channels.dart';
// import 'package:flutter_app_tv/ui/home/home.dart';
// import 'package:flutter_app_tv/ui/movie/movie.dart';
// import 'package:flutter_app_tv/ui/movie/movie_short_detail_mini.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
// class Test extends StatefulWidget {
//   const Test({Key? key}) : super(key: key);
//
//   @override
//   State<Test> createState() => _TestState();
// }
//
// class _TestState extends State<Test> {
//
//   List<Genre> genres = [];
//   List<Slide> slides = [];
//   List<model.Channel> channels = [];
//
//   int postx = 1;
//   int posty = -2;
//   int side_current = 0;
//   CarouselController _carouselController = CarouselController();
//   ItemScrollController _scrollController = ItemScrollController();
//   List<ItemScrollController> _scrollControllers = [];
//   List<int> _position_x_line_saver = [];
//   List<int> _counts_x_line_saver = [];
//   FocusNode home_focus_node = FocusNode();
//   Poster? selected_poster;
//   model.Channel? selected_channel;
//
//   List<Poster> postersList = [];
//
//   bool _visibile_loading = false;
//   bool _visibile_error = false;
//   bool _visibile_success = false;
//   bool? logged;
//   Image image = Image.asset("assets/images/profile.jpg");
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Future.delayed(Duration.zero, () {
//       FocusScope.of(context).requestFocus(home_focus_node);
//       _getList();
//       getLogged();
//     });
//   }
//
//   // @override
//   // void onResume() {
//   //   // TODO: implement onResume
//   //   super.onResume();
//   //   getLogged();
//   // }
//
//   getLogged() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//
//     logged = await prefs.getBool("LOGGED_USER");
//
//     if (logged == true) {
//       image = Image.network(await prefs.getString("IMAGE_USER")!);
//     } else {
//       logged = false;
//       image = Image.asset("assets/images/profile.jpg");
//     }
//     setState(() {
//       print(logged);
//     });
//   }
//   void _showLoading() {
//     setState(() {
//       _visibile_loading = true;
//       _visibile_error = false;
//       _visibile_success = false;
//     });
//   }
//   void _getList() async {
//     _counts_x_line_saver.clear();
//     _position_x_line_saver.clear();
//     _scrollControllers.clear();
//     _showLoading();
//     var response = await apiRest.getHomeData();
//     if (response == null) {
//       _showTryAgain();
//     } else {
//       if (response.statusCode == 200) {
//         var jsonData = convert.jsonDecode(response.body);
//         if (jsonData["slides"] != null) {
//           for (Map<String, dynamic> slide_map in jsonData["slides"]) {
//             Slide slide = Slide.fromJson(slide_map);
//             slides.add(slide);
//           }
//         }
//         if (jsonData["channels"] != null) {
//           for (Map<String, dynamic> channel_map in jsonData["channels"]) {
//             model.Channel channel = model.Channel.fromJson(channel_map);
//             channels.add(channel);
//           }
//           if (channels.length > 0) {
//             ItemScrollController controller = new ItemScrollController();
//             _scrollControllers.add(controller);
//             _position_x_line_saver.add(0);
//             _counts_x_line_saver.add(channels.length);
//
//             genres.add(new Genre(id: -3, title: "title", posters: []));
//           }
//         }
//         if (jsonData["genres"] != null) {
//           for (Map<String, dynamic> genre_map in jsonData["genres"]) {
//             Genre genre = Genre.fromJson(genre_map);
//             if (genre.posters!.length > 0) {
//               genres.add(genre);
//               ItemScrollController controller = new ItemScrollController();
//               _scrollControllers.add(controller);
//               _position_x_line_saver.add(0);
//               _counts_x_line_saver.add(genre.posters!.length);
//             }
//           }
//         }
//
//         _showData();
//       } else {
//         _showTryAgain();
//       }
//     }
//     setState(() {});
//   }
//   void _showData() {
//     setState(() {
//       _visibile_loading = false;
//       _visibile_error = false;
//       _visibile_success = true;
//     });
//   }
//   void _showTryAgain() {
//     setState(() {
//       _visibile_loading = false;
//       _visibile_error = true;
//       _visibile_success = false;
//     });
//   }
//   int currentIndex = 0;
//   List<Widget> screen = [
//     Home(),
//     Movie(),
//     MovieShortDetailMiniWidget(),
//     Channels()
//   ];
//   void changeBottomBar(int index){
//     currentIndex = index;
//     if(index == 0) Home();
//     if(index == 1) Movie();
//     if(index == 2) MovieShortDetailMiniWidget();
//     if(index == 3) Channels();
//   }
//   List<BottomNavigationBarItem> bottomItems = [
//     BottomNavigationBarItem(
//       icon: Icon(
//         Icons.business,
//       ),
//       label: 'Business',
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(
//         Icons.sports,
//       ),
//       label: 'Sports',
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(
//         Icons.science,
//       ),
//       label: 'Science',
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       // bottomNavigationBar: Container(
//       //   color: Colors.black,
//       //   child: Padding(
//       //     padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
//       //     child: GNav(
//       //       backgroundColor: Colors.black,
//       //       color: Colors.white,
//       //       activeColor: Colors.white,
//       //       tabBackgroundColor: Colors.grey.shade800,
//       //       gap: 8,
//       //       onTabChange: (index)
//       //       {
//       //         changeBottomBar(index);
//       //       },
//       //       padding: EdgeInsets.all(16),
//       //       tabs: const[
//       //         GButton(icon: Icons.home, text: "Home",),
//       //         GButton(icon: Icons.movie_creation_outlined, text: "Movies"),
//       //         GButton(icon: Icons.slideshow_sharp, text: "Shows",),
//       //         GButton(icon: Icons.live_tv, text: "Live TV",),
//       //       ],
//       //     ),
//       //   ),
//       // ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: currentIndex,
//         items: bottomItems,
//         onTap: (index)
//         {
//           changeBottomBar(index);
//         },
//
//       ),
//       body: screen[currentIndex],
//     );
//   }
// }
