import 'package:bbm/main.dart';
import 'package:bbm/res/aap_colors.dart';
import 'package:bbm/res/components/app_bar.dart';
import 'package:bbm/res/components/app_btn.dart';
import 'package:bbm/res/components/text_widget.dart';
import 'package:bbm/res/provider/feedback_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {

  TextEditingController feed = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final feedbackk = Provider.of<FeedbackProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
        leading: const AppBackBtn(),
          title: textWidget(
              text: ' Feedback',
              fontSize: 25,
              color: AppColors.primaryTextColor),
          gradient: AppColors.primaryappbargrey),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  maxLines: 15,
                  controller: feed,
                  decoration: InputDecoration(
                    hintText: 'Welcome to feedback, please give feedback-please describe the problem in detail when providing feedback, preferably attach a screenshot of the problem you encountered, we will immediately process your feedback!',
                    contentPadding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 0),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.white.withOpacity(0.5)),
                        borderRadius: const BorderRadius.all(Radius.circular(10))
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: AppColors.gradientFirstColor.withOpacity(0.5)),
                        borderRadius: const BorderRadius.all(Radius.circular(10))),
                    disabledBorder: OutlineInputBorder(
                        borderSide:  BorderSide(width: 1, color: Colors.white.withOpacity(0.5)),
                        borderRadius: const BorderRadius.all(Radius.circular(10))
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide:  BorderSide(width: 1, color: Colors.white.withOpacity(0.5)),
                        borderRadius:const BorderRadius.all(Radius.circular(10))),
                    filled: true,
                    fillColor:Colors.grey.withOpacity(0.2),
                  ),


                ),
              ),
            ),
            SizedBox(height: height*0.03,),
            // CustomTextField(
            //   controller: feed,
            //   hintText: 'Welcome to feedback, please give feedback-please describe the problem in detail when providing feedback, preferably attach a screenshot of the problem you encountered, we will immediately process your feedback!',
            //   fieldRadius: BorderRadius.circular(50),
            //   margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            // ),
            // SizedBox(height: height*0.10),
            InkWell(
              onTap: (){
                feedbackk.Feedbacksubmit(context, feed.text);
              },
              child: Container(
                height: height*0.055,
                width: width*0.35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  gradient: AppColors.goldenGradientDir
                ),
                child: Center(
                  child: textWidget(
                      text: 'Submit',
                      fontSize: 20,
                      color: AppColors.primaryTextColor),
                ),
              ),
            )

          ],
        ),
      ),
    );

  }

}

