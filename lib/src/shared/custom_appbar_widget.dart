import 'package:flutter/material.dart';
import 'package:prueba_tecnica_exito/src/core/constants/styles.dart';

class MainAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Widget centerWidget;
  final Color backgroundColor;
  final Widget? actions;
  final bool showBackButton;

  const MainAppbarWidget({
    super.key,
    required this.centerWidget,
    this.backgroundColor = Colors.white,
    this.actions,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) => AppBar(
    backgroundColor: primaryColor,
    elevation: 0,
    centerTitle: true,
    leading: showBackButton
        ? IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          )
        : const SizedBox(),
    leadingWidth: showBackButton ? 56 : 10,
    actionsPadding: const EdgeInsets.only(right: 20, left: 0),
    title: centerWidget,
    titleSpacing: 8,
    actions: [
      Padding(
        padding: EdgeInsets.zero,
        child: actions ?? const SizedBox(),
      ),
    ],
  );

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
