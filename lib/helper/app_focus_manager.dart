import 'package:flutter/cupertino.dart';

class GlobalFocusManager extends StatelessWidget {
  final Widget child;

  const GlobalFocusManager({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: child,
    );
  }
}