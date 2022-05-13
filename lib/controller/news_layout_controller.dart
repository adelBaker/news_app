import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:news_app2/global.dart';
import 'package:news_app2/model/api.dart';
import 'package:news_app2/model/article.dart';

class NewsLayoutController extends GetxController{

  RxInt currentIndex = 0.obs;
  RxList<Article> business = <Article>[].obs;
  RxList<Article> science = <Article>[].obs;
  RxList<Article> sports = <Article>[].obs;
  RxList<Article> favorite = <Article>[].obs;
  RxList<Article> tempSearchList = <Article>[].obs;

  TextEditingController editingController = TextEditingController();

  int sportCounter = 0;
  int businessCounter = 0;
  int scienceCounter = 0;

  int randomNumber = 0;
  List<int> randomList = [];

  List<int> counters = <int>[0,0,0];

  RxBool favoriteLoading = false.obs;




  @override
  void onInit() async{
    randomList.clear();
    favoriteLoading.value = true;
    tempSearchList.addAll(business);
    tempSearchList.addAll(science);
    tempSearchList.addAll(sports);
   await getData().then((_){
      getFavorite();
    });
  }

  Future getData()async{
    await Api.getBusiness().then((value){
      business.addAll(value);
    });
    await Api.getScience().then((value){
      science.addAll(value);
    });
    await Api.getSports().then((value){
      sports.addAll(value);
    });
  }

  getFavorite(){
    Api.getFavoriteCategore(Global.userId.toString()).then((value){
      counters[0] = int.parse(value.sportCounter);
      counters[1] = int.parse(value.scienceCounter);
      counters[2] = int.parse(value.buisnessCounter);

      Random random = Random();

      if (counters[0] == counters[1] && counters[0] == counters[2] ){
        ///Same favorite
        print('Same favorite');
        for(int i = 0; i < sports.length / 6; i++){
          randomNumber = random.nextInt(sports.length);
          if(!randomList.contains(randomNumber)){
            randomList.add(randomNumber);
            favorite.add(sports[randomNumber]);
          }
        }
        randomList.clear();
        for(int i = 0; i < science.length / 6; i++){
          randomNumber = random.nextInt(science.length);
          if(!randomList.contains(randomNumber)){
            randomList.add(randomNumber);
            favorite.add(science[randomNumber]);
          }
        }
        randomList.clear();
        for(int i = 0; i < business.length / 6; i++){
          randomNumber = random.nextInt(business.length);
          if(!randomList.contains(randomNumber)){
            randomList.add(randomNumber);
            favorite.add(business[randomNumber]);
          }
        }
        print('favorite length ${favorite.length}');
      }
      else if (counters[0] == counters[1] && counters[1] > counters[2] ){
        ///sport science
        print('sport science');
        for(int i = 0; i < sports.length / 5; i++){
          randomNumber = random.nextInt(sports.length);
          if(!randomList.contains(randomNumber)){
            randomList.add(randomNumber);
            favorite.add(sports[randomNumber]);
          }
        }
        randomList.clear();
        for(int i = 0; i < science.length / 5; i++){
          randomNumber = random.nextInt(science.length);
          if(!randomList.contains(randomNumber)){
            randomList.add(randomNumber);
            favorite.add(science[randomNumber]);
          }
        }
        print('favorite length ${favorite.length}');
      }
      else if (counters[0] == counters[2] && counters[2] > counters[1] ){
        ///sport business
        print('sport business');
        for(int i = 0; i < sports.length / 5; i++){
          randomNumber = random.nextInt(sports.length);
          if(!randomList.contains(randomNumber)){
            randomList.add(randomNumber);
            favorite.add(sports[randomNumber]);
          }
        }
        randomList.clear();
        for(int i = 0; i < business.length / 5; i++){
          randomNumber = random.nextInt(business.length);
          if(!randomList.contains(randomNumber)){
            randomList.add(randomNumber);
            favorite.add(business[randomNumber]);
          }
        }
        print('favorite length ${favorite.length}');
      }
      else if (counters[1] == counters[2] && counters[1] > counters[0] ){
        ///science business
        print('science business');
        for(int i = 0; i < science.length / 5; i++){
          randomNumber = random.nextInt(science.length);
          if(!randomList.contains(randomNumber)){
            randomList.add(randomNumber);
            favorite.add(science[randomNumber]);
          }
        }
        randomList.clear();
        for(int i = 0; i < business.length / 5; i++){
          randomNumber = random.nextInt(business.length);
          if(!randomList.contains(randomNumber)){
            randomList.add(randomNumber);
            favorite.add(business[randomNumber]);
          }
        }
        print('favorite length ${favorite.length}');
      }
      else if (counters.indexOf(counters.reduce(max)) == 0){
        print('sport favorite');
        int  i = 0;
        while( i < sports.length / 4 ){
          randomNumber = random.nextInt(sports.length);
          if(!randomList.contains(randomNumber)){
            randomList.add(randomNumber);
            favorite.add(sports[randomNumber]);
            i++;
          }
        }
        print('favorite length ${favorite.length}');
      }
      else if (counters.indexOf(counters.reduce(max)) == 1){
        print('scinece favorite');
        int  i = 0;
        while( i < science.length / 4 ){
          randomNumber = random.nextInt(science.length);
          if(!randomList.contains(randomNumber)){
            randomList.add(randomNumber);
            favorite.add(science[randomNumber]);
            i++;
          }
        }
        print('favorite length ${favorite.length}');
      }
      else if (counters.indexOf(counters.reduce(max)) == 2){
        print('business favorite');
        int  i = 0;
        while( i < business.length / 4 ){
          randomNumber = random.nextInt(business.length);
          if(!randomList.contains(randomNumber)){
            randomList.add(randomNumber);
            favorite.add(business[randomNumber]);
            i++;
          }
        }
        print('favorite length ${favorite.length}');
      }
      favoriteLoading.value = false;
    });
  }

  changeBottomBarIndex(index){
    currentIndex.value = index;
  }

  increaseBusiness(){
    print('Global user ID');
    print(Global.userId.toString());
    Api.increaseBusinessCounter(Global.userId.toString()).then((value){
      if(value){
        print('Done');
      }else
        print('Field');
    });
  }

  increaseSports(){
    Api.increaseSportCounter(Global.userId.toString()).then((value){
      if(value){
        print('Done');
      }else
        print('Field');
    });
  }

  increaseScience(){
    Api.increaseScienceCounter(Global.userId.toString()).then((value){
      if(value){
        print('Done');
      }else
        print('Field');
    });
  }

  search(String query){
    List<Article> dummySearchList = <Article>[];

    dummySearchList.addAll(business);
    dummySearchList.addAll(science);
    dummySearchList.addAll(sports);

    print('search length ${dummySearchList.length}');

    if(query.isNotEmpty) {
      List<Article> dummyListData = <Article>[];
      for (var article in dummySearchList) {
        if(article.title.toLowerCase().contains(query)) {
          dummyListData.add(article);
        }
      }
      tempSearchList.clear();
      tempSearchList.addAll(dummyListData);
      print('temp search lenght ${tempSearchList.length}');
      return;
    } else {
      print('empty');
      tempSearchList.clear();
      tempSearchList.addAll(business);
      tempSearchList.addAll(science);
      tempSearchList.addAll(sports);

    }
  }



}