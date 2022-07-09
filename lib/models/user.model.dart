// class UserProfileResponse {
//   int? statusCode;
//   FlaqUser? data;

//   UserProfileResponse({this.statusCode, this.data});

//   UserProfileResponse.fromJson(Map<String, dynamic> json) {
//     statusCode = json['statusCode'];
//     data = json['data'] != null ? new FlaqUser.fromJson(json['data']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['statusCode'] = this.statusCode;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }

// class FlaqUser {
//   int? rewardMultiplier;
//   String? synFlaqBalance;
//   late bool isAllowed;
//   String? sId;
//   String? referralCode;
//   String? email;
//   String? uid;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;

//   FlaqUser(
//       {this.rewardMultiplier,
//       this.synFlaqBalance,
//       this.isAllowed = false,
//       this.sId,
//       this.referralCode,
//       this.email,
//       this.uid,
//       this.createdAt,
//       this.updatedAt,
//       this.iV});

//   FlaqUser.fromJson(Map<String, dynamic> json) {
//     rewardMultiplier = json['rewardMultiplier'];
//     synFlaqBalance = json['synFlaqBalance'];
//     isAllowed = json['isAllowed'] ?? false;
//     sId = json['_id'];
//     referralCode = json['referralCode'];
//     email = json['email'];
//     uid = json['uid'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['rewardMultiplier'] = this.rewardMultiplier;
//     data['synFlaqBalance'] = this.synFlaqBalance;
//     data['isAllowed'] = this.isAllowed;
//     data['_id'] = this.sId;
//     data['referralCode'] = this.referralCode;
//     data['email'] = this.email;
//     data['uid'] = this.uid;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['__v'] = this.iV;
//     return data;
//   }
// }

import 'dart:convert';

UserProfileResponse userProfileResponseFromJson(String str) =>
    UserProfileResponse.fromJson(json.decode(str));

String userProfileResponseToJson(UserProfileResponse data) =>
    json.encode(data.toJson());

class UserProfileResponse {
  UserProfileResponse({
    required this.data,
    required this.statusCode,
  });

  FlaqUser? data;
  int statusCode;

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      UserProfileResponse(
        data: json["Data"] == null ? null : FlaqUser.fromJson(json["Data"]),
        statusCode: json["StatusCode"],
      );

  Map<String, dynamic> toJson() => {
        "FlaqUser": data!.toJson(),
        "StatusCode": statusCode,
      };
}

class FlaqUser {
  FlaqUser({
    required this.id,
    required this.email,
    required this.flaqPoints,
    required this.rewardMultiplier,
    required this.referralCode,
    required this.isAllowed,
    required this.refreshToken,
    required this.walletAddresses,
    required this.createdAt,
  });

  String? id;
  String? email;
  int? flaqPoints;
  int? rewardMultiplier;
  String? referralCode;
  late bool isAllowed;
  String? refreshToken;
  WalletAddresses? walletAddresses;
  String? createdAt;

  factory FlaqUser.fromJson(Map<String, dynamic> json) => FlaqUser(
        id: json["Id"],
        email: json["Email"],
        flaqPoints: json["FlaqPoints"],
        rewardMultiplier: json["RewardMultiplier"],
        referralCode: json["ReferralCode"],
        isAllowed: json["IsAllowed"],
        refreshToken: json["RefreshToken"],
        walletAddresses: WalletAddresses.fromJson(json["WalletAddresses"]),
        createdAt: json["CreatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Email": email,
        "FlaqPoints": flaqPoints,
        "RewardMultiplier": rewardMultiplier,
        "ReferralCode": referralCode,
        "IsAllowed": isAllowed,
        "RefreshToken": refreshToken,
        "WalletAddresses": walletAddresses!.toJson(),
        "CreatedAt": createdAt
      };
}

class WalletAddresses {
  WalletAddresses({
    required this.solana,
    required this.ethereum,
    required this.avax,
  });

  String? solana;
  String? ethereum;
  String? avax;

  factory WalletAddresses.fromJson(Map<String, dynamic> json) =>
      WalletAddresses(
        solana: json["Solana"],
        ethereum: json["Ethereum"],
        avax: json["Avax"],
      );

  Map<String, dynamic> toJson() => {
        "Solana": solana,
        "Ethereum": ethereum,
        "Avax": avax,
      };
}
