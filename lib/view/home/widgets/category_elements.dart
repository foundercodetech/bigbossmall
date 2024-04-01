import 'package:bbm/generated/assets.dart';
import 'package:bbm/main.dart';
import 'package:bbm/res/components/text_widget.dart';
import 'package:bbm/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:bbm/view/home/lottery/trx/trx_screen.dart';

class CategoryElement extends StatefulWidget {
  final int selectedCategoryIndex;
  const CategoryElement({super.key, required this.selectedCategoryIndex});

  @override
  State<CategoryElement> createState() => _CategoryElementState();
}

class _CategoryElementState extends State<CategoryElement> {
  @override
  Widget build(BuildContext context) {
    
    List<LotteryModel> lotteryList = [
      LotteryModel(
          titleText: 'Win Go',
          subTitleText: 'Guess Number',
          gameText: 'Green/Red/Violet to win',
          decorationImage: Assets.imagesDecorationFirst,
          decoImage: "",
          member: 'zbttdtnh',
          memberImage: Assets.person1,
          winAmount: '196.00',
          onTap: (){
            Navigator.pushNamed(context, RoutesName.winGoScreen);
        }
      ),
      // LotteryModel(
      //     titleText: 'K3 Lotre',
      //     subTitleText: 'Guess Number',
      //     gameText: 'Big/Small/Odd/Even',
      //     decorationImage: Assets.imagesDecorationSecond,
      //     decoImage: Assets.imagesDecoSecond,
      //     member: 'zeejnngs',
      //     memberImage: Assets.person2,
      //     winAmount: '188.16',
      //     onTap: (){
      //       // Utils.showImageComming(context);
      //       Navigator.push(context, MaterialPageRoute(builder: (context)=>const ScreenK3()));
      //
      //     }
      // ),
      // LotteryModel(
      //     titleText: '5D Lotre',
      //     subTitleText: 'Guess Number',
      //     gameText: 'Big/Small/Odd/Even',
      //     decorationImage: Assets.imagesDecorationFour,
      //     decoImage: Assets.imagesDecoThird,
      //     member: 'lxqldcer',
      //     memberImage: Assets.person3,
      //     winAmount: '194.00',
      //     onTap: (){
      //       Utils.showImageComming(context);
      //       // Navigator.push(context, MaterialPageRoute(builder: (context)=>const Screen5d()));
      //
      //
      //     }
      //     ),
      LotteryModel(
          titleText: 'Trx Win',
          subTitleText: 'Guess Number',
          gameText: 'Green/Red/Purple to win',
          decorationImage: Assets.imagesDecorationThirdPurple,
          decoImage: Assets.imagesDecoFour,
          member: 'zsifarlr',
          memberImage: Assets.person4,
          winAmount: '1960.00',
          onTap: (){
            // Utils.showImageComming(context);
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const TrxScreen()));
          }

      ),
    ];
    List<MiniGameModel> miniGameList = [
      MiniGameModel(
          titleText: 'AVIATOR',
          image: Assets.imagesAviatorFirst,onTap: (){
        Navigator.pushNamed(context, RoutesName.aviatorGame);
      }),
      // MiniGameModel(image: Assets.imagesMiniDice),
    ];
    return widget.selectedCategoryIndex == 0
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: lotteryList.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap:lotteryList[index].onTap,
                          child: Container(
                            width: width,
                            height: height * 0.17,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                              image: DecorationImage(
                                  image: AssetImage(
                                      lotteryList[index].decorationImage),
                                  fit: BoxFit.fill),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 15, 0, 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textWidget(
                                      text: lotteryList[index].titleText,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 30,
                                      ),
                                  SizedBox(height: height*0.02,),
                                  textWidget(
                                      text: lotteryList[index].subTitleText,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      ),
                                  textWidget(
                                      text: lotteryList[index].gameText,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height*0.02,),
                        // SizedBox(
                        //   height: 50,
                        //   width: width,
                        //   child: Padding(
                        //     padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        //     child: Row(
                        //       children: [
                        //         Image.asset(lotteryList[index].memberImage!,
                        //             width: 40),
                        //         const SizedBox(width: 20),
                        //         Row(
                        //           children: [
                        //             textWidget(
                        //               text: 'Member',
                        //               fontWeight: FontWeight.w600,
                        //               fontSize: 12,
                        //             ),
                        //             textWidget(
                        //               text: lotteryList[index]
                        //                   .member!
                        //                   .toUpperCase(),
                        //               fontWeight: FontWeight.w600,
                        //               fontSize: 12,
                        //             ),
                        //           ],
                        //         ),
                        //         const Spacer(),
                        //         Row(
                        //           children: [
                        //             textWidget(
                        //               text: 'winningAmount',
                        //               fontWeight: FontWeight.w600,
                        //               fontSize: 12,
                        //             ),
                        //             textWidget(
                        //               text: '₹${lotteryList[index].winAmount!}',
                        //               fontWeight: FontWeight.w600,
                        //               fontSize: 12,
                        //             ),
                        //           ],
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  Positioned(
                      top: 39,
                      right: 119,
                      child: InkWell(
                          onTap:lotteryList[index].onTap,
                          child: Image.asset(Assets.imagesClickhere,height: height*0.08)),),

                 Positioned(
                 top: 15,
                 right: 10,
                  child: Image.asset(lotteryList[index].decoImage==null?"":lotteryList[index].decoImage.toString(),height: 70)
                 )
                ],
              );
            })
        : widget.selectedCategoryIndex == 1?Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: miniGameList.length,
                physics: const NeverScrollableScrollPhysics(),
                // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisSpacing: 0,
                //     mainAxisSpacing: 0,
                //     crossAxisCount: 1),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: miniGameList[index].onTap,
                    child: Container(
                      height: height*0.15,
                      width: width,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                          image: DecorationImage(
                              image: AssetImage(miniGameList[index].image),fit: BoxFit.fill)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: textWidget(
                              text: miniGameList[index].titleText,
                              fontWeight: FontWeight.w600,
                              fontSize: width*0.05,
                            ),
                          ),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: Image.asset(Assets.imagesClickhere,height: height*0.08)),
                        ],
                      ) ,
                    ),
                  );
                }),
          ): Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(Assets.imagesCommingsoon,height: height*0.20,),
          );
  }
}

class LotteryModel {
  final String titleText;
  final String subTitleText;
  final String gameText;
  final String? member;
  final String? memberImage;
  final String decorationImage;
  final String? decoImage;
  final String? winAmount;
  final VoidCallback? onTap;
  LotteryModel(
      {required this.titleText,
      required this.subTitleText,
      required this.gameText,
      this.member,
      this.memberImage,
      required this.decorationImage,
      this.decoImage,
      this.winAmount,
      this.onTap});
}

class MiniGameModel {
  final String titleText;

  final String image;
  final VoidCallback? onTap;
  MiniGameModel({required this.titleText,required this.image,this.onTap});
}
