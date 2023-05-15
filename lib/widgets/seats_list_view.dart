import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:seat_finder/models/seat_decorator.dart';

import '../providers/seat_finder_provider.dart';
import 'seat.dart';

class SeatsListView extends StatelessWidget {
  const SeatsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final SeatFinderProvider provider =
        Provider.of<SeatFinderProvider>(context);
    return ScrollablePositionedList.separated(
      itemScrollController: provider.itemController,
      padding: const EdgeInsets.all(8),
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
                                  foundSeatIndex: provider.foundedSeatIndex,
                                  areSeatLablesShown:
                                      provider.areSeatLabelsShown,
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
                            foundSeatIndex: provider.foundedSeatIndex,
                            areSeatLablesShown: provider.areSeatLabelsShown,
                          ),
                        ),
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 18),
      itemCount: 72 ~/ 8,
    );
  }
}
