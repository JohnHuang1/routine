import 'package:flutter/material.dart';
import 'package:routine/constants/styling.dart';

class EditListView extends StatelessWidget {
  const EditListView({super.key, required this.itemCount, required this.itemBuilder, required this.button});

  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final Widget button;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: listViewPadding,
            itemCount: itemCount,
            itemBuilder: (context, index) => Padding(
              padding: listViewItemPadding,
              child: itemBuilder(context, index)
            ),
          ),
        ),
        button
      ],
    );
  }
}
