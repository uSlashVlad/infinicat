import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toast/toast.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:infinicat/constants.dart';
import 'package:infinicat/widgets/iconic_button.dart';
import 'package:infinicat/services/api.dart';
import 'package:infinicat/services/downloading.dart';
import 'package:infinicat/services/prefs.dart';
import 'package:infinicat/theme_config.dart';
import 'package:infinicat/provider_model.dart';

/// Main screen widget
///
/// `/` route
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
      _toast('No internet connection found');
      Timer(
          Duration(
            seconds: 5,
          ),
          updateImage);
    }
  }

  void downloadImage() async {
    _toast('Download has been started');

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
    _toast(resultStr);
  }

  void upvote() async {
    int response = await api.upvote();
    if (response == 200) {
      _toast('Successfull upvote');
    } else {
      _toast('Unsuccessfull upvote: $response');
    }
  }

  void downvote() async {
    int response = await api.downvote();
    if (response == 200) {
      _toast('Successfull downvote');
    } else {
      _toast('Unsuccessfull downvote: $response');
    }
  }

  void _toast(String text) => Toast.show(text, context);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
            // Block of image and widgets for it
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

            SizedBox(height: 10),

            // Block of buttons
            // Uses provider fow themes implementation
            Consumer(
              builder: (context, ProviderModel value, child) {
                final btnColor = buttonsColors[value.themeCode];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: IconicButton(
                            text: 'LOVE IT',
                            icon: Icons.thumb_up,
                            textColor: btnColor[0],
                            color: btnColor[1],
                            callback: upvote,
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: IconicButton(
                            text: 'NOPE IT',
                            icon: Icons.thumb_down,
                            textColor: btnColor[0],
                            color: btnColor[2],
                            callback: downvote,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    IconicButton(
                      text: 'NEXT CAT',
                      icon: Icons.repeat,
                      textColor: btnColor[0],
                      color: btnColor[3],
                      callback: updateImage,
                    ),
                    SizedBox(height: 5),
                    IconicButton(
                      text: 'DOWNLOAD',
                      icon: Icons.file_download,
                      textColor: btnColor[0],
                      color: btnColor[4],
                      callback: downloadImage,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
