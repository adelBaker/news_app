import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app2/controller/news_layout_controller.dart';
import 'package:news_app2/view/news_details.dart';

class SearchPage extends StatelessWidget {

  NewsLayoutController newsLayoutController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return  Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 10),
                TextField(
                  onChanged: (value){
                    newsLayoutController.search(value);
                  },
                  style: Theme.of(context).textTheme.bodyText2,
                  controller: newsLayoutController.editingController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(bottom: 0),
                    labelText: 'search',
                    labelStyle: TextStyle(color: Theme.of(context).dividerColor,fontSize: 14),
                    prefixIcon: Icon(Icons.search,color: Theme.of(context).dividerColor,),
                   // prefixIconColor: Theme.of(context).primaryColor,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(width: 1,color: Theme.of(context).primaryColor),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1,color: Theme.of(context).dividerColor.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(10),),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).dividerColor.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                  Container(
                    child:  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: newsLayoutController.tempSearchList.length,
                      itemBuilder: (context, index){
                        return GestureDetector(
                          onTap: (){
                            Get.to(()=>NewsDetails(newsLayoutController.tempSearchList[index]));
                          },
                          child: Column(
                            children: [
                              Container(
                                color: Colors.transparent,
                                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: 100,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(newsLayoutController.tempSearchList[index].urlToImage),
                                          fit: BoxFit.cover
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Container(
                                      width: 150,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(newsLayoutController.tempSearchList[index].title,maxLines: 2, style: TextStyle(fontSize: 15, color: Colors.black)),
                                          Text(newsLayoutController.tempSearchList[index].publishedAt, style: TextStyle(fontSize: 13,color: Colors.grey),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(height: 10,color: Colors.black.withOpacity(0.5), indent: 35,endIndent: 25,)
                            ],
                          ),
                        );
                      },
                    ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
