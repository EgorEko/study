class UserDTO {
  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO._(json['login'], json['id'], json['avatar_url']);
  }

  UserDTO._(this.login, this.id, this.avatarUrl);
  final String login;
  final int id;
  final String avatarUrl;
}
