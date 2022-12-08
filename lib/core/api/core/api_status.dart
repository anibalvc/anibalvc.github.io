import 'dart:convert';

class Success<T> {
  final T response;
  Success({
    required this.response,
  });
}

Failure failureFromJson(String str) => Failure.fromJson(json.decode(str));

String failureToJson(Failure data) => json.encode(data.toJson());

class Failure {
  Failure({
    required this.message,
  });

  String message;

  factory Failure.fromJson(Map<String, dynamic> json) => Failure(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "messages": message,
      };
}

class TokenFail {}
