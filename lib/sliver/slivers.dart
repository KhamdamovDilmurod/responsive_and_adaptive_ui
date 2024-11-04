import 'package:flutter/material.dart';

class SliverFirstExample extends StatefulWidget {
  const SliverFirstExample({super.key});

  @override
  State<SliverFirstExample> createState() => _SliverFirstExampleState();
}

class _SliverFirstExampleState extends State<SliverFirstExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.lime ,
            title: Text('My App'),
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
