import 'package:flutter/material.dart';

class SliverSecondExample extends StatefulWidget {
  const SliverSecondExample({super.key});

  @override
  State<SliverSecondExample> createState() => _SliverSecondExampleState();
}

class _SliverSecondExampleState extends State<SliverSecondExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: MySliverHeaderDelegate(
              maxHeight: 200,
              minHeight: 100,
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Text('My Header'),
                ),
              ),
            ),
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
              childCount: 100,
            ),
          ),
        ],
      ),
    );
  }
}

class MySliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final double minHeight;
  final Widget child;

  MySliverHeaderDelegate({
    required this.maxHeight,
    required this.minHeight,
    required this.child,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
