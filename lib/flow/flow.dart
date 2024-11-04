import 'dart:math';

import 'package:flutter/material.dart';

class FlowExample extends StatefulWidget {
  const FlowExample({super.key});

  @override
  State<FlowExample> createState() => _FlowExampleState();
}

class _FlowExampleState extends State<FlowExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Flow(
          delegate: SpacingFlowDelegate(20),
          children: [
            Container(width: 50.0, height: 50.0, color: Colors.red),
            Container(width: 50.0, height: 50.0, color: Colors.green),
            Container(width: 50.0, height: 50.0, color: Colors.blue),
            Container(width: 50.0, height: 50.0, color: Colors.yellow),
            Container(width: 50.0, height: 50.0, color: Colors.purple),
            Container(width: 50.0, height: 50.0, color: Colors.pink),
            Container(width: 50.0, height: 50.0, color: Colors.orange),
          ],
        ),
      ),
    );
  }
}

class CircleLayoutDelegate extends FlowDelegate {
  final double radius = 100;

  CircleLayoutDelegate();

  @override
  void paintChildren(FlowPaintingContext context) {
    final n = context.childCount;
    final double angleIncrement = 2 * pi / n;

    // Center of the layout
    final double centerX = context.size.width / 2;
    final double centerY = context.size.height / 2;

    for (int i = 0; i < n; i++) {
      final double angle = angleIncrement * i;
      // Calculate x and y positions based on angle
      final double x =
          centerX + radius * cos(angle) - context.getChildSize(i)!.width / 2;
      final double y =
          centerY + radius * sin(angle) - context.getChildSize(i)!.height / 2;
      // Positioning the child
      context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => true;

  @override
  Size getSize(BoxConstraints constraints) {
    // Adjusting the overall size to ensure children are not cut off
    final double totalDiameter = (radius + maxChildSize / 2) * 2;
    return Size(totalDiameter, totalDiameter);
  }

  double get maxChildSize => 50.0;
}

class AnimatedFlowDelegate extends FlowDelegate {
  final Animation<double> animation;

  AnimatedFlowDelegate({required this.animation}) : super(repaint: animation);

  @override
  void paintChildren(FlowPaintingContext context) {
    final center = context.size.center(Offset.zero);
    for (int i = 0; i < context.childCount; i++) {
      final childSize = context.getChildSize(i)!;
      final childOffset = Offset(childSize.width / 2, childSize.height / 2);

      // Calculate position on circle
      final theta = (i * pi * 2) / context.childCount;
      final radius = 100 * animation.value;

      // Calculate final position
      final x = center.dx + radius * cos(theta) - childOffset.dx;
      final y = center.dy + radius * sin(theta) - childOffset.dy;

      // Apply rotation and translation
      final transform = Matrix4.translationValues(x, y, 0)
        ..rotateZ(theta * animation.value);

      context.paintChild(i, transform: transform);
    }
  }

  @override
  bool shouldRepaint(AnimatedFlowDelegate oldDelegate) =>
      animation != oldDelegate.animation;
}

class SpacingFlowDelegate extends FlowDelegate {
  final double spacing;

  SpacingFlowDelegate(this.spacing);

  @override
  void paintChildren(FlowPaintingContext context) {
    double x = 0;
    for (int i = 0; i < context.childCount; i++) {
      context.paintChild(
        i,
        transform: Matrix4.translationValues(x, 0, 0),
      );
      x += context.getChildSize(i)!.width + spacing;
    }
  }

  @override
  bool shouldRepaint(SpacingFlowDelegate oldDelegate) =>
      spacing != oldDelegate.spacing;
}


///
///
/// 