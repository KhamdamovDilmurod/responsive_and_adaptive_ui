
import 'package:flutter/material.dart';

class OrientationBuilderExample extends StatefulWidget {
  const OrientationBuilderExample({super.key});

  @override
  State<OrientationBuilderExample> createState() => _OrientationBuilderExampleState();
}

class _OrientationBuilderExampleState extends State<OrientationBuilderExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation
        orientation) {
          if (orientation == Orientation.portrait) {
            return PortraitLayout();
          } else {
            return LandscapeLayout();
          } },
      ), );
  }
}


class LandscapeLayout extends StatelessWidget {
  const LandscapeLayout({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Align(
        alignment: Alignment.center,
        child: Text('Landscape Layout'),
      ),
    ); }
}
class PortraitLayout extends StatelessWidget {
  const PortraitLayout({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: Align(
        alignment: Alignment.center,
        child: Text('Portrait Layout'),
      ),
    ); }
}