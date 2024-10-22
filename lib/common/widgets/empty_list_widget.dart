import 'package:flutter/material.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({
    required this.title,
    required this.icon,
    required this.onAction,
    super.key,
  });

  final String title;
  final IconData icon;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title),
        IconButton(
          onPressed: onAction,
          icon: Icon(icon),
        ),
      ],
    );
  }
}
