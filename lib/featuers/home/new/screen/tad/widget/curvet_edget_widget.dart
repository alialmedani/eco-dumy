import 'package:eco_dumy/featuers/home/new/screen/tad/widget/custom_curved_edges.dart';
import 'package:flutter/material.dart';

class CurvetEdgetWidget extends StatelessWidget {
  const CurvetEdgetWidget({super.key, this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: CustomCurvedEdges(), child: child);
  }
}
