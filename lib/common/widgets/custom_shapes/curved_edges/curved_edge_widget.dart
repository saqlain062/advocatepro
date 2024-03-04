import 'package:advocatepro_f/common/widgets/custom_shapes/curved_edges/curved_edges.dart';
import 'package:flutter/material.dart';

class SCurvedEdgeWidget extends StatelessWidget {
  const SCurvedEdgeWidget({
    super.key,
    required this.child,
  });

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: SCustomeCurvedEdges(), child: child);
  }
}
