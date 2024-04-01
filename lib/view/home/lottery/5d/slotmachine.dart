// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class SlotMachineController {
  const SlotMachineController({
    required this.start,
    required this.stop,
  });

  final Function({required int? hitRollItemIndex}) start;
  final Function({required int reelIndex}) stop;
}

class SlotMachine extends StatefulWidget {
  const SlotMachine({
    Key? key,
    required this.rollItems,
    this.multiplyNumberOfSlotItems = 2,
    this.shuffle = true,
    this.width = 285,
    this.height = 90,
    this.reelWidth = 50,
    this.reelHeight = 90,
    this.reelItemExtent = 65,
    this.reelSpacing = 7,
    required this.onCreated,
    required this.onFinished,
  }) : super(key: key);

  final List<RollItem> rollItems;
  final int multiplyNumberOfSlotItems;
  final bool shuffle;
  final double width;
  final double height;
  final double reelWidth;
  final double reelHeight;
  final double reelItemExtent;
  final double reelSpacing;
  final Function(SlotMachineController) onCreated;
  final Function(List<int> resultIndexes) onFinished;

  @override
  State<SlotMachine> createState() => _SlotMachineState();
}

class _SlotMachineState extends State<SlotMachine> {
  late SlotMachineController _slotMachineController;
  final Map<int, _ReelController> _reelControllers = {};
  final List<RollItem> _actualRollItems = [];
  List<int> _resultIndexes = [];
  int _stopCounter = 0;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.multiplyNumberOfSlotItems; i++) {
      _actualRollItems.addAll([...widget.rollItems]);
    }

    _slotMachineController = SlotMachineController(
      start: _start,
      stop: _stop,
    );

    widget.onCreated(_slotMachineController);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: widget.width,
          height: widget.height,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(5, (index) {
              return Padding(
                padding: EdgeInsets.only(right: index < 4 ? widget.reelSpacing : 0),
                child: _Reel(
                  reelWidth: widget.reelWidth,
                  reelHeight: widget.reelHeight,
                  itemExtent: widget.reelItemExtent,
                  rollItems: _actualRollItems,
                  shuffle: widget.shuffle,
                  onCreated: (lc) => _reelControllers[index] = lc,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  _start({required int? hitRollItemIndex}) {
    _stopCounter = 0;
    _resultIndexes = [];

    final win = hitRollItemIndex != null;
    if (win) {
      final index = hitRollItemIndex;
      if (index == null) return;
      _resultIndexes.addAll([index, index, index, index, index]);
    } else {
      _resultIndexes = _randomResultIndexes(widget.rollItems.length);
    }
    _reelControllers.forEach((key, _) => _reelControllers[key]!.start());
  }

  _stop({required int reelIndex}) {
    assert(reelIndex >= 0 && reelIndex <= 4);

    final lc = _reelControllers[reelIndex];
    if (lc == null) return;

    lc.stop(to: _resultIndexes[reelIndex]);

    _stopCounter++;
    if (_stopCounter == 5) {
      Future.delayed(const Duration(milliseconds: 500), () {
        widget.onFinished(_resultIndexes);
      });
    }
  }

  List<int> _randomResultIndexes(int length) {
    bool ok = false;
    List<int> indexes = [];
    while (!ok) {
      final arr = [
        Random().nextInt(length),
        Random().nextInt(length),
        Random().nextInt(length),
        Random().nextInt(length),
        Random().nextInt(length)
      ];
      if (arr.toSet().length == arr.length) {
        indexes = arr;
        ok = true;
      }
    }
    return indexes;
  }
}

class _ReelController {
  const _ReelController({
    required this.start,
    required this.stop,
  });

  final Function start;
  final Function({required int to}) stop;
}

class _Reel extends StatefulWidget {
  const _Reel({
    Key? key,
    required this.rollItems,
    required this.reelWidth,
    required this.reelHeight,
    required this.itemExtent,
    this.shuffle = true,
    required this.onCreated,
  }) : super(key: key);

  final List<RollItem> rollItems;
  final double reelWidth;
  final double reelHeight;
  final double itemExtent;
  final bool shuffle;
  final Function(_ReelController) onCreated;

  @override
  State<_Reel> createState() => __ReelState();
}

class __ReelState extends State<_Reel> {
  late Timer timer;
  late _ReelController _laneController;
  final _scrollController = FixedExtentScrollController(initialItem: 0);
  int counter = 0;
  List<RollItem> _actualRollItems = [];

  @override
  void initState() {
    super.initState();
    _actualRollItems = widget.rollItems;
    if (widget.shuffle) _actualRollItems.shuffle();

    _laneController = _ReelController(
      start: _start,
      stop: _stop,
    );
    widget.onCreated(_laneController);
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.reelWidth,
      height: widget.reelHeight,
      child: ListWheelScrollView.useDelegate(
        controller: _scrollController,
        itemExtent: widget.itemExtent,
        physics: const FixedExtentScrollPhysics(),
        childDelegate: ListWheelChildLoopingListDelegate(
          children: _actualRollItems.map<Widget>((item) {
            return SizedBox(
              width: widget.reelWidth,
              height: widget.itemExtent,
              child: item.child,
            );
          }).toList(),
        ),
      ),
    );
  }

  _start() {
    counter = 0;
    timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      _scrollController.animateToItem(
        counter,
        duration: const Duration(milliseconds: 50),
        curve: Curves.linear,
      );
      counter--;
    });
  }

  _stop({required int to}) {
    timer.cancel();
    final hitItemIndex =
    _actualRollItems.indexWhere((item) => item.index == to);

    final mod = (-counter) % _actualRollItems.length - 1;
    final addCount = (_actualRollItems.length - mod) +
        (_actualRollItems.length - hitItemIndex) -
        1;

    _scrollController.animateToItem(
      counter - addCount,
      duration: const Duration(milliseconds: 750),
      curve: Curves.decelerate,
    );
  }
}

class RollItem {
  const RollItem({
    required this.index,
    required this.child,
  });

  final int index;
  final Widget child;
}