import 'package:flutter/material.dart';

class IFEmptyView extends StatelessWidget {
  final String text;

  const IFEmptyView({Key? key, this.text = '空空如也~'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Image(
          height: 160,
          image: AssetImage("assets/image/empty.png"),
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}
