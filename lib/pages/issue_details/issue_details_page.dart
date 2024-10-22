import 'package:flutter/material.dart';

class IssueDetailsPage extends StatelessWidget {
  const IssueDetailsPage({required this.issueNumber, super.key});
  final int issueNumber;

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
