import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app2/controller/news_layout_controller.dart';
import 'package:news_app2/global.dart';
import 'package:news_app2/view/login.dart';
import 'package:news_app2/view/news_details.dart';
import 'package:news_app2/view/search_page.dart';

class NewsLayout extends StatelessWidget {

  NewsLayoutController newsLayoutController = Get.put(NewsLayoutController());

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return  Scaffold(
        drawer: Drawer(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              children: [
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Info', style: TextStyle(fontSize: 15),),
                    Icon(Icons.info),
                  ],
                ),
                Divider(height: 20,thickness: 1,color: Colors.grey.withOpacity(0.5),),
                GestureDetector(
                  onTap: (){
                    Global.logout();
                    Get.offAll(()=>Login());
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Log out', style: TextStyle(fontSize: 15),),
                        Icon(Icons.logout),
                      ],
                    ),
                  ),
                ),
                Divider(height: 20,thickness: 1,color: Colors.grey.withOpacity(0.5),)
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text(
            "News App",
          ),
          actions: [
            IconButton(
              onPressed: (){
                Get.to(()=> SearchPage());
              },
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: (){
                //AppCubit.get(context).changeAppMode();
              },
              icon: const Icon(Icons.brightness_4_outlined),
            ),

          ],
        ),
        body: Stack(
          children: [
            newsLayoutController.currentIndex.value == 0
                ? _businessScreen()
                : newsLayoutController.currentIndex.value == 1
                ? _sportsScreen()
                : _scienceScreen(),
           Container(
             width: MediaQuery.of(context).size.width,
             height: 170,
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.only(
                   bottomRight: Radius.circular(5),
                   bottomLeft: Radius.circular(5)
               ),
               boxShadow: [
                 BoxShadow(
                   color: Colors.black.withOpacity(0.2),
                   spreadRadius: 1,
                   blurRadius: 3,
                   offset: Offset(0, 2), // changes position of shadow
                 ),
               ],
             ),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Container(
                   padding: EdgeInsets.only(top: 10,left: 10),
                   child: const Text('Recommended News',style: TextStyle(fontSize: 15),),
                 ),
                 Container(
                   padding: EdgeInsets.only(top: 10,bottom: 10),
                     width: MediaQuery.of(context).size.width,
                     height: 140,
                     child: newsLayoutController.favoriteLoading.value
                         ? Center(child: CircularProgressIndicator(),)
                     : CarouselSlider(
                       options: CarouselOptions(
                         initialPage: 0,
                         enableInfiniteScroll: true,
                         reverse: false,
                         autoPlay: true,
                         autoPlayInterval: Duration(seconds: 5),
                         autoPlayAnimationDuration: Duration(milliseconds: 800),
                         autoPlayCurve: Curves.fastOutSlowIn,
                         enlargeCenterPage: true,
                         scrollDirection: Axis.horizontal,
                       ),
                       items: newsLayoutController.favorite.map((i) {
                         return Builder(
                           builder: (BuildContext context) {
                             return Stack(
                               alignment: Alignment.center,
                               children: [
                                 Container(
                                   width: MediaQuery.of(context).size.width,
                                   height: 120,
                                   margin: EdgeInsets.symmetric(horizontal: 5.0),
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(10),
                                       image: DecorationImage(
                                         image: NetworkImage(i.urlToImage),
                                         fit: BoxFit.cover,
                                       )
                                   ),
                                   child: Container(
                                     width: MediaQuery.of(context).size.width,
                                     height: 120,
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(10),
                                       color: Colors.black.withOpacity(0.5),
                                     ),
                                   ),
                                 ),
                                 Container(
                                   padding: EdgeInsets.symmetric(horizontal: 20),
                                   child: Text(
                                     i.title,
                                     maxLines: 4,
                                     textAlign: TextAlign.center,
                                     style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                 ),
                               ],
                             );
                           },
                         );
                       }).toList(),
                     )
                 ),
               ],
             ),
           )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: bottomItems,
          currentIndex: newsLayoutController.currentIndex.value,
          onTap: (index) {
            newsLayoutController.changeBottomBarIndex(index);
          },
        ),
      );
    });
  }

  _businessScreen(){
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 170),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: newsLayoutController.business.length,
          itemBuilder: (BuildContext context, index){
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: (){
                  newsLayoutController.increaseBusiness();
                  Get.to(()=>NewsDetails(newsLayoutController.business[index]));
                },
                child: Container(
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                              newsLayoutController.business[index].urlToImage,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 120,
                          child: Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Text(
                                  newsLayoutController.business[index].title,
                                  style:Theme.of(context).textTheme.bodyText1,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                newsLayoutController.business[index].publishedAt,
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  _sportsScreen(){
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 170),

        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: newsLayoutController.sports.length,
          itemBuilder: (BuildContext context, index){
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: (){
                  newsLayoutController.increaseSports();
                  Get.to(()=>NewsDetails(newsLayoutController.sports[index]));
                },
                child: Container(
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                              newsLayoutController.sports[index].urlToImage,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 120,
                          child: Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Text(
                                  newsLayoutController.sports[index].title,
                                  style:Theme.of(context).textTheme.bodyText1,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                newsLayoutController.sports[index].publishedAt,
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _scienceScreen(){
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 170),

        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: newsLayoutController.science.length,
          itemBuilder: (BuildContext context, index){
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: (){
                  newsLayoutController.increaseScience();
                  Get.to(()=>NewsDetails(newsLayoutController.science[index]));
                },
                child: Container(
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                              newsLayoutController.science[index].urlToImage,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 120,
                          child: Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Text(
                                  newsLayoutController.science[index].title,
                                  style:Theme.of(context).textTheme.bodyText1,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                newsLayoutController.science[index].publishedAt,
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> bottomItems=[
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: "Business",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: "Sports",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: "Science",
    ),
  ];


}
