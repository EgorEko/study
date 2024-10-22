import 'package:flutter/material.dart';

class FailedIssuesWidget extends StatelessWidget {
  const FailedIssuesWidget({
    required this.onRetry,
    required this.message,
    super.key,
  });

  final VoidCallback onRetry;
  final String message;

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
