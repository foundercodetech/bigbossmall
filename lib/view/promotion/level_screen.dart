import 'package:bbm/main.dart';
import 'package:flutter/foundation.dart';
import 'package:bbm/generated/assets.dart';
import 'package:bbm/res/aap_colors.dart';
import 'package:bbm/res/components/app_bar.dart';
import 'package:bbm/res/components/app_btn.dart';
import 'package:bbm/res/components/text_widget.dart';
import 'package:flutter/material.dart';



class LevelScreen extends StatefulWidget {
  String ? name;
  final data;
   LevelScreen({super.key,  this.name, this.data});

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {

  @override
  void initState() {
    level();
    // TODO: implement initState
    super.initState();
  }
  List<LevelModel> levelList = [];
  level(){
    if (kDebugMode) {
      print(widget.data[widget.name]);
    }
    if(widget.name!=null){
    if(widget.data!=null) {
      for (var data in widget.data[widget.name]) {
        levelList.add(
            LevelModel(level: data['username'].toString(),
            user: data['turnover'].toString(),
            // commission: data['commission'].toStringAsFixed(2)
            commission: data['commission'].toString()
            )
        );
      }
    }
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: GradientAppBar(
          leading:const AppBackBtn(),
          title: textWidget(
              text: widget.name.toString(), fontSize: 25, color: AppColors.primaryTextColor),
          gradient: AppColors.primaryappbargrey),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 2, 10, 0),
            child: Container(
              width: width,
              height: height*0.09,
              decoration: const BoxDecoration(
                  color: AppColors.containerBgColor,
                  image: DecorationImage(
                      image: AssetImage(Assets.imagesContainerBg),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  )),
              child: Center(
                  child: textWidget(
                      text: 'Subscriber and Commission',
                      fontSize: 20,
                      color: AppColors.primaryTextColor
                  ),
                ),
            ),
          ),

          SizedBox(height: height*0.02,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              textWidget(text: 'Username',fontWeight: FontWeight.w800, fontSize: 14,),
              textWidget(text: 'Turnover',fontWeight: FontWeight.w800, fontSize: 14,),
              textWidget(text: 'Commission',fontWeight: FontWeight.w800,fontSize: 14,),
            ],
          ),
          const Divider(thickness: 2,indent: 10,endIndent: 10,),
          levelList.isEmpty?Container():  Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: levelList.length,
                physics: const ScrollPhysics(),
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  return Container(
                    height: 45,

                    decoration: const BoxDecoration(
                      color: AppColors.primaryContColor,
                    ),
                    child: Card(
                      elevation: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 80,
                            child: textWidget(
                              text: levelList[index].level,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(
                            width: 80,
                            child: textWidget(
                              textAlign: TextAlign.center,
                              text: levelList[index].user,
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 80,
                            child: textWidget(
                              text: levelList[index].commission,
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

}

class LevelModel {
  final String level;
  final String user;
  final String commission;

  LevelModel({
    required this.level,
    required this.user,
    required this.commission,
  });
}