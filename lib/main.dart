import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tvflix/test.dart';
import 'package:tvflix/ui/auth/login.dart';
import 'package:tvflix/ui/channel/channel_detail.dart';
import 'package:tvflix/ui/channel/channels.dart';
import 'package:tvflix/ui/comment/comment_add.dart';
import 'package:tvflix/ui/comment/comments.dart';
import 'package:tvflix/ui/home/home.dart';
import 'package:tvflix/ui/movie/movie.dart';
import 'package:tvflix/ui/movie/movies.dart';
import 'package:tvflix/ui/pages/splash.dart';
import 'package:tvflix/ui/review/review_add.dart';
import 'package:tvflix/ui/review/reviews.dart';
import 'package:tvflix/ui/serie/serie.dart';
import 'package:tvflix/ui/serie/series.dart';

// import 'package:wakelock/wakelock.dart';
import 'ui/player/video_player.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // await Firebase.initializeApp();
  // Wakelock.enable();
  // runApp(
  //   DevicePreview(enabled: true, builder: (context) =>
  //       MyApp()
  //   ),
  // );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child)
      {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          home: Splash(),
          routes: {
            "/splash": (context) => Splash(),
            "/home": (context) => Home(),
            "/movie": (context) => Movie(),
            "/serie": (context) => Serie(),
            "/channel_detail": (context) => ChannelDetail(),
            "/channels": (context) => Channels(),
            "/movies": (context) => Movies(),
            "/series": (context) => Series(),
            "/reviews": (context) => Reviews(id: 1, image: "image", title: 'title', type: "type"),
            "/review_add": (context) => ReviewAdd(type: "", id: 1, image: 'image'),
            "/comments": (context) => Comments(),
            "/comment_add": (context) => CommentAdd(image: "", id: 1,type: ""),
            "/login": (context) => Login(),
            "/test": (context) => Test(),
            "/video_player": (context) => VideoPlayer(focused_source: 0),
          },
        );
      },
      child: Splash(),

    );
  }
}