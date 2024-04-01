import 'dart:convert';
import 'package:bbm/generated/assets.dart';
import 'package:bbm/main.dart';
import 'package:bbm/model/Mlm_Plan_model.dart';
import 'package:bbm/res/aap_colors.dart';
import 'package:bbm/res/api_urls.dart';
import 'package:bbm/res/components/app_bar.dart';
import 'package:bbm/res/components/app_btn.dart';
import 'package:bbm/res/components/text_widget.dart';
import 'package:bbm/res/provider/user_view_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LevelPlan extends StatefulWidget {
  const LevelPlan({super.key});

  @override
  State<LevelPlan> createState() => _LevelPlanState();
}

class _LevelPlanState extends State<LevelPlan> {



  @override
  void initState() {
    mLMPlan();
    super.initState();
  }


  int ?responseStatuscode;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
          leading: const AppBackBtn(),
          title: textWidget(
              text: 'Level Plan',
              fontSize: 25,
              color: AppColors.primaryTextColor),
          gradient: AppColors.primaryappbargrey),
      body: ListView(
        children: [
          SizedBox(height: height*0.02,),
          responseStatuscode== 400 ?
          const Notfounddata(): planItems.isEmpty? const Center(child: CircularProgressIndicator()):
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemCount: planItems.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation:  3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      gradient: AppColors.goldenGradientDir,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        textWidget(
                            text: planItems[index].name.toString(),
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                        textWidget(
                            text: "${planItems[index].commission}%",
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.bold

                        ),
                        textWidget(
                            text: "Commision",
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.bold

                        ),

                      ],
                    )

                ),
              );
            },
          ),
        ],
      ),
    );
  }
  UserViewProvider userProvider = UserViewProvider();


  ///mlm plan
  List<MlmPlanModel> planItems = [];

  Future<void> mLMPlan() async {

    final response = await http.get(Uri.parse(ApiUrl.planMlm));
    if (kDebugMode) {
      print(ApiUrl.planMlm);
      print('planMlm');
    }


    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {

        planItems = responseData.map((item) => MlmPlanModel.fromJson(item)).toList();
        // selectedIndex = items.isNotEmpty ? 0:-1; //
      });

    }
    else if(response.statusCode==400){
      if (kDebugMode) {
        print('Data not found');
      }
    }
    else {
      setState(() {
        planItems = [];
      });
      throw Exception('Failed to load data');
    }
  }
}

class Notfounddata extends StatelessWidget {
  const Notfounddata({super.key});

  @override
  Widget build(BuildContext context){
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: const AssetImage(Assets.imagesNoDataAvailable),
          height: heights / 3,
          width: widths / 2,
        ),
        SizedBox(height: heights*0.07),
        const Text("Data not found",)
      ],
    );
  }

}

