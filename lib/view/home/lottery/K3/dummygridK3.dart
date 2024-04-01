// ignore_for_file: non_constant_identifier_names

import 'package:bbm/main.dart';
import 'package:flutter/material.dart';
import 'package:bbm/generated/assets.dart';
import 'package:bbm/res/aap_colors.dart';
import 'package:bbm/res/components/text_widget.dart';


class DummygridK3 extends StatefulWidget {
  const DummygridK3({super.key});

  @override
  State<DummygridK3> createState() => _DummygridK3State();
}

class _DummygridK3State extends State<DummygridK3> {


  List<TotalWidget> totalitems = [
    TotalWidget(Assets.imagesRedplainK3, "3", "207.36X",Colors.red),
    TotalWidget(Assets.imagesGreenplainK3, "4", "69.36X",Colors.green),
    TotalWidget(Assets.imagesRedplainK3, "5", "34.36X",Colors.red),
    TotalWidget(Assets.imagesGreenplainK3, "6", "20.36X",Colors.green),
    TotalWidget(Assets.imagesRedplainK3, "7", "13.36X",Colors.red),
    TotalWidget(Assets.imagesGreenplainK3, "8", "207.36X",Colors.green),
    TotalWidget(Assets.imagesRedplainK3, "9", "07.36X",Colors.red),
    TotalWidget(Assets.imagesGreenplainK3, "10", "27.36X",Colors.green),
    TotalWidget(Assets.imagesRedplainK3, "11", "207.36X",Colors.red),
    TotalWidget(Assets.imagesGreenplainK3, "12", "7.36X",Colors.green),
    TotalWidget(Assets.imagesRedplainK3, "13", "27.36X",Colors.red),
    TotalWidget(Assets.imagesGreenplainK3, "14", "7.36X",Colors.green),
    TotalWidget(Assets.imagesRedplainK3, "15", "207.36X",Colors.red),
    TotalWidget(Assets.imagesGreenplainK3, "16", "207.36X",Colors.green),
    TotalWidget(Assets.imagesRedplainK3, "17", "207.36X",Colors.red),
    TotalWidget(Assets.imagesGreenplainK3, "18", "207.36X",Colors.green),
  ];

  List<Big> SizeTypelist = [
    Big("Big", "1.98",Colors.yellow),
    Big("Small", "1.98",Colors.blue),
    Big("Even", "1.98",Colors.green),
    Big("Odd", "1.98",Colors.red),
  ];

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 8.0,
          ),
          shrinkWrap: true,
          itemCount: totalitems.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Container(
                  height:height*0.08,
                  width: width*0.15,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(totalitems[index].image),fit: BoxFit.fill)
                  ),
                  child: Center(
                    child: textWidget(text: totalitems[index].title,
                        fontSize: width*0.05,
                        fontWeight: FontWeight.bold,
                        color: totalitems[index].color
                    ),
                  ),
                ),
                textWidget(text: totalitems[index].Subtitle,
                    fontSize: width*0.034,
                    color: Colors.grey)
              ],
            );
          },
        ),
        SizedBox(height: height*0.02,),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              SizeTypelist.length,
                  (index) =>
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      height: 40,
                      width: 70,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: SizeTypelist[index].color,
                          borderRadius: BorderRadius.circular(6)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          textWidget(text: SizeTypelist[index].type,fontSize: width*0.04,color: Colors.white),
                          textWidget(text: SizeTypelist[index].amount,fontSize: width*0.04,color: Colors.white),
                        ],
                      ),
                    ),
                  ),
            )
        ),
      ],
    );
  }

}
class Big{
  String type;
  String amount;
  final Color color;
  Big(this.type,this.amount,this.color);
}
class TotalWidget{
  String image;
  String title;
  String Subtitle;
  final Color color;
  TotalWidget(this.image,this.title,this.Subtitle,this.color);
}
class BetNumbers {

  String photo;
  final Color colorone;
  final Color colortwo;
  String number;
  BetNumbers(this.photo, this.colorone,this.colortwo,this.number);

}
