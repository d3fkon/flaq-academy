import 'dart:convert';

TransactionDataResponse transactionDataResponseFromJson(String str) =>
    TransactionDataResponse.fromJson(json.decode(str));

String transactionDataResponseToJson(TransactionDataResponse data) =>
    json.encode(data.toJson());

class TransactionDataResponse {
  TransactionDataResponse({
    required this.data,
    required this.statusCode,
  });

  List<Transaction>? data;
  int? statusCode;

  factory TransactionDataResponse.fromJson(Map<String, dynamic> json) =>
      TransactionDataResponse(
        data: List<Transaction>.from(
            json["Data"].map((x) => Transaction.fromJson(x))),
        statusCode: json["StatusCode"],
      );

  Map<String, dynamic> toJson() => {
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "StatusCode": statusCode,
      };
}

class Transaction {
  Transaction({
    required this.id,
    required this.user,
    required this.amount,
    required this.createdAt,
    required this.flaqReward,
  });

  String? id;
  String? user;
  String? amount;
  DateTime? createdAt;
  int? flaqReward;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["Id"],
        user: json["User"],
        amount: json["Amount"],
        createdAt: DateTime.parse(json["CreatedAt"]),
        flaqReward: json["FlaqReward"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "User": user,
        "Amount": amount,
        "CreatedAt": createdAt!.toIso8601String(),
        "FlaqReward": flaqReward,
      };
}
