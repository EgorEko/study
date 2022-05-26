import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study/app_injector.dart';
import 'package:study/pages/issues/issues_view_model.dart';

class EditIssuePage extends StatefulWidget {
  final IssueModel issue;
  const EditIssuePage({Key? key, required this.issue}) : super(key: key);

  @override
  State<EditIssuePage> createState() => _NewIssuePageState();
}

class _NewIssuePageState extends State<EditIssuePage> {
  late final titleController = TextEditingController();
  late final bodyController = TextEditingController();
  bool _creating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Issues'),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _creating
            ? const Center(
                child: CupertinoActivityIndicator(),
              )
            : Column(
                children: [
                  TextField(
                    controller: titleController,
                    decoration:
                        const InputDecoration(hintText: 'Type issue title'),
                  ),
                  TextField(
                    controller: bodyController,
                    decoration:
                        const InputDecoration(hintText: 'Type issue body'),
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          _creating = true;
                        });
                        final title = titleController.text;
                        final body = bodyController.text;
                        try {
                          context.issuesViewModel.updateIssue(widget.issue,
                              title: title, body: body);
                          Navigator.of(context).pop();
                        } finally {
                          setState(() {
                            _creating = false;
                          });
                        }
                      },
                      child: const Text('Update'))
                ],
              ),
      )),
    );
  }

  @override
  void initState() {
    super.initState();
    titleController.text = widget.issue.title;
    bodyController.text = widget.issue.body ?? "";
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    bodyController.dispose();
  }
}
