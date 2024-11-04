import 'dart:math';

import 'package:flutter/material.dart';
import 'package:responsive_and_adaptive_ui/adaptive/adaptive_layout_example.dart';
import 'package:responsive_and_adaptive_ui/flow/flow.dart';
import 'package:responsive_and_adaptive_ui/adaptive/orientation_builder.dart';
import 'package:responsive_and_adaptive_ui/sliver/slivers.dart';
import 'package:responsive_and_adaptive_ui/sliver/slivers2.dart';

import 'flow/flow_radial.dart';
import 'flow/flowanimate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:Scaffold(
        appBar: AppBar(),
        body: Center(child: StaggeredGridFlow(children: [
          Container(width: 50, height: 50,color: Colors.red,margin: EdgeInsets.all(5),),
          Container(width: 50, height: 50,color: Colors.blue,margin: EdgeInsets.all(5),),
          Container(width: 50, height: 50,color: Colors.green,margin: EdgeInsets.all(5),),
        ],)),
      ),
    );
  }
}
class StaggeredGridFlow extends StatelessWidget {
  final List<Widget> children;
  final int columnCount;
  final double spacing;

  const StaggeredGridFlow({
    super.key,
    required this.children,
    this.columnCount = 2,
    this.spacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: StaggeredGridFlowDelegate(
        columnCount: columnCount,
        spacing: spacing,
      ),
      children: children,
    );
  }
}

class StaggeredGridFlowDelegate extends FlowDelegate {
  final int columnCount;
  final double spacing;

  StaggeredGridFlowDelegate({
    required this.columnCount,
    required this.spacing,
  });

  @override
  void paintChildren(FlowPaintingContext context) {
    if (context.childCount == 0) return;

    final double width = context.size.width;
    final double itemWidth =
        (width - (spacing * (columnCount - 1))) / columnCount;

    List<double> columnHeights = List.filled(columnCount, 0.0);

    for (int i = 0; i < context.childCount; i++) {
      final size = context.getChildSize(i)!;
      final double childAspectRatio = size.width / size.height;
      final double childHeight = itemWidth / childAspectRatio;

      // Find the column with minimum height
      int columnIndex = 0;
      double minHeight = columnHeights[0];
      for (int j = 1; j < columnCount; j++) {
        if (columnHeights[j] < minHeight) {
          minHeight = columnHeights[j];
          columnIndex = j;
        }
      }

      final double dx = columnIndex * (itemWidth + spacing);
      final double dy = columnHeights[columnIndex];

      context.paintChild(
        i,
        transform: Matrix4.translationValues(dx, dy, 0)
          ..scale(itemWidth / size.width),
      );

      columnHeights[columnIndex] += childHeight + spacing;
    }
  }

  @override
  bool shouldRepaint(StaggeredGridFlowDelegate oldDelegate) {
    return columnCount != oldDelegate.columnCount ||
        spacing != oldDelegate.spacing;
  }
}
