import 'package:advocatepro_f/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:advocatepro_f/common/widgets/custom_shapes/curved_edges/curved_edge_widget.dart';
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:flutter/material.dart';

class SPrimaryHeaderContainer extends StatelessWidget {
  const SPrimaryHeaderContainer({
    super.key, required this.child, 
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SCurvedEdgeWidget(
      child: Container(
        color: SColors.primary,
        padding: const EdgeInsets.all(0),
        child: SizedBox(
          ///- if [size.infinite : is  not true.in Stack ] error ocurred 
          child: Stack(
            children: [
              /// - Background Custom Shapes
              Positioned(
                  top: -100,
                  right: -100,
                  child: SCircularContainer(
                    height: 200,
                    width: 200,
                    radius: 200,
                    backgroundColor: SColors.white.withOpacity(0.1),
                  )),
              Positioned(
                  top: 50,
                  right: -150,
                  child: SCircularContainer(
                    height: 200,
                    width: 200,
                    radius: 200,
                    backgroundColor: SColors.white.withOpacity(0.1),
                  )),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

