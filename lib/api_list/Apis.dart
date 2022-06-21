import '../src/repository/DataApi.dart';
import '../src/repository/Data_Repository.dart';

class Apis{


  static DataRepository testApi({required String test}){
    return DataRepository(dataApi: DataApi(
      url: "https://jsonplaceholder.typicode.com/photos",
      data: {},
    ));
  }

}