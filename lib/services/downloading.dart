import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:image_save/image_save.dart';
import 'package:permission_handler/permission_handler.dart';

enum DownloadStatus {
  completed,
  error,
  noPerm,
}

class DownloadHelper {
  Future<DownloadStatus> download(String url) async {
    try {
      // Checks for write permissions
      // If everything is allright, tries to download file
      if (await _checkPermission()) {
        final res = await ImageSave.saveImage(
          await _getData(url),
          url.split('.').last,
          albumName: 'InfiniCat',
        );
        return (res) ? DownloadStatus.completed : DownloadStatus.error;
      } else {
        return DownloadStatus.noPerm;
      }
    } catch (e) {
      // If everything isn't allright, returns an error
      print(e);
      return DownloadStatus.error;
    }
  }

  Future<Uint8List> _getData(String url) async {
    Response<List<int>> res = await Dio().get<List<int>>(
      url,
      options: Options(responseType: ResponseType.bytes),
    );
    return Uint8List.fromList(res.data);
  }

  Future<bool> _checkPermission() async {
    var status = await Permission.storage.request();
    return status.isGranted;
  }
}
