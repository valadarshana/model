import 'dart:convert';

import 'package:http/http.dart' as http;


class DataApi {
  final String url;
  Map<String,String> data;
  final beforeImage;
  final afterImage;
  final sign;
  final img;


  DataApi({required this.url,required this.data,this.beforeImage,this.afterImage,this.sign,this.img});

  Future<List<Object>> fetchData() async {

    final List<Object> fetchData = [];

        var request = http.MultipartRequest("GET", Uri.parse(url));

        //request.fields.addAll(data);

        http.StreamedResponse response = await request.send();

        var responseBody = await http.Response.fromStream(response);
        fetchData.add(json.decode(responseBody.body));

        //print('here response is ff ${fetchData[0]}');

        return fetchData;
  }
}