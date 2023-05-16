import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SeatFinderProvider extends ChangeNotifier {
  final TextEditingController findController = TextEditingController();
  final ItemScrollController itemController = ItemScrollController();

  int? _foundedSeatIndex;

  int? get foundedSeatIndex => _foundedSeatIndex;

  set foundedSeatIndex(int? index) {
    _foundedSeatIndex = index;
    notifyListeners();
  }

  bool _areSeatLabelsShown = false;

  bool get areSeatLabelsShown => _areSeatLabelsShown;

  set areSeatLabelsShown(bool flag) {
    _areSeatLabelsShown = flag;
    notifyListeners();
  }

  bool _isLightMode = true;

  bool get isLightMode => _isLightMode;

  set isLightMode(bool flag) {
    _isLightMode = flag;
    notifyListeners();
  }

  void animateTo() {
    foundedSeatIndex = int.parse(findController.text);
    itemController.scrollTo(
      index: (foundedSeatIndex! - 1) ~/ 8,
      duration: const Duration(milliseconds: 350),
    );
  }

  int getSeatIndex({
    required int blockIndex,
    required int rowIndex,
    required int seatIndex,
  }) =>
      8 * blockIndex + 3 * rowIndex + seatIndex + 1;

  int getSideSeatIndex({
    required int blockIndex,
    required int rowIndex,
  }) =>
      8 * blockIndex + rowIndex + 7;

  final List<String> berths = [
    'Lower',
    'Middle',
    'Upper',
    'Lower',
    'Middle',
    'Upper',
    'Side Lower',
    'Side Upper',
  ];

  String getBerthTitle(int index) => berths[index % 8];
}
