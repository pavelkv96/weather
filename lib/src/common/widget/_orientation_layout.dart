import 'package:flutter/material.dart';

class OrientationLayout extends StatelessWidget {
  final Widget portrait;
  final Widget? landscape;

  const OrientationLayout({
    Key? key,
    required this.portrait,
    this.landscape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (_, orientation) => orientation == Orientation.landscape ? landscape ?? portrait : portrait,
    );
  }
}
