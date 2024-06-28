import 'package:flutter/material.dart';

import '../constants/styling.dart';

class GeneralAppBar extends AppBar {
  GeneralAppBar({super.key, Widget? title, List<Widget>? actions})
      : super(
          title: title,
          actions: actions,
          toolbarHeight: appBarHeight,
        );
}
