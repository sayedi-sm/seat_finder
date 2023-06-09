import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../models/models.dart';
import '../providers/providers.dart';
import 'widgets.dart';

class SeatsListView extends StatelessWidget {
  const SeatsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final SeatFinderProvider provider =
        Provider.of<SeatFinderProvider>(context);

    return ScrollablePositionedList.separated(
      itemScrollController: provider.itemController,
      padding: const EdgeInsets.all(10),
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
                      : CustomPaint(
                          painter: SeatDecorator(
                            color: Theme.of(context).colorScheme.primary,
                            isTop: rowIndex == 0,
                          ),
                          child: Wrap(
                            spacing: 1,
                            children: List.generate(
                              3,
                              (seatIndex) {
                                return Seat(
                                  index: provider.getSeatIndex(
                                    blockIndex: blockIndex,
                                    rowIndex: rowIndex == 2 ? 1 : 0,
                                    seatIndex: seatIndex,
                                  ),
                                );
                              },
                            ),
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
                      : CustomPaint(
                          painter: SeatDecorator(
                            color: Theme.of(context).colorScheme.primary,
                            isTop: rowIndex == 0,
                          ),
                          child: Seat(
                            index: provider.getSideSeatIndex(
                              blockIndex: blockIndex,
                              rowIndex: rowIndex == 2 ? 1 : 0,
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 22),
      itemCount: 72 ~/ 8,
    );
  }
}
