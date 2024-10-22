import 'package:flutter/material.dart';

class EmptyIssuesWidget extends StatelessWidget {
  const EmptyIssuesWidget({required this.onRefresh, super.key});
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('No issues! Create one tostart play'),
        IconButton(
          onPressed: onRefresh,
          icon: const Icon(Icons.refresh),
        ),
      ],
    );
  }
}
