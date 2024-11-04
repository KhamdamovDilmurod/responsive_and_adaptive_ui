import 'dart:math';

import 'package:flutter/material.dart';

class RadialMenu extends StatefulWidget {
  const RadialMenu({super.key});

  @override
  State<RadialMenu> createState() => _RadialMenuState();
}

class _RadialMenuState extends State<RadialMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool isExpanded = false;

  final List<MenuItemData> menuItems = [
    MenuItemData(Icons.home, 'Home', Colors.blue),
    MenuItemData(Icons.person, 'Profile', Colors.green),
    MenuItemData(Icons.settings, 'Settings', Colors.orange),
    MenuItemData(Icons.notifications, 'Notifications', Colors.purple),
    MenuItemData(Icons.logout, 'Logout', Colors.red),
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
      body: Flow(
        delegate: RadialMenuFlowDelegate(
          animation: controller,
          menuItemCount: menuItems.length,
        ),
        children: [
          // Main menu button
          ElevatedButton(
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
            child: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: controller,
            ),
          ),
          // Menu items
          for (var item in menuItems)
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  // Handle menu item tap
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${item.label} clicked')),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: item.color.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(item.icon, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(
                        item.label,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class MenuItemData {
  final IconData icon;
  final String label;
  final Color color;

  MenuItemData(this.icon, this.label, this.color);
}

class RadialMenuFlowDelegate extends FlowDelegate {
  final Animation<double> animation;
  final int menuItemCount;
  final double radius = 150;

  RadialMenuFlowDelegate({
    required this.animation,
    required this.menuItemCount,
  }) : super(repaint: animation);

  @override
  void paintChildren(FlowPaintingContext context) {
    final size = context.size;
    final xCenter = size.width - 200;  // Positioning in bottom-right corner
    final yCenter = size.height - 200;

    // Paint the main button
    final mainButtonSize = context.getChildSize(0)!;
    context.paintChild(0,
        transform: Matrix4.translationValues(
            xCenter - mainButtonSize.width / 2,
            yCenter - mainButtonSize.height / 2,
            0));

    // Paint the menu items
    for (int i = 1; i < context.childCount; i++) {
      final childSize = context.getChildSize(i)!;
      // Calculate the angle for each item, spreading them in a 90-degree arc
      final angle = (pi / 2) * (i - 1) / (menuItemCount - 1) - pi/4;

      final x = xCenter +
          (radius * animation.value) * cos(angle) -
          childSize.width / 2;
      final y = yCenter +
          (radius * animation.value) * sin(angle) -
          childSize.height / 2;

      // Apply fade and scale animation
      final scale = animation.value;
      final transform = Matrix4.identity()
        ..translate(x, y)
        ..scale(scale);

      context.paintChild(i, transform: transform);
    }
  }

  @override
  bool shouldRepaint(RadialMenuFlowDelegate oldDelegate) {
    return animation != oldDelegate.animation ||
        menuItemCount != oldDelegate.menuItemCount;
  }
}