import 'package:flutter/material.dart';

class AdaptiveLayoutExample extends StatefulWidget {
  const AdaptiveLayoutExample({super.key});

  @override
  State<AdaptiveLayoutExample> createState() => _AdaptiveLayoutExampleState();
}

class _AdaptiveLayoutExampleState extends State<AdaptiveLayoutExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints
        constraints){
          if (constraints.maxWidth > 600) {
            return DesktopLayout();
          } else {
            return MobileLayout();
          }
        }, ),
    );
  }
}

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
      child: Align(
        alignment: Alignment.center,
        child: Text('Desktop Layout'),
      ),
    ); }
}
class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      child: Align(
        alignment: Alignment.center,
        child: Text('Mobile Layout'),
      ),
    );}}