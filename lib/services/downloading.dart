import 'dart:io';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:permission_handler/permission_handler.dart';

enum DownloadStatus {
  completed,
  error,
  noPerm,
}

class DownloadHelper {
  Future<DownloadStatus> download(String url) async {
    Directory downloadDirectory =
        await DownloadsPathProvider.downloadsDirectory;
    Dio dio = Dio();
    String filename = url.split('/').last;

    print(downloadDirectory);

    if (await _checkPermission()) {
      var downloading = await dio.download(
        url,
        '${downloadDirectory.path}/$filename',
      );
      if (downloading.statusCode == 200) {
        return DownloadStatus.completed;
      } else {
        return DownloadStatus.error;
      }
    } else {
      return DownloadStatus.noPerm;
    }
  }

  Future<bool> _checkPermission() async {
    var status = await Permission.storage.request();
    return status.isGranted;
  }
}
