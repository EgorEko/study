class UserDTO {
  final String login;
  final int id;
  final String avatarUrl;

  UserDTO._(this.login, this.id, this.avatarUrl);

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO._(json['login'], json['id'], json['avatar_url']);
  }
}
