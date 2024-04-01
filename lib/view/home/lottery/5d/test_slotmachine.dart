// ignore_for_file: library_private_types_in_public_api

import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bbm/generated/assets.dart';
import 'package:bbm/res/aap_colors.dart';
import 'package:bbm/view/home/lottery/5d/slotmachine.dart';


class ZTESTPAGESSS extends StatefulWidget {
  const ZTESTPAGESSS({super.key});

  @override
  _ZTESTPAGESSSState createState() => _ZTESTPAGESSSState();
}

class _ZTESTPAGESSSState extends State<ZTESTPAGESSS> {
  late SlotMachineController _controller;

  @override
  void initState() {
    super.initState();
  }
  void onButtonTap() {
    for (int i = 0; i < 5; i++) {
      _controller.stop(reelIndex: i);
    }
  }
  void onStart() {
    final index = Random().nextInt(20);
    _controller.start(hitRollItemIndex: index < 5 ? index : null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.secondaryappbar),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 10,color: Color(0xffc4933f))
            ),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 4,color: Colors.brown)
              ),
              child: SlotMachine(
                rollItems: [
                  RollItem(index: 0, child: Image.asset(Assets.images1)),
                  RollItem(index: 1, child: Image.asset(Assets.images2)),
                  RollItem(index: 2, child: Image.asset(Assets.images4)),
                  RollItem(index: 3, child: Image.asset(Assets.images3)),
                  RollItem(index: 4, child: Image.asset(Assets.images6)),
                  RollItem(index: 5, child: Image.asset(Assets.images7)),
                ],
                onCreated: (controller) {
                  _controller = controller;
                },
                onFinished: (resultIndexes) {
                  if (kDebugMode) {
                    print('Result: $resultIndexes');
                  }
                },
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 72,
                  height: 44,
                  child: TextButton(
                    onPressed: onButtonTap,
                    child: const Text('STOP'),
                  ),
                ),
                TextButton(
                  child: const Text('START'),
                  onPressed: () => onStart(),
                ),
              ],
            ),
          ),




        ],
      ),
    );
  }
}