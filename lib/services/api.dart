import 'package:infinicat/services/networking.dart';
import 'package:dio/dio.dart';
import 'package:infinicat/constants.dart';

const apiKey = '52f46af4-842c-42be-8bee-470eb80a7996';

enum VoteType { down, up }

class CatAPI {
  var data;

  Future<void> loadData(String imgType) async {
    String url = '${kApiUrl}images/search/?mime_types=$imgType';
    data = (await NetworkHelper.getData(url)).data[0];
  }

  String getImageSrc() {
    return data['url'];
  }

  Future<int> upvote() async {
    return (await _vote(1)).statusCode;
  }

  Future<int> downvote() async {
    return (await _vote(0)).statusCode;
  }

  Future<Response> _vote(int type) async {
    String url = '${kApiUrl}votes/';
    Response result = await NetworkHelper.sendData(
      url,
      headers: {"x-api-key": apiKey},
      data: {"image_id": data['id'], "value": type},
    );
    return result;
  }
}
