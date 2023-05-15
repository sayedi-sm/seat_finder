import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seat_finder/models/strings.dart';
import 'package:seat_finder/providers/seat_finder_provider.dart';

class FindTextField extends StatelessWidget {
  const FindTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final SeatFinderProvider provider =
        Provider.of<SeatFinderProvider>(context);

    return Stack(
      children: [
        TextField(
          controller: provider.findController,
          decoration: InputDecoration(
            hintText: Strings.enterSeatNumber,
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                width: 3,
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                width: 3,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          keyboardType: TextInputType.number,
          cursorColor: Theme.of(context).colorScheme.primary,
          cursorWidth: 3,
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
          onChanged: (value) {
            if (value.isEmpty) {
              provider.foundedSeatIndex = null;
              return;
            }
            provider.notifyListeners();
          },
          onEditingComplete: provider.findController.text.isEmpty ||
                  provider.findController.text.contains('.') ||
                  int.parse(provider.findController.text) > 72
              ? null
              : provider.animateTo,
        ),
        Positioned(
          top: 0,
          right: 0,
          bottom: 0,
          child: ElevatedButton(
            onPressed: provider.findController.text.isEmpty ||
                    provider.findController.text.contains('.') ||
                    int.parse(provider.findController.text) > 72
                ? null
                : provider.animateTo,
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
            child: const Text(Strings.find),
          ),
        ),
      ],
    );
  }
}
