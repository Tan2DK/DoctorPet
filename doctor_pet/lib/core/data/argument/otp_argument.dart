class OtpArgument {
  final String? username;
  final String? userId;
  OtpArgument({
    this.username,
    this.userId,
  });

  OtpArgument copyWith({
    String? username,
    String? userId,
  }) {
    return OtpArgument(
      username: username ?? this.username,
      userId: userId ?? this.userId,
    );
  }
}
