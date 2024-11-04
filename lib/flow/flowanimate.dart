import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedFlowExample extends StatefulWidget {
  const AnimatedFlowExample({super.key});

  @override
  State<AnimatedFlowExample> createState() => _AnimatedFlowExampleState();
}

class _AnimatedFlowExampleState extends State<AnimatedFlowExample>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool isExpanded = false;

  final List<IconData> icons = [
    Icons.home,
    Icons.person,
    Icons.settings,
    Icons.notifications,
    Icons.email,
    Icons.favorite,
    Icons.share,
  ];

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Flow(
        delegate: AnimatedFlowDelegate(
          animation: controller,
        ),
        children: [
          // Main menu button
          FloatingActionButton(
            onPressed: () {
              setState(() {
                isExpanded = !isExpanded;
                if (isExpanded) {
                  controller.forward();
                } else {
                  controller.reverse();
                }
              });
            },
            backgroundColor: Colors.blue,
            child: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: controller,
            ),
          ),
          // Menu items
          for (IconData icon in icons)
            FloatingActionButton(
              onPressed: () {
                // Handle item tap
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$icon clicked')),
                );
                setState(() {
                  isExpanded = false;
                  controller.reverse();
                });
              },
              backgroundColor: Colors.primaries[
              icons.indexOf(icon) % Colors.primaries.length],
              mini: true,
              child: Icon(icon),
            ),
        ],
      ),
    );
  }
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

      if (i == 0) {
        // Position the main button at bottom center
        final x = center.dx - childOffset.dx;
        final y = context.size.height - childOffset.dy - 100;
        context.paintChild(0,
            transform: Matrix4.translationValues(x, y, 0));
        continue;
      }

      // Calculate position on circle for menu items
      final theta = ((i - 1) * pi) / (context.childCount - 2);
      final radius = 120 * animation.value;

      // Calculate final position relative to main button
      final x = center.dx + radius * cos(theta) - childOffset.dx;
      final y = (context.size.height - 100) + radius * sin(theta) - childSize.height;

      // Create transform with both translation and rotation
      final transform = Matrix4.translationValues(x, y, 0)
        ..rotateZ(theta * animation.value);

      context.paintChild(i, transform: transform);
    }
  }

  @override
  bool shouldRepaint(AnimatedFlowDelegate oldDelegate) =>
      animation != oldDelegate.animation;
}
