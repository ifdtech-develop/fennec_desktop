class ErrorMessage {
  final dynamic timestamp;
  final int status;
  final String error;
  final String message;
  final String path;

  ErrorMessage({
    required this.timestamp,
    required this.status,
    required this.error,
    required this.message,
    required this.path,
  });

  factory ErrorMessage.fromJson(Map<String, dynamic> json) {
    return ErrorMessage(
      timestamp: json['timestamp'],
      status: json['status'],
      error: json['error'],
      message: json['message'],
      path: json['path'],
    );
  }
}
