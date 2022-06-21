import 'dart:async';
import 'package:meta/meta.dart';
import 'DataApi.dart';

class DataRepository {
  final DataApi dataApi;
  DataRepository({required this.dataApi})
      : assert(dataApi != null);

  Future<List<Object>> getData() async {
    return await dataApi.fetchData();
  }
}