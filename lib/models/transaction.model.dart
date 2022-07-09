// class TransactionDataResponse {
//   int? statusCode;
//   List<Transaction>? data;

//   TransactionDataResponse({this.statusCode, this.data});

//   TransactionDataResponse.fromJson(Map<String, dynamic> json) {
//     statusCode = json['statusCode'];
//     if (json['data'] != null) {
//       data = <Transaction>[];
//       json['data'].forEach((v) {
//         data!.add(new Transaction.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['statusCode'] = this.statusCode;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Transaction {
//   String? sId;
//   String? rewardFlaq;
//   bool? isComplete;
//   String? upiUrl;
//   String? user;
//   String? amount;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;

//   Transaction(
//       {this.sId,
//       this.rewardFlaq,
//       this.isComplete,
//       this.upiUrl,
//       this.user,
//       this.amount,
//       this.status,
//       this.createdAt,
//       this.updatedAt,
//       this.iV});

//   Transaction.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     rewardFlaq = json['rewardFlaq'];
//     isComplete = json['isComplete'];
//     upiUrl = json['upiUrl'];
//     user = json['user'];
//     amount = json['amount'];
//     status = json['status'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['rewardFlaq'] = this.rewardFlaq;
//     data['isComplete'] = this.isComplete;
//     data['upiUrl'] = this.upiUrl;
//     data['user'] = this.user;
//     data['amount'] = this.amount;
//     data['status'] = this.status;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['__v'] = this.iV;
//     return data;
//   }
// }
// To parse this JSON data, do
//
//     final transactionDataResponse = transactionDataResponseFromJson(jsonString);

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
