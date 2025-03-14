import 'package:flutter/material.dart';

class WaitingItem extends StatelessWidget {
  const WaitingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.list(children: const [
      Center(child: CircularProgressIndicator()),
      Center(child: Text("loading...")),
    ]);
  }
}
