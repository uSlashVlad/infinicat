import 'package:infinicat/services/networking.dart';
import 'package:dio/dio.dart'; // Dio here is only for "Response" class
import 'package:infinicat/constants.dart';

/// Ooops, API key in public repository.
/// I know it, but I think it's okay in this case
const apiKey = '52f46af4-842c-42be-8bee-470eb80a7996';

/// Upvote / Downvote. Like on official API website
enum VoteType { down, up }

class CatAPI {
  Map _data;

  /// It loads data from API and stores in this class
  Future<void> loadData(String imgType) async {
    String url = '${kApiUrl}images/search/?mime_types=$imgType';
    _data = (await NetworkHelper.getData(url)).data[0];
  }

  /// It returns just url of loaded image
  String getImageSrc() {
    return _data['url'];
  }

  /// It returns status code of upvote request
  Future<int> upvote() async {
    return (await _vote(1)).statusCode;
  }

  /// It returns status code of downvote request
  Future<int> downvote() async {
    return (await _vote(0)).statusCode;
  }

  /// It makes POST vote request to API and returns request status code
  Future<Response> _vote(int type) async {
    String url = '${kApiUrl}votes/';
    Response result = await NetworkHelper.sendData(
      url,
      headers: {"x-api-key": apiKey},
      data: {"image_id": _data['id'], "value": type},
    );
    return result;
  }
}
