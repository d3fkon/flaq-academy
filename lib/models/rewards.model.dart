// To parse this JSON data, do
//
//     final reward = rewardFromJson(jsonString);

import 'dart:convert';

class Reward {
  Reward({
    this.data,
    this.statusCode,
  });

  List<RewardDatum>? data;
  int? statusCode;

  Reward copyWith({
    List<RewardDatum>? data,
    int? statusCode,
  }) =>
      Reward(
        data: data ?? this.data,
        statusCode: statusCode ?? this.statusCode,
      );

  factory Reward.fromRawJson(String str) => Reward.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Reward.fromJson(Map<String, dynamic> json) => Reward(
        data: json["Data"] == null
            ? null
            : List<RewardDatum>.from(
                json["Data"].map((x) => RewardDatum.fromJson(x))),
        statusCode: json["StatusCode"] == null ? null : json["StatusCode"],
      );

  Map<String, dynamic> toJson() => {
        "Data": data == null
            ? null
            : List<dynamic>.from((data as List).map((x) => x.toJson())),
        "StatusCode": statusCode == null ? null : statusCode,
      };
}

class RewardDatum {
  RewardDatum({
    this.id,
    this.campaignParticipations,
    this.user,
    this.amount,
    this.tickerImageUrl,
    this.createdAt,
    this.tickerName,
    this.conversion,
    this.name,
  });

  String? id;
  CampaignParticipations? campaignParticipations;
  User? user;
  double? amount;
  String? tickerImageUrl;
  DateTime? createdAt;
  String? tickerName;
  int? conversion;
  String? name;

  RewardDatum copyWith({
    String? id,
    CampaignParticipations? campaignParticipations,
    User? user,
    double? amount,
    String? tickerImageUrl,
    DateTime? createdAt,
    String? tickerName,
    int? conversion,
    String? name,
  }) =>
      RewardDatum(
        id: id ?? this.id,
        campaignParticipations:
            campaignParticipations ?? this.campaignParticipations,
        user: user ?? this.user,
        amount: amount ?? this.amount,
        tickerImageUrl: tickerImageUrl ?? this.tickerImageUrl,
        createdAt: createdAt ?? this.createdAt,
        tickerName: tickerName ?? this.tickerName,
        conversion: conversion ?? this.conversion,
        name: name ?? this.name,
      );

  factory RewardDatum.fromRawJson(String str) =>
      RewardDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RewardDatum.fromJson(Map<String, dynamic> json) => RewardDatum(
        id: json["Id"] == null ? null : json["Id"],
        campaignParticipations: json["CampaignParticipations"] == null
            ? null
            : CampaignParticipations.fromJson(json["CampaignParticipations"]),
        user: json["User"] == null ? null : User.fromJson(json["User"]),
        amount: json["Amount"] == null ? null : json["Amount"].toDouble(),
        tickerImageUrl:
            json["TickerImageUrl"] == null ? null : json["TickerImageUrl"],
        createdAt: json["CreatedAt"] == null
            ? null
            : DateTime.parse(json["CreatedAt"]),
        tickerName: json["TickerName"] == null ? null : json["TickerName"],
        conversion: json["Conversion"] == null ? null : json["Conversion"],
        name: json["Name"] == null ? null : json["Name"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id == null ? null : id,
        "CampaignParticipations": campaignParticipations == null
            ? null
            : campaignParticipations?.toJson(),
        "User": user == null ? null : user?.toJson(),
        "Amount": amount == null ? null : amount,
        "TickerImageUrl": tickerImageUrl == null ? null : tickerImageUrl,
        "CreatedAt": createdAt == null ? null : createdAt?.toIso8601String(),
        "TickerName": tickerName == null ? null : tickerName,
        "Conversion": conversion == null ? null : conversion,
        "Name": name == null ? null : name,
      };
}

class CampaignParticipations {
  CampaignParticipations({
    this.ids,
    this.data,
  });

  List<String>? ids;
  List<CampaignParticipationsDatum>? data;

  CampaignParticipations copyWith({
    List<String>? ids,
    List<CampaignParticipationsDatum>? data,
  }) =>
      CampaignParticipations(
        ids: ids ?? this.ids,
        data: data ?? this.data,
      );

  factory CampaignParticipations.fromRawJson(String str) =>
      CampaignParticipations.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CampaignParticipations.fromJson(Map<String, dynamic> json) =>
      CampaignParticipations(
        ids: json["Ids"] == null
            ? null
            : List<String>.from(json["Ids"].map((x) => x)),
        data: json["Data"] == null
            ? null
            : List<CampaignParticipationsDatum>.from(json["Data"]
                .map((x) => CampaignParticipationsDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Ids": ids == null
            ? null
            : List<dynamic>.from((ids as List).map((x) => x)),
        "Data": data == null
            ? null
            : List<dynamic>.from((data as List).map((x) => x.toJson())),
      };
}

class CampaignParticipationsDatum {
  CampaignParticipationsDatum({
    this.id,
    this.campaign,
    this.user,
    this.createdAt,
    this.isComplete,
    this.flaqSpent,
  });

  String? id;
  User? campaign;
  User? user;
  DateTime? createdAt;
  bool? isComplete;
  int? flaqSpent;

  CampaignParticipationsDatum copyWith({
    String? id,
    User? campaign,
    User? user,
    DateTime? createdAt,
    bool? isComplete,
    int? flaqSpent,
  }) =>
      CampaignParticipationsDatum(
        id: id ?? this.id,
        campaign: campaign ?? this.campaign,
        user: user ?? this.user,
        createdAt: createdAt ?? this.createdAt,
        isComplete: isComplete ?? this.isComplete,
        flaqSpent: flaqSpent ?? this.flaqSpent,
      );

  factory CampaignParticipationsDatum.fromRawJson(String str) =>
      CampaignParticipationsDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CampaignParticipationsDatum.fromJson(Map<String, dynamic> json) =>
      CampaignParticipationsDatum(
        id: json["Id"] == null ? null : json["Id"],
        campaign:
            json["Campaign"] == null ? null : User.fromJson(json["Campaign"]),
        user: json["User"] == null ? null : User.fromJson(json["User"]),
        createdAt: json["CreatedAt"] == null
            ? null
            : DateTime.parse(json["CreatedAt"]),
        isComplete: json["IsComplete"] == null ? null : json["IsComplete"],
        flaqSpent: json["FlaqSpent"] == null ? null : json["FlaqSpent"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id == null ? null : id,
        "Campaign": campaign == null ? null : campaign?.toJson(),
        "User": user == null ? null : user?.toJson(),
        "CreatedAt": createdAt == null ? null : createdAt?.toIso8601String(),
        "IsComplete": isComplete == null ? null : isComplete,
        "FlaqSpent": flaqSpent == null ? null : flaqSpent,
      };
}

class User {
  User({
    this.id,
    this.data,
  });

  String? id;
  dynamic data;

  User copyWith({
    String? id,
    dynamic data,
  }) =>
      User(
        id: id ?? this.id,
        data: data ?? this.data,
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["Id"] == null ? null : json["Id"],
        data: json["Data"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id == null ? null : id,
        "Data": data,
      };
}
