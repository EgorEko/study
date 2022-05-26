import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study/app_injector.dart';
import 'package:study/services/api/api_service.dart';

class NewIssuePage extends StatefulWidget {
  const NewIssuePage({Key? key}) : super(key: key);

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
                      onPressed: () async {
                        setState(() {
                          _creating = true;
                        });
                        final title = titleController.text;
                        final body = bodyController.text;
                        try {
                          final result = await context.apiService.createIssue(
                              owner: 'EgorEko',
                              repo: 'study',
                              title: title,
                              body: body);
                          Navigator.of(context).pop(result);
                        } finally {
                          setState(() {
                            _creating = false;
                          });
                        }
                      },
                      child: Text('Create'))
                ],
              ),
      )),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    bodyController.dispose();
  }
}
