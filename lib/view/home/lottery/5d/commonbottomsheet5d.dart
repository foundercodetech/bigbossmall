// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_types_as_parameter_names, use_build_context_synchronously
import 'package:bbm/main.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bbm/generated/assets.dart';
import 'package:bbm/res/aap_colors.dart';
import 'package:bbm/res/components/text_widget.dart';
import 'package:bbm/res/helper/api_helper.dart';
import 'package:bbm/res/provider/wallet_provider.dart';
import 'package:bbm/utils/utils.dart';
import 'package:bbm/view/home/lottery/WinGo/win_go_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Big{
  String type;
  String amount;
  Big(this.type,this.amount);
}

class CommonBottomSheet5D extends StatefulWidget {
  final int gameid;
  // final String alphabetType;
  // final String sizeType;
  // final String numbertype;
  const CommonBottomSheet5D({
    super.key,
    required this.gameid,
    // required this.alphabetType,
    // required this.sizeType,
    // required this.numbertype,

  });

  @override
  State<CommonBottomSheet5D> createState() => _CommonBottomSheet5DState();
}



class _CommonBottomSheet5DState extends State<CommonBottomSheet5D> {


  @override
  void initState() {
    walletfetch();
    amount.text=selectedIndex.toString();
    // TODO: implement initState
    super.initState();
  }
  int value = 1;
  int selectedAmount = 0;

  void increment() {
    setState(() {
      value = value + 1;
      deductAmount();
    });
  }

  void decrement() {
    setState(() {
      if (value > 0) {
        value = value - 1;
        deductAmount();
      }
    });
  }

  void selectam(int amount) {
    setState(() {
      selectedAmount = amount;
      value = 1;
    });
    deductAmount();
  }

  // void deductAmount() {
  //   if (wallbal! >= selectedAmount * value) {
  //     walletApi = wallbal;
  //   }
  //   int amountToDeduct = selectedAmount * value;
  //   if (walletApi! >= amountToDeduct) {
  //     setState(() {
  //       amount.text = (selectedAmount * value).toString();
  //       walletApi = (walletApi! - amountToDeduct).toInt();
  //     });
  //   } else {
  //     Utils.flushBarErrorMessage('Insufficient funds', context, Colors.white);
  //   }
  // }
  List<int> multipliers = [1, 5, 10, 20, 50, 100];
  int selectedMultiplier = 1; // Default multipli

  void updateMultiplier(int multiplier) {
    setState(() {
      selectedMultiplier = multiplier;
      deductAmount();
    });
  }

  void deductAmount() {
    if (wallbal! >= selectedAmount * selectedMultiplier) {
      walletApi = wallbal;
    }
    int amountToDeduct = selectedAmount * selectedMultiplier;
    if (walletApi! >= amountToDeduct) {
      setState(() {
        amount.text = amountToDeduct.toString();
        walletApi = (walletApi! - amountToDeduct).toInt();
      });
    } else {
      Utils.flushBarErrorMessage('Insufficient funds', context, Colors.white);
    }
  }


  List<int> list = [
    1,
    10,
    100,
    1000,

  ];
  int? walletApi;
  int? wallbal;

  int selectedIndex = 1;

  TextEditingController amount = TextEditingController();

  List<Winlist> listwe = [
    Winlist(1,"Win Go", "1 Min",60),
    Winlist(2,"Win Go", "3 Min",180),
    Winlist(3,"Win Go", "5 Min",300),
    Winlist(4,"Win Go", "10 Min",600),
  ];
  List<String> list3 = ["A","B","C","D","E","SUM"];
  List<int> listt = [0,1,2,3,4,5,6,7,8,9];
  List<Big> listthree = [
    Big("Big", "1.98"),
    Big("Small", "1.98"),
    Big("Even", "1.98"),
    Big("Odd", "1.98"),
  ];
  List<int> list1 = [9,9,9,9,9,9,9,9,9,9];

  List<Color> color = [
    Colors.orange,
    Colors.blue,
    Colors.green,
    Colors.red,
  ];


  int ? showalphabet = 0;
  int ? showtype = -1;
  int ? fillalphabet = 0;

  String gametitle='Wingo';
  String subtitle='1 Min';

  Set<int> selectedContainer = {};


  @override
  Widget build(BuildContext context) {

    final walletdetails = Provider.of<WalletProvider>(context).walletlist;

    walletApi = (walletdetails!.wallet == null ? 0 : double.parse(walletdetails.wallet.toString())).toInt();
    wallbal = (walletdetails.wallet == null ? 0 : double.parse(walletdetails.wallet.toString())).toInt();



    return Container(
      decoration: BoxDecoration(
          gradient: AppColors.secondaryappbar,
          borderRadius: BorderRadius.circular(27)
      ),
      width: width,
      height: height*0.70,
      child: Column(
        children: [
          SizedBox(height: height*0.01),
          // Text(
          //   widget.gameid==1?'5D Lotre 1 Min':widget.gameid==2?'5D Lotre 3 Min':widget.gameid==3?'5D Lotre 5 Min':"5D Lotre 10 Min",
          //   style: TextStyle(
          //       fontSize: 20,
          //       fontWeight: FontWeight.w600,
          //       color: AppColors.browntextprimary)
          // ),
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
                        if (kDebugMode) {
                          print(showalphabet);
                          print("showalphabet");
                        }
                      },

                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          height: 40,
                          width: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: showalphabet==index?AppColors.goldencolortwo:Colors.grey,
                              borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))
                          ),
                          child: textWidget(text: list3[index].toString(),fontSize: width*0.04,
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
                        InkWell(
                          onTap: (){
                            setState(() {
                              showtype=index;
                            });
                            if (kDebugMode) {
                              print(showtype);
                              print("showtype");
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              height: 40,
                              width: 70,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: showtype == index ? color[index]: AppColors.scaffolddark,
                                  borderRadius: BorderRadius.circular(6)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  textWidget(text: listthree[index].type,fontSize: width*0.04,color: Colors.white),
                                  textWidget(text: listthree[index].amount,fontSize: width*0.04,color: Colors.white),
                                ],
                              ),
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
                  bool isSelected = selectedContainer.contains(index);

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: (){
                          setState(() {
                            if (selectedContainer.contains(index)) {
                              selectedContainer.remove(index);
                            } else {
                              selectedContainer.add(index);
                            }
                          });
                          if (kDebugMode) {
                            print(isSelected);
                            print("isSelected");
                          }

                        },
                        child: Container(
                          height: height*0.05,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: isSelected ? AppColors.goldencolortwo : Colors.grey,
                              shape: BoxShape.circle,

                          ),
                          child: textWidget(text: listt[index].toString(),
                              fontSize: width*0.045,
                              color:  isSelected ? AppColors.browntextprimary : Colors.white,
                          ),
                        ),
                      ),
                      textWidget(text: list1[index].toString(),fontSize: width*0.034,color: Colors.grey),
                    ],
                  );
                },
              ),
            ],
          ),
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Balance",
                          style: TextStyle(fontSize: 18,color: Colors.white),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: List.generate(4, (index) {
                        //     final balanceList = "10${"0" * index}";
                        //     return InkWell(
                        //       onTap: () {
                        //         setState(() {
                        //           balance = int.parse(balanceList);
                        //           totalAmount();
                        //         });
                        //       },
                        //       child: Container(
                        //         margin: const EdgeInsets.only(right: 5),
                        //         padding: const EdgeInsets.all(5),
                        //         color: balance - 1 == index && balance == 1
                        //             ? widget.colors!.first
                        //             : balanceList == balance.toString()
                        //             ? widget.colors!.first
                        //             : Colors.grey.shade50,
                        //         child: Text(balanceList,
                        //             style: TextStyle(
                        //                 fontSize: 18,
                        //                 color: balance - 1 == index &&
                        //                     balance == 1
                        //                     ? Colors.white
                        //                     : balanceList == balance.toString()
                        //                     ? Colors.white
                        //                     : Colors.black)),
                        //       ),
                        //     );
                        //   }),
                        // ),
                        SizedBox(
                          width: 170,
                          height: 30,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: list.length,
                              itemBuilder: (BuildContext, int index){
                                return InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedIndex=list[index];
                                      });
                                      selectam(selectedIndex);
                                    },
                                    child: Container(
                                        margin: const EdgeInsets.only(right: 5),
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(color:selectedIndex==list[index]?const Color(0xffd9ac4f):Colors.grey,
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        // color:selectedIndex==list[index]?widget.colors!.first:Colors.white,
                                        child: Text(list[index].toString(),
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color:Colors.black
                                            // color: list[index] - 1 == index &&
                                            //     list[index] == 1
                                            //     ? Colors.white
                                            //     : list[index] == list[index]
                                            //     ? Colors.white
                                            //     : Colors.black)),
                                          ),
                                        )));
                              }),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Quantity",
                          style: TextStyle(fontSize: 18,color: AppColors.primaryTextColor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 18),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: decrement,
                                  child: Image.asset(Assets.imagesReduce,height: 30,),
                                ),
                                Container(
                                    height: 35,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(4),
                                    margin: const EdgeInsets.all(5),
                                    width: 90,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff6f7381),
                                      borderRadius: BorderRadius.circular(14),
                                      // border: Border.all(
                                      //     width: 1, color: Colors.grey.shade500),
                                    ),
                                    child: TextField(
                                      controller: amount,
                                      // readOnly: true,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none
                                      ),
                                      style: const TextStyle(fontSize: 18, color: Colors.white),
                                    )
                                ),
                                InkWell(
                                  onTap: increment,
                                  child: Image.asset(Assets.imagesAdd,height: 30,),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),


          ///X1 X5 ....
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: List.generate(
          //       betXValue.length,
          //           (index) => InkWell(
          //         onTap: () {
          //           setState(() {
          //             betX = int.parse(betXValue[index]);
          //             quantity = betX;
          //             totalAmount();
          //           });
          //         },
          //         child: Container(
          //           margin: const EdgeInsets.only(right: 5),
          //           padding: const EdgeInsets.all(5),
          //           color: betX.toString() == betXValue[index]
          //               ? widget.colors!.first
          //               : Colors.grey.shade50,
          //           child: Text("X${betXValue[index]}",
          //               style: TextStyle(
          //                   fontSize: 18,
          //                   color: betX.toString() == betXValue[index]
          //                       ? Colors.white
          //                       : Colors.black)),
          //         ),
          //       )),
          // ),
          SizedBox(height: height*0.01,),
          SizedBox(
            height: 44,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: multipliers.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedMultiplier = multipliers[index];
                      });
                      updateMultiplier(selectedMultiplier);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedMultiplier == multipliers[index]
                          ? AppColors.goldencolortwo:Colors.white,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),),
                    child: Text('X${multipliers[index]}',style: const TextStyle(color: Colors.black),),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Icon(
                  Icons.check_circle,
                  color:  Color(0xffd9ac4f)
              ),
              Text(" I agree",style: TextStyle(color: Colors.white),),
              SizedBox(
                width: 20,
              ),
              Text(
                "(Pre sale rule)",
                style: TextStyle( color: Color(0xffd9ac4f)),
              )
            ],
          ),
          SizedBox(height: height*0.01),
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.black.withOpacity(0.7),
                  width: width / 3,
                  height: 45,
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  // Betprovider.Colorbet(context,amount.text,widget.predictionType,widget.gameid );

                },
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    // color: widget.colors!.first,
                    decoration: BoxDecoration(gradient: AppColors.goldenGradientDir),
                    width: width / 1.5,
                    height: 45,
                    child: Text(
                      "Total amount ${amount.text}",
                      style: const TextStyle(color: AppColors.browntextprimary, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
  BaseApiHelper baseApiHelper = BaseApiHelper();

  Future<void> walletfetch() async {
    try {
      if (kDebugMode) {
        print("qwerfghj");
      }
      final walletData = await baseApiHelper.fetchWalletData();
      if (kDebugMode) {
        print(walletData);
        print("wallet_data");
      }
      Provider.of<WalletProvider>(context, listen: false).setWalletList(walletData!);
    } catch (error) {
      // Handle error here
      if (kDebugMode) {
        print("hiiii $error");
      }
    }
  }

}


