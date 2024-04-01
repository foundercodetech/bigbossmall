import 'package:bbm/main.dart';
import 'package:flutter/material.dart';
import 'package:bbm/res/aap_colors.dart';
import 'package:bbm/res/components/text_widget.dart';

class Big{
  String type;
  String amount;
  Big(this.type,this.amount);
}
class BetNumbers {

  String photo;
  final Color colorone;
  final Color colortwo;
  String number;
  BetNumbers(this.photo, this.colorone,this.colortwo,this.number);

}
class Dummygrid5D extends StatefulWidget {
  const Dummygrid5D({super.key});

  @override
  State<Dummygrid5D> createState() => _Dummygrid5DState();
}

class _Dummygrid5DState extends State<Dummygrid5D> {


  List<int> listt = [0,1,2,3,4,5,6,7,8,9];
  List<int> list1 = [9,9,9,9,9,9,9,9,9,9];
  List<String> list2 = ["A","B","C","D","E"];

  List<Big> listthree = [
    Big("Big", "1.98"),
    Big("Small", "1.98"),
    Big("Even", "1.98"),
    Big("Odd", "1.98"),
  ];

  List<String> list3 = ["A","B","C","D","E","SUM"];

  int ?showalphabet = 0;

  @override
  Widget build(BuildContext context) {
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                list3.length,
                    (index) =>
                    InkWell(
                      onTap: (){
                        setState(() {
                          showalphabet=index;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          height: 40,
                          width: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: showalphabet==index?AppColors.goldencolortwo:Colors.grey,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))
                          ),
                          child: textWidget(text: list3[index],fontSize: width*0.04,
                              color: showalphabet==index?AppColors.browntextprimary:Colors.white
                          ),
                        ),
                      ),
                    ),
              )
          ),
          SizedBox(height: height*0.02,),
          Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    listthree.length,
                        (index) =>
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            height: 40,
                            width: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: AppColors.scaffolddark,
                                borderRadius: BorderRadius.circular(6)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                textWidget(text: listthree[index].type,fontSize: width*0.04,color: Colors.grey),
                                textWidget(text: listthree[index].amount,fontSize: width*0.04,color: Colors.grey),
                              ],
                            ),
                          ),
                        ),
                  )
              ),
              SizedBox(height: height*0.01,),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 15.0,
                ),
                shrinkWrap: true,
                itemCount: 10,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: height*0.05,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey)
                        ),
                        child: textWidget(text: listt[index].toString(),fontSize: width*0.045,color: Colors.white),
                      ),
                      textWidget(text: list1[index].toString(),fontSize: width*0.034,color: Colors.grey),
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
