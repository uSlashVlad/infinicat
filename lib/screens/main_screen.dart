import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toast/toast.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:infinicat/constants.dart';
import 'package:infinicat/widgets/iconic_button.dart';
import 'package:infinicat/services/api.dart';
import 'package:infinicat/services/downloading.dart';
import 'package:infinicat/services/prefs.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  CatAPI api = CatAPI();
  DownloadHelper downloader = DownloadHelper();
  String imageSrc = '';
  String imgType = 'jpg,png,gif';

  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  void asyncInit() async {
    await loadData();
    updateImage();
  }

  Future<void> loadData() async {
    imgType = await loadString(kPreferenceKeys['image_type']);
  }

  void settingsCallback(String newImgType) {
    imgType = newImgType;
  }

  Future<void> updateImage() async {
    bool result = await DataConnectionChecker().hasConnection;
    if (result) {
      try {
        if (imageSrc != '') {
          setState(() {
            imageSrc = '';
          });
        }
        await api.loadData(imgType);
        setState(() {
          imageSrc = api.getImageSrc();
        });
      } catch (e) {
        print(e);
      }
    } else {
      Toast.show(
        'No internet connection found',
        context,
        duration: Toast.LENGTH_SHORT,
        gravity: Toast.BOTTOM,
      );
      Timer(
          Duration(
            seconds: 5,
          ),
          updateImage);
    }
  }

  void downloadImage() async {
    Toast.show(
      'Download has been started',
      context,
      duration: Toast.LENGTH_SHORT,
      gravity: Toast.BOTTOM,
    );

    DownloadStatus result = await downloader.download(imageSrc);

    String resultStr;
    switch (result) {
      case DownloadStatus.completed:
        resultStr = 'Download completed';
        break;
      case DownloadStatus.noPerm:
        resultStr = 'You have to give Storage permisions';
        break;
      default:
        resultStr = 'Error while downloading occurred';
    }
    Toast.show(
      resultStr,
      context,
      duration: Toast.LENGTH_SHORT,
      gravity: Toast.BOTTOM,
    );
  }

  void upvote() async {
    int response = await api.upvote();
    if (response == 200) {
      Toast.show(
        'Successfull upvote',
        context,
        gravity: Toast.BOTTOM,
      );
    } else {
      Toast.show(
        'Unsuccessfull upvote: $response',
        context,
        gravity: Toast.BOTTOM,
      );
    }
  }

  void downvote() async {
    int response = await api.downvote();
    if (response == 200) {
      Toast.show(
        'Successfull downvote',
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
      );
    } else {
      Toast.show(
        'Unsuccessfull downvote: $response',
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'InfiniCat',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w500,
              ),
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/settings',
                  arguments: settingsCallback,
                );
              },
            )
          ],
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Container(
                child: ClipRRect(
                  child: Stack(
                    children: [
                      Container(
                        child: SpinKitChasingDots(color: theme.accentColor),
                        width: 60,
                        height: 60,
                      ),
                      (imageSrc != '') ? Image.network(imageSrc) : SizedBox(),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(kCardRadius),
                ),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(kCardRadius),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: IconicButton(
                        text: 'LOVE IT',
                        icon: Icons.thumb_up,
                        textColor: Colors.white,
                        color: Color(0xff4caf50),
                        callback: upvote,
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: IconicButton(
                        text: 'NOPE IT',
                        icon: Icons.thumb_down,
                        textColor: Colors.white,
                        color: Color(0xfff44336),
                        callback: downvote,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                IconicButton(
                  text: 'NEXT CAT',
                  icon: Icons.repeat,
                  color: Color(0xff2196f3),
                  textColor: Colors.white,
                  callback: updateImage,
                ),
                SizedBox(height: 5),
                IconicButton(
                  text: 'DOWNLOAD',
                  icon: Icons.file_download,
                  color: Colors.yellow[800],
                  textColor: Colors.white,
                  callback: downloadImage,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
