import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SliverList.list(children: const [
      Center(
          child: Text(
              "ERROR! while fetching cal data, \ncheck your internet/url settings.\n")),
      Center(
        child: Text('⬇️ pull down to retry ⬇️'),
      )
    ]);
  }
}
