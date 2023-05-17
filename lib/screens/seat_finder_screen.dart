import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class SeatFinderScreen extends StatelessWidget {
  const SeatFinderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SeatFinderProvider provider =
        Provider.of<SeatFinderProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          Strings.appTitle,
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        actions: [
          IconButton(
            onPressed: () {
              provider.isLightMode = !provider.isLightMode;
            },
            icon: Icon(
              provider.isLightMode ? Icons.dark_mode : Icons.light_mode,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          IconButton(
            onPressed: () {
              provider.areSeatLabelsShown = !provider.areSeatLabelsShown;
            },
            icon: Icon(provider.areSeatLabelsShown
                ? Icons.visibility_off
                : Icons.visibility),
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.only(left: 16, top: 16, right: 16),
        child: Column(
          children: [
            FindTextField(),
            SizedBox(height: 16),
            Expanded(
              child: SeatsListView(),
            ),
          ],
        ),
      ),
    );
  }
}
