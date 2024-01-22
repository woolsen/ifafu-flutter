import 'package:flutter/material.dart';

class IFDialog extends StatelessWidget {
  final String? title;
  final String? text;
  final double width;

  final String? confirmText;
  final String cancelText;
  final Widget? child;

  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const IFDialog({
    Key? key,
    this.title,
    this.text,
    this.child,
    this.confirmText,
    this.onConfirm,
    this.cancelText = '取消',
    this.onCancel,
    double? width,
  })  : width = width ?? 260,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextBody(),
            const Divider(
              height: 1,
              thickness: 1,
              color: Colors.black12,
            ),
            _buildButtonLayout(context)
          ],
        ),
      ),
    );
  }

  Widget _buildTextBody() {
    final EdgeInsets padding;
    final List<Widget> children = [];
    if (title == null && text == null) {
      return const SizedBox(height: 48);
    }
    if (title != null) {
      children.add(Text(
        title!,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.none,
        ),
      ));
    }
    if (title != null && text != null && child == null) {
      children.add(const SizedBox(height: 8));
      padding = const EdgeInsets.all(16);
    } else {
      padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 16);
    }
    if (text != null) {
      children.add(Text(
        text!,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black87,
          fontWeight: FontWeight.normal,
          decoration: TextDecoration.none,
        ),
      ));
    }
    if (child != null) {
      children.add(const SizedBox(height: 12));
      children.add(child!);
    }

    return Padding(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }

  Widget _buildButtonLayout(BuildContext context) {
    final List<Widget> children = [];
    children.add(Expanded(
      child: GestureDetector(
        onTap: () {
          if (onCancel == null) {
            Navigator.pop(context);
          } else {
            onCancel?.call();
          }
        },
        child: Text(
          cancelText,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    ));
    if (confirmText != null) {
      children.add(const VerticalDivider(
        width: 1,
        thickness: 1,
        color: Colors.black12,
      ));
    }
    if (confirmText != null) {
      children.add(Expanded(
        child: GestureDetector(
          onTap: () => onConfirm?.call(),
          child: Text(
            confirmText!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF1986FF),
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ));
    }
    return Builder(builder: (context) {
      return SizedBox(height: 44, child: Row(children: children));
    });
  }
}
