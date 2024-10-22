import 'package:flutter/material.dart';

class IssueDetailsPage extends StatelessWidget {
  final int issueNumber;

  const IssueDetailsPage({super.key, required this.issueNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Issue'),
      ),
      body: Center(
        child: Text('details $issueNumber'),
      ),
    );
  }
}
