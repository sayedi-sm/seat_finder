// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SeatFinderScreen extends StatefulWidget {
  const SeatFinderScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SeatFinderScreen> createState() => _SeatFinderScreenState();
}

class _SeatFinderScreenState extends State<SeatFinderScreen> {
  late final TextEditingController findController = TextEditingController();
  late final ItemScrollController itemController = ItemScrollController();

  @override
  void dispose() {
    findController.dispose();
    super.dispose();
  }

  int? findIndex;

  void animateTo() {
    setState(() {
      findIndex = int.parse(findController.text);
    });
    findController.clear();
    itemController.scrollTo(
      index: (findIndex! - 1) ~/ 8,
      duration: const Duration(milliseconds: 350),
      curve: Curves.elasticInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          'Seat Finder',
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
        child: Column(
          children: [
            Stack(
              children: [
                TextField(
                  controller: findController,
                  decoration: InputDecoration(
                    hintText: 'Enter seat number...',
                    hintStyle:
                        TextStyle(color: Theme.of(context).primaryColorLight),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        width: 3,
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        width: 3,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  cursorColor: Theme.of(context).primaryColor,
                  cursorWidth: 3,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                  onChanged: (value) {
                    if (value.isEmpty) {
                      findIndex = null;
                    }
                    setState(() {});
                  },
                  onEditingComplete: findController.text.isEmpty ||
                          findController.text.contains('.') ||
                          int.parse(findController.text) > 72
                      ? null
                      : animateTo,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  bottom: 0,
                  child: ElevatedButton(
                    onPressed: findController.text.isEmpty ||
                            findController.text.contains('.') ||
                            int.parse(findController.text) > 72
                        ? null
                        : animateTo,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      disabledBackgroundColor:
                          Theme.of(context).colorScheme.secondaryContainer,
                      disabledForegroundColor:
                          Theme.of(context).colorScheme.onSecondaryContainer,
                      padding: const EdgeInsets.symmetric(horizontal: 36),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Find'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ScrollablePositionedList.separated(
                itemScrollController: itemController,
                itemBuilder: (context, blockIndex) {
                  return SizedBox(
                    height: 175,
                    child: Row(
                      children: [
                        Column(
                          children: List.generate(
                            3,
                            (rowIndex) => rowIndex == 1
                                ? const Spacer()
                                : Wrap(
                                    spacing: 4,
                                    children: List.generate(
                                      3,
                                      (seatIndex) {
                                        return Seat(
                                          index: getIndex(
                                            blockIndex: blockIndex,
                                            rowIndex: rowIndex == 2 ? 1 : 0,
                                            seatIndex: seatIndex,
                                          ),
                                          foundSeatIndex: findIndex,
                                        );
                                      },
                                    ),
                                  ),
                          ),
                        ),
                        const Spacer(),
                        Column(
                          children: List.generate(
                            3,
                            (rowIndex) => rowIndex == 1
                                ? const Spacer()
                                : Seat(
                                    index: getSideIndex(
                                      blockIndex: blockIndex,
                                      rowIndex: rowIndex == 2 ? 1 : 0,
                                    ),
                                    foundSeatIndex: findIndex,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 4),
                itemCount: 72 ~/ 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Seat extends StatelessWidget {
  const Seat({
    this.index = 1,
    this.foundSeatIndex,
    super.key,
  });

  final int index;
  final int? foundSeatIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: foundSeatIndex == index
          ? Theme.of(context).primaryColor
          : Theme.of(context).primaryColorLight,
      height: 70,
      width: 70,
      child: Center(
        child: Text(
          index.toString(),
          style: TextStyle(
            color: foundSeatIndex == index
                ? Colors.white
                : Theme.of(context).primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

int getIndex({
  required int blockIndex,
  required int rowIndex,
  required int seatIndex,
}) =>
    8 * blockIndex + 3 * rowIndex + seatIndex + 1;

int getSideIndex({
  required int blockIndex,
  required int rowIndex,
}) =>
    8 * blockIndex + rowIndex + 7;
/*
ListView.separated(
        itemBuilder: (context, outerIndex) {
          return SizedBox(
            height: 200,
            child: Row(
              children: [
                Column(
                  children: [
                    Wrap(
                      spacing: 4,
                      children: List.generate(
                        3,
                        (index) => const MyContainer(),
                      ),
                    ),
                    const Spacer(),
                    Wrap(
                      spacing: 4,
                      children: List.generate(
                        3,
                        (index) => const MyContainer(),
                      ),
                    )
                  ],
                ),
                const Spacer(),
                const Column(
                  children: [
                    MyContainer(),
                    Spacer(),
                    MyContainer(),
                  ],
                ),
              ],
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 4),
        itemCount: 72 ~/ 8,
      )
*/