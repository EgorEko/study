import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../app_injector.dart';

class NewIssuePage extends StatefulWidget {
  const NewIssuePage({super.key});

  @override
  State<NewIssuePage> createState() => _NewIssuePageState();
}

class _NewIssuePageState extends State<NewIssuePage> {
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
                          context.issuesBloc
                              .createIssue(title: title, body: body);
                          Navigator.of(context).pop();
                        } finally {
                          setState(() {
                            _creating = false;
                          });
                        }
                      },
                      child: const Text('Create'),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }
}
