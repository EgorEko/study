import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'services/api/api_service.dart';

import 'repositories/counter_repository.dart';

final dummyApiService = ApiService(
  '',
  '',
  client: MockClient((request) async {
    await Future.delayed(const Duration(seconds: 1));
    return Response(
      '[{"url":"https://api.github.com/repos/EgorEko/study/issues/1","repository_url":"https://api.github.com/repos/EgorEko/study","labels_url":"https://api.github.com/repos/EgorEko/study/issues/1/labels{/name}","comments_url":"https://api.github.com/repos/EgorEko/study/issues/1/comments","events_url":"https://api.github.com/repos/EgorEko/study/issues/1/events","html_url":"https://github.com/EgorEko/study/issues/1","id":1238084971,"node_id":"I_kwDOHQ6pt85Jy61r","number":1,"title":"The first DUMMY issue","user":{"login":"EgorEko","id":81403804,"node_id":"MDQ6VXNlcjgxNDAzODA0","avatar_url":"https://avatars.githubusercontent.com/u/81403804?v=4","gravatar_id":"","url":"https://api.github.com/users/EgorEko","html_url":"https://github.com/EgorEko","followers_url":"https://api.github.com/users/EgorEko/followers","following_url":"https://api.github.com/users/EgorEko/following{/other_user}","gists_url":"https://api.github.com/users/EgorEko/gists{/gist_id}","starred_url":"https://api.github.com/users/EgorEko/starred{/owner}{/repo}","subscriptions_url":"https://api.github.com/users/EgorEko/subscriptions","organizations_url":"https://api.github.com/users/EgorEko/orgs","repos_url":"https://api.github.com/users/EgorEko/repos","events_url":"https://api.github.com/users/EgorEko/events{/privacy}","received_events_url":"https://api.github.com/users/EgorEko/received_events","type":"User","site_admin":false},"labels":[],"state":"open","locked":false,"assignee":null,"assignees":[],"milestone":null,"comments":0,"created_at":"2022-05-17T05:21:22Z","updated_at":"2022-05-17T05:21:22Z","closed_at":null,"author_association":"OWNER","active_lock_reason":null,"body":null,"reactions":{"url":"https://api.github.com/repos/EgorEko/study/issues/1/reactions","total_count":0,"+1":0,"-1":0,"laugh":0,"hooray":0,"confused":0,"heart":0,"rocket":0,"eyes":0},"timeline_url":"https://api.github.com/repos/EgorEko/study/issues/1/timeline","performed_via_github_app":null,"state_reason":null}]',
      200,
    );
  }),
);

final dummyCounterRepository = _DummyCounterRepository(20000);

class _DummyCounterRepository implements CounterRepository {
  _DummyCounterRepository(this.value);
  int value;

  @override
  Future<int> read() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return value;
  }

  @override
  Future<void> save(int value) async {
    await Future.delayed(const Duration(milliseconds: 100));
    this.value = value;
  }
}
