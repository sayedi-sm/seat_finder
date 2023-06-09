import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';

class Seat extends StatelessWidget {
  const Seat({
    required this.index,
    super.key,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final SeatFinderProvider provider =
        Provider.of<SeatFinderProvider>(context);
    int? foundSeatIndex = provider.foundedSeatIndex;
    bool areSeatLabelsShown = provider.areSeatLabelsShown;
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        color: foundSeatIndex == index
            ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
            : Theme.of(context).colorScheme.primaryContainer,
        borderRadius: (index - 1) % 8 < 3 || (index - 1) % 8 == 6
            ? const BorderRadius.only(
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(4),
              )
            : const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (areSeatLabelsShown || foundSeatIndex == index)
              Text(
                index.toString(),
                style: TextStyle(
                  color: foundSeatIndex == index
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (foundSeatIndex == index)
              FittedBox(
                child: Consumer<SeatFinderProvider>(
                    builder: (context, SeatFinderProvider provider, _) {
                  return Text(
                    provider.getBerthTitle(index - 1),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: foundSeatIndex == index
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.primary,
                      fontSize: 12,
                    ),
                  );
                }),
              ),
          ],
        ),
      ),
    );
  }
}
