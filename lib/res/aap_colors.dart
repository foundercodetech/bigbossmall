import 'package:flutter/material.dart';

class AppColors {
  static const primaryTextColor = Color(0xFFFFFFFF);
  static const secondaryTextColor = Color(0xFFa6a6a6);
  static const gradientFirstColor = Color(0xFFde2325);
  static const gradientSecondColor = Color(0xFFff504a);
  static const dividerColor = Color(0xFFa6a6a6);
  static const iconColor = Color(0xFFa6a6a6);
  static const iconColorWHITE = Color(0xFFFFFFFF);
  static const iconSecondColor = Color(0xFFFFFFFF);
  static const primaryContColor = Color(0xFFFFFFFF);
  static const containerBgColor = Color(0xFFf95959);
  static const TextBlack = Colors.black;
  static const methodblue =Color(0xff598ff9);
  static const DepositButton =Color(0xff34be8a);
  static const ContainerBorderWhite = Color(0xFFFFFFFF);
  static const goldencolor = Color(0xffedc100);
  static const goldencolortwo = Color.fromARGB(255, 196, 147, 63);
  static const goldencolorthree = Color.fromARGB(255, 250, 229, 159);
  static const darkcolor = Color(0xFF3f3f3f);
  static const scaffolddark = Color(0xff292929);
  static const browntextprimary = Color(0xff8f5206);
  static Color circleBorderColor = Colors.blueGrey.withOpacity(0.08);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [gradientFirstColor, gradientSecondColor],
  );
  static LinearGradient goldenGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 250, 229, 159),
      Color.fromARGB(255, 196, 147, 63),
    ],
  );
  static LinearGradient transparentgradient = LinearGradient(
    colors: [
      Colors.transparent, Colors.transparent,
    ],
  );
  static LinearGradient ssbutton = LinearGradient(
    colors: [
      Colors.green, Colors.green,
    ],
  );
  static LinearGradient goldenGradientDir = LinearGradient(
    colors: [
      Color.fromARGB(255, 250, 229, 159),
      Color.fromARGB(255, 196, 147, 63),
    ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter
  );
  static LinearGradient goldenGradientDironecolor = LinearGradient(
      colors: [
        Color.fromARGB(255, 250, 229, 159),
        Color.fromARGB(255, 250, 229, 159),
      ],

  );


  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
  );
  static const LinearGradient primaryappbargrey = LinearGradient(
    colors: [Color(0xff727683), Color(0xffa5a6b1),],

  );


  static const LinearGradient secondaryappbar = LinearGradient(
    colors: [Color(0xFF3f3f3f), Color(0xFF3f3f3f)],
  );
  static const LinearGradient inactiveGradient = LinearGradient(
    colors: [Color(0xFFCFD1DF), Color(0xFFC8CADA)],
  );
  static const LinearGradient containerGradient = LinearGradient(
    colors: [Color(0xFFF83A39), Color(0xFFFF746B)],
  );static const LinearGradient containerTopToBottomGradient = LinearGradient(
    colors: [Color(0xFFF83A39), Color(0xFFFF746B)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter
  );
  static const LinearGradient containerGreenGradient = LinearGradient(
    colors: [Color(0xFF15CEA2 ), Color(0xFFB6FFE0)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter
  );
  static const LinearGradient containerBrownGradient = LinearGradient(
      colors: [Color(0xff8f5206), Color(0xff8f5206)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter
  );
  static const LinearGradient containerYellowGradient = LinearGradient(
    colors: [Color(0xFFF87700 ), Color(0xFFFFCE22)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter
  );
  static const LinearGradient containerBlueGradient = LinearGradient(
    colors: [Color(0xFF5CA6FF ), Color(0xFFA9E5FF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter
  );
  static const LinearGradient btnYellowGradient = LinearGradient(
    colors: [Color(0xFFf3bd14), Color(0xFFf3bd14)],
  );

  static const LinearGradient btnBlueGradient = LinearGradient(
    colors: [Color(0xFF6da7f4), Color(0xFF6da7f4)],
  );
}

///40ad72   green
///#b659fe  voilet
///fd565c   red

/// linear-gradient(90deg,#3faa70 0%,#47ba7c 100%);   green popyp gradient
/// linear-gradient(90deg,#b658fe 0%,#cd74ff 100%);   voilet popup gradient
/// linear-gradient(90deg,#fc5050 0%,#ff646c 100%);  red popup gradient

/// gradient(rgb(207, 209, 223) 0%, rgb(200, 202, 218) 100%); un focus button



// #f95959  pramotion top bg