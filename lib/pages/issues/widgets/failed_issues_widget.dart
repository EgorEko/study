import 'package:flutter/material.dart';

class FailedIssuesWidget extends StatelessWidget {
  final VoidCallback onRetry;
  final String message;
  const FailedIssuesWidget(
      {super.key, required this.onRetry, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Oops!!! $message'),
        IconButton(
          onPressed: onRetry,
          icon: const Icon(Icons.refresh),
        ),
      ],
    );
  }
}
