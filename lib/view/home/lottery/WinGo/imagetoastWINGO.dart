import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bbm/generated/assets.dart';
import 'package:bbm/res/components/text_widget.dart';


class ImageToastWingo {
  ///loss
  static void showloss({
     String ?text,
     String ?subtext,
     String ?subtext1,
     String ?subtext2,
     String ?subtext3,
     String ?subtext4,
    required BuildContext context,

  }) {
    FToast fToast = FToast();

    List<Color> colors;
    if (subtext == '0') {
      colors = [
        const Color(0xFFfd565c),
        const Color(0xFFb659fe),
      ];
    } else if (subtext == '5') {
      colors = [
        const Color(0xFF40ad72),
        const Color(0xFFb659fe),
      ];
    }  else if (subtext == '10') {
      colors = [
        const Color(0xFF40ad72),
        const Color(0xFF40ad72),

      ];
    }  else if (subtext == '20') {
      colors = [

        const Color(0xFFb659fe),
        const Color(0xFFb659fe),
      ];
    }  else if (subtext == '30') {
      colors = [
        const Color(0xFFfd565c),
        const Color(0xFFfd565c),
      ];
    }  else if (subtext == '40') {
      colors = [
        const Color(0xFF40ad72),
        const Color(0xFF40ad72),

      ];
    }  else if (subtext == '50') {
      colors = [
        //blue
        const Color(0xFF6da7f4),
        const Color(0xFF6da7f4)
      ];
    } else {
      int number = int.parse(subtext.toString());
      colors = number.isOdd
          ? [
        const Color(0xFF40ad72),
        const Color(0xFF40ad72),
      ]
          : [
        const Color(0xFFfd565c),
        const Color(0xFFfd565c),
      ];
    }

    fToast.init(context);

    fToast.showToast(
      child:  Container(
        width:  400,
        height: 500,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: const DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(Assets.imagesLosstoast),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 136,),
            textWidget(
              text: "Sorry",
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
            const SizedBox(height: 40,),
            Row(
           children: [
             const SizedBox(width: 20,),
             textWidget(
               text: "Lottery result",
               fontSize: 12,
               color: Colors.black,
               fontWeight: FontWeight.bold,
             ),
             const SizedBox(width: 5,),
             Container(
               width: 80,
               height: 20,
               decoration: BoxDecoration(
                 borderRadius: const BorderRadius.all(Radius.circular(5)),
                     gradient: LinearGradient(
                 colors: colors,
                 stops: const [0.5, 0.5],
                 begin: Alignment.topCenter,
                 end: Alignment.bottomCenter,
                 tileMode: TileMode.mirror,
               ),
               ),
               child: Center(
                 child: textWidget(
                     text: subtext.toString() == '10' ? 'Green' :
                     subtext.toString() == '20' ? 'Voilet' :
                     subtext.toString() == '30' ? 'Red' :
                     subtext.toString() == '0' ? 'Red Voilet' :
                     subtext.toString() == '5' ? 'Green Voilet' :
                     (subtext.toString() == '1' || subtext.toString() == '3' || subtext.toString() == '7' || subtext.toString() == '9') ? 'green' :
                     'Red',
                   fontSize: 10,
                   color: Colors.white,
                   fontWeight: FontWeight.bold,

                 ),
               ),
             ),
             const SizedBox(width: 5,),
             Container(
               width: 20,
               height: 20,
               decoration: BoxDecoration(
                 shape: BoxShape.circle,
                 gradient: LinearGradient(
                   colors: colors,
                   stops: const [0.5, 0.5],
                   begin: Alignment.topCenter,
                   end: Alignment.bottomCenter,
                   tileMode: TileMode.mirror,
                 ),
               ),
             child:  Center(
                 child: textWidget(
                   text: subtext.toString(),
                   fontSize: 10,
                   color: Colors.white,
                   fontWeight: FontWeight.bold,
                 ),
               ),
             ),
             const SizedBox(width: 5,),

             Container(
               width: 40,
               height: 20,
               decoration: BoxDecoration(
                 borderRadius: const BorderRadius.all(Radius.circular(5)),
                 gradient: LinearGradient(
                   colors: colors,
                   stops: const [0.5, 0.5],
                   begin: Alignment.topCenter,
                   end: Alignment.bottomCenter,
                   tileMode: TileMode.mirror,
                 ),
               ),
             child:  Center(
                 child: textWidget(
                   text:   int.parse(subtext.toString()) < 5
                       ? 'Small'
                       : 'Big',
                   fontSize: 10,
                   color: Colors.white,
                   fontWeight: FontWeight.bold,
                 ),
               ),
             ),
           ],
         ),

            const SizedBox(height: 40),
            textWidget(
              text: "Lose",
              fontSize: 25,
              color: Colors.indigo.shade900,
              fontWeight: FontWeight.w900,
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textWidget(
                  text: "Period : ",
                  fontSize: 8,
                  color: Colors.black26,
                  fontWeight: FontWeight.bold,
                ),
                textWidget(
                    text: subtext4=="1"?"1 min":subtext3=="2"?"3 min":subtext3=="4"?"5 min":"10 min",
                  fontSize: 8,
                  color: Colors.black26,
                  fontWeight: FontWeight.w900,
                ),
                const SizedBox(width: 10,),
                textWidget(
                  text: subtext3.toString(),
                  fontSize: 8,
                  color: Colors.black26,
                  fontWeight: FontWeight.w900,
                ),
              ],
            ),
          ],
        ),
      ),
      gravity: ToastGravity.CENTER,
      toastDuration: const Duration(seconds: 3),
    );
  }

  ///win
  static void showwin({
     String ?text,
     String ?subtext,
     String ?subtext1,
     String ?subtext2,
     String ?subtext3,
     String ?subtext4,
    required BuildContext context,

  }) {
    FToast fToast = FToast();

    fToast.init(context);

    List<Color> colors;
    if (subtext == '0') {
      colors = [
        const Color(0xFFfd565c),
        const Color(0xFFb659fe),
      ];
    } else if (subtext == '5') {
      colors = [
        const Color(0xFF40ad72),
        const Color(0xFFb659fe),
      ];
    }  else if (subtext == '10') {
      colors = [
        const Color(0xFF40ad72),
        const Color(0xFF40ad72),

      ];
    }  else if (subtext == '20') {
      colors = [

        const Color(0xFFb659fe),
        const Color(0xFFb659fe),
      ];
    }  else if (subtext == '30') {
      colors = [
        const Color(0xFFfd565c),
        const Color(0xFFfd565c),
      ];
    }  else if (subtext == '40') {
      colors = [
        const Color(0xFF40ad72),
        const Color(0xFF40ad72),

      ];
    }  else if (subtext == '50') {
      colors = [
        //blue
        const Color(0xFF6da7f4),
        const Color(0xFF6da7f4)
      ];
    } else {
      int number = int.parse(subtext.toString());
      colors = number.isOdd
          ? [
        const Color(0xFF40ad72),
        const Color(0xFF40ad72),
      ]
          : [
        const Color(0xFFfd565c),
        const Color(0xFFfd565c),
      ];
    }

    fToast.showToast(
      child:  Container(
        width:  400,
        height: 500,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: const DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(Assets.imagesWinredpopup),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 160,),
            // textWidget(
            //   text: "Congratulations",
            //   fontSize: 25,
            //   color: Colors.white,
            //   fontWeight: FontWeight.w900,
            // ),
            const SizedBox(height: 55,),
            Row(
              children: [
                const SizedBox(width: 20,),
                textWidget(
                  text: "Lottery result",
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(width: 5,),
                Container(
                  width: 80,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    gradient: LinearGradient(
                      colors: colors,
                      stops: const [0.5, 0.5],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      tileMode: TileMode.mirror,
                    ),
                  ),
                  child: Center(
                    child: textWidget(
                      text: subtext.toString() == '10' ? 'Green' :
                      subtext.toString() == '20' ? 'Voilet' :
                      subtext.toString() == '30' ? 'Red' :
                      subtext.toString() == '0' ? 'Red Voilet' :
                      subtext.toString() == '5' ? 'Green Voilet' :
                      (subtext.toString() == '1' || subtext.toString() == '3' || subtext.toString() == '7' || subtext.toString() == '9') ? 'green' :
                      'Red',
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,

                    ),
                  ),
                ),
                const SizedBox(width: 5,),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: colors,
                      stops: const [0.5, 0.5],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      tileMode: TileMode.mirror,
                    ),
                  ),
                  child:  Center(
                    child: textWidget(
                      text: subtext.toString(),
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 5,),
                Container(
                  width: 40,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    gradient: LinearGradient(
                      colors: colors,
                      stops: const [0.5, 0.5],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      tileMode: TileMode.mirror,
                    ),
                  ),
                  child:  Center(
                    child: textWidget(
                      text:   int.parse(subtext.toString()) < 5
                          ? 'Small'
                          : 'Big',
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
            textWidget(
              text: "Bonus",
              fontSize: 14,
              color: Colors.deepOrange,
              fontWeight: FontWeight.w900,
            ),
            const SizedBox(height: 5),
            textWidget(
              text: "₹$subtext2",
              fontSize: 20,
              color: Colors.deepOrange,
              fontWeight: FontWeight.w900,
            ),
            const SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textWidget(
                  text: "Period : ",
                  fontSize: 8,
                  color: Colors.black26,
                  fontWeight: FontWeight.bold,
                ),
                textWidget(
                  text: subtext4=="1"?"1 min":subtext3=="2"?"3 min":subtext3=="4"?"5 min":"10 min",
                  fontSize: 8,
                  color: Colors.black26,
                  fontWeight: FontWeight.w900,
                ),
                const SizedBox(width: 10,),
                textWidget(
                  text: subtext3.toString(),
                  fontSize: 8,
                  color: Colors.black26,
                  fontWeight: FontWeight.w900,
                ),
              ],
            ),
          ],
        ),

      ),
      gravity: ToastGravity.CENTER,
      toastDuration: const Duration(seconds: 3),
    );
  }
}