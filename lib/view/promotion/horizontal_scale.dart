import 'package:bbm/generated/assets.dart';
import 'package:bbm/main.dart';
import 'package:bbm/res/aap_colors.dart';
import 'package:flutter/material.dart';


class HorizontalScale extends StatefulWidget {
  final int count;
  const HorizontalScale({super.key, required this.count});

  @override
  HorizontalScaleState createState() => HorizontalScaleState();
}

class ScaleData {
  final String value;
  final String indicatorValue;

  ScaleData({required this.value, required this.indicatorValue});
}

class HorizontalScaleState extends State<HorizontalScale> {
  static const double containerHeight = 25.0;
  static const double containerWidth = 78.5;
  static const EdgeInsets containerMargin = EdgeInsets.all(0);

  List<ScaleData> scaleData = [
    ScaleData(value: '500', indicatorValue: '10'),
    ScaleData(value: '1500', indicatorValue: '25'),
    ScaleData(value: '5000', indicatorValue: '50'),
    ScaleData(value: '10000', indicatorValue: '100'),
  ];

  int rowFilledPosition = 0;

  updateScale(){
    setState(() {
      if(widget.count<int.parse(scaleData[0].indicatorValue)){
        rowFilledPosition=-1;
      }else if(widget.count<int.parse(scaleData[1].indicatorValue)){
        rowFilledPosition=0;
      }else if(widget.count<int.parse(scaleData[2].indicatorValue)){
        rowFilledPosition=1;
      }else if(widget.count<int.parse(scaleData[3].indicatorValue)){
        rowFilledPosition=2;
      }else{
        rowFilledPosition=3;
      }
    });

  }
  @override
  void initState() {
    updateScale();
    // TODO: implement initState
    super.initState();
  }

  bool isContainerFilled = false;

  int filledPositionIndex = 0;

  ScaleData currentData = ScaleData(value: '0', indicatorValue: '0');

  Widget _buildValueIndicator(int index) {
    if (index >= scaleData.length) {
      return Container();
    }

    ScaleData data = scaleData[index];

    return Positioned(
      top: Constants.valueIndicatorTop,
      left: Constants.valueIndicatorLeft + (index * Constants.valueIndicatorSpacing),
      child: _buildValueIndicatorWidget(data, index),
    );
  }

  Widget _buildValueIndicatorWidget(ScaleData data, int index) {
    bool isCurrentValue = index <= filledPositionIndex;

    return Column(
      children: [
        Text(
          data.value,
          style: TextStyle(
            fontWeight: isCurrentValue ? FontWeight.bold : FontWeight.normal,
            color: isCurrentValue ?Colors.yellow:Colors.white,
            fontSize: 15,
          ),
        ),
        Row(
          children: [
            Container(
              height: containerHeight,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isCurrentValue ? Colors.yellow : Colors.white,
                ),
              ),
            ),

          ],
        ),
        Text(
          data.indicatorValue,
          style: TextStyle(
            fontWeight: isCurrentValue ? FontWeight.bold : FontWeight.normal,
            color: isCurrentValue ?Colors.yellow:Colors.white,
            fontSize: 15,
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 3, 10, 0),
        child: Container(
          width: width,
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [

                    AppColors.gradientFirstColor,
                    AppColors.gradientSecondColor,
                  ]
              ),
              borderRadius: BorderRadius.circular(15)
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(color: Colors.white,Assets.iconsTotalBal,height: 30,),
                      const Text('  Refer and Earn',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w700 ),),
                      const SizedBox(width: 50,),
                      const Text('\nBonus ',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w700 ),),
                    ],
                  ),
                  const SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.do_not_disturb_on_total_silence,
                        color: isContainerFilled ? Colors.green : Colors.white,
                      ),
                      Row(
                        children: List.generate(
                          4,
                              (index) =>
                              Container(
                                margin: containerMargin,
                                width: containerWidth,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                    rowFilledPosition >= index
                                        ? Colors.yellow
                                        : Colors.white,
                                  ),

                                ),

                              ),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: height*0.01,),
                  const Text('User  ',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w700 ),),

                ],
              ),
              Positioned(
                top:Constants.arrowTop,
                right:Constants.arrowRight,
                child: Icon(Icons.arrow_forward_ios_sharp,
                  color: isContainerFilled ? Colors.green : Colors.white,
                ),
              ),
              for (int i = 0; i < scaleData.length; i++) _buildValueIndicator(i),
            ],
          ),
        ),
      );

  }
}


class Constants {
  static const double borderWidth = 1.5;
  static const double containerHeight = 155.0;
  static const double containerWidth = 380.0;
  static const double arrowTop =60;
  static const double arrowRight =14.5 ;

  static const double valueIndicatorTop = 45.5;
  static const double valueIndicatorLeft = 80.0;
  static const double valueIndicatorSpacing = 65.0;
}