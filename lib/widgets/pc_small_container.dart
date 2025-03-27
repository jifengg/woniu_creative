import 'package:flutter/material.dart';
import 'package:woniu_creative/widgets/state_extension.dart';

class PcSmallContainer extends StatelessWidget {
  const PcSmallContainer({super.key, required this.child, this.maxWidth = 600});

  final Widget child;

  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return context.isPC
        ? ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: child,
        )
        : child;
  }
}
