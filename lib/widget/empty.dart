import 'package:flutter/material.dart';

class EmptyIcon extends StatelessWidget {
  final String? message;
  final TextStyle? textStyle;

  final Widget? append;

  const EmptyIcon({
    super.key,
    this.message = '空空如也~',
    this.textStyle,
    this.append,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/image/empty.png', height: 120),
        if (message != null)
          Text(
            message ?? '空空如也~',
            textAlign: TextAlign.center,
            style: textStyle ??
                TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).disabledColor,
                ),
          ),
        if (append != null) ...[
          const SizedBox(height: 8),
          append!,
        ],
      ],
    );
  }
}
