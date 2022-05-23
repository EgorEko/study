import 'package:flutter/material.dart';

class IssueDetailsPage extends StatelessWidget {
  final int issueNumber;

  const IssueDetailsPage({Key? key, required this.issueNumber})
      : super(key: key);

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
