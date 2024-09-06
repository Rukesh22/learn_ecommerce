// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:learn_ecommerce/common/widgets/home_widgets/curved_edges.dart';

class TCurvededgewidget extends StatelessWidget {
  const TCurvededgewidget({super.key,
  this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TCustomCurvedEdges(),
      child: child,
    );
  }
}