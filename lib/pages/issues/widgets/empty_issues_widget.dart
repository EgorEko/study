import 'package:flutter/material.dart';

class EmtyIssuesWidget extends StatelessWidget {
  final VoidCallback onRefresh;
  const EmtyIssuesWidget({Key? key, required this.onRefresh}) : super(key: key);

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
