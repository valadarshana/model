import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model/src/bloc/Data_Bloc.dart';
import 'package:model/src/bloc/Data_Events.dart';
import 'package:model/src/bloc/Data_State.dart';
import 'package:model/src/model/photo_model.dart';
import 'package:model/src/repository/DataApi.dart';
import 'package:model/src/repository/Data_Repository.dart';

import 'api_list/Apis.dart';



class TestDesign extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>TestDesignState();
}

class TestDesignState extends State<TestDesign>{

  bool flagForBuilder=false;
  late DataRepository _dataRepository;
  late DataBloc _dataBloc;
   List<photoModel> photos=[];



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCall();
  }

  void apiCall(){
    setState(() {
      flagForBuilder=true;
    });

    // _dataRepository=DataRepository(dataApi: DataApi(
    //   url: "https://jsonplaceholder.typicode.com/photos",
    //   data: {},
    // ));
    _dataRepository= Apis.testApi(test: "test");

    _dataBloc = DataBloc(dataRepository: _dataRepository);
    _dataBloc.add(FetchData());
  }


  void parsePhotos(String responseBody){
    var l= json.decode(responseBody) as List<dynamic>;
    //print('list $l');
    var v=l[0];

    photos=[];
  // print(l.map((e) => photoModel.fromJson(e)));
    v.forEach((element) {
      photos.add(photoModel.fromJson(element));
    });
    WidgetsBinding.instance?.addPostFrameCallback((_){
      setState(() {
        flagForBuilder=false;
      });
    });

   // photos=v.map((e) => photoModel.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: flagForBuilder==true?
        BlocBuilder<DataBloc, UsersState>(
            bloc: _dataBloc,
            builder: (context, state) {
              if (state is UsersLoading) {
                return Center(
                  child: CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColorDark,),
                );
              }
              if(state is UsersLoaded) {
                //print('hello ${state.responseData}');

                parsePhotos(json.encode(state.responseData));
                //print('response is ${state.responseData.runtimeType}');
              }
              if (state is UsersError) {
                return Center(
                  child:  Text('Network unavailable',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                );
              }
              return Container();
            }):Container(
              child:  Text('test calling ${photos[0].title}'),
        ),
      ),
    );
  }

}