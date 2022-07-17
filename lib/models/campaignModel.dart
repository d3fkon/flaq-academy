import 'dart:convert';

CampaignResponse campaignResponseFromJson(String str) =>
    CampaignResponse.fromJson(json.decode(str));

String campaignResponseToJson(CampaignResponse data) =>
    json.encode(data.toJson());

class CampaignResponse {
  CampaignResponse({
    required this.data,
    required this.statusCode,
  });

  CampaignData? data;
  int? statusCode;

  factory CampaignResponse.fromJson(Map<String, dynamic> json) =>
      CampaignResponse(
        data: CampaignData.fromJson(json["Data"]),
        statusCode: json["StatusCode"],
      );

  Map<String, dynamic> toJson() => {
        "Data": data!.toJson(),
        "StatusCode": statusCode,
      };
}

class CampaignData {
  CampaignData({
    required this.campaigns,
    required this.participations,
  });

  List<Campaign>? campaigns;
  List<Participation>? participations;

  factory CampaignData.fromJson(Map<String, dynamic> json) => CampaignData(
        campaigns: List<Campaign>.from(
            json["Campaigns"].map((x) => Campaign.fromJson(x))),
        participations: List<Participation>.from(
            json["Participations"].map((x) => Participation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Campaigns": List<dynamic>.from(campaigns!.map((x) => x.toJson())),
        "Participations":
            List<dynamic>.from(participations!.map((x) => x.toJson())),
      };
}

class Campaign {
  Campaign({
    required this.id,
    required this.quizzes,
    required this.description,
    required this.title,
    required this.requiredFlaq,
    required this.flaqReward,
    required this.tickerName,
    required this.tickerImageUrl,
    required this.airdropPerUser,
    required this.totalAirdrop,
    required this.currentAirdrop,
    required this.taskType,
    required this.articleUrls,
    required this.ytVideoUrl,
  });

  String? id;
  Quizzes? quizzes;
  String? description;
  String? title;
  int? requiredFlaq;
  int? flaqReward;
  String? tickerName;
  String? tickerImageUrl;
  dynamic airdropPerUser;
  int? totalAirdrop;
  int? currentAirdrop;
  String? taskType;
  List<String>? articleUrls;
  String? ytVideoUrl;

  factory Campaign.fromJson(Map<String, dynamic> json) => Campaign(
        id: json["Id"],
        quizzes: Quizzes.fromJson(json["Quizzes"]),
        description: json["Description"],
        title: json["Title"],
        requiredFlaq: json["RequiredFlaq"],
        flaqReward: json["FlaqReward"],
        tickerName: json["TickerName"],
        tickerImageUrl: json["TickerImageUrl"],
        airdropPerUser: json["AirdropPerUser"],
        totalAirdrop: json["TotalAirdrop"],
        currentAirdrop: json["CurrentAirdrop"],
        taskType: json["TaskType"],
        articleUrls: json["ArticleUrls"] == null
            ? null
            : List<String>.from(json["ArticleUrls"].map((x) => x)),
        ytVideoUrl: json["YTVideoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Quizzes": quizzes!.toJson(),
        "Description": description,
        "Title": title,
        "RequiredFlaq": requiredFlaq,
        "FlaqReward": flaqReward,
        "TickerName": tickerName,
        "TickerImageUrl": tickerImageUrl,
        "AirdropPerUser": airdropPerUser,
        "TotalAirdrop": totalAirdrop,
        "CurrentAirdrop": currentAirdrop,
        "TaskType": taskType,
        "ArticleUrls": List<dynamic>.from(articleUrls!.map((x) => x)),
        "YTVideoUrl": ytVideoUrl,
      };
}

class Quizzes {
  Quizzes({
    required this.ids,
    this.data,
  });

  List<String>? ids;
  dynamic? data;

  factory Quizzes.fromJson(Map<String, dynamic> json) => Quizzes(
        ids: List<String>.from(json["Ids"].map((x) => x)),
        data: json["CampaignData"],
      );

  Map<String, dynamic> toJson() => {
        "Ids": List<dynamic>.from(ids!.map((x) => x)),
        "CampaignData": data,
      };
}

class Participation {
  Participation({
    required this.id,
    required this.campaign,
    required this.user,
    required this.createdAt,
    required this.isComplete,
    required this.flaqSpent,
  });

  String? id;
  UserClass? campaign;
  UserClass? user;
  DateTime? createdAt;
  bool? isComplete;
  int? flaqSpent;

  factory Participation.fromJson(Map<String, dynamic> json) => Participation(
        id: json["Id"],
        campaign: UserClass.fromJson(json["Campaign"]),
        user: UserClass.fromJson(json["User"]),
        createdAt: DateTime.parse(json["CreatedAt"]),
        isComplete: json["IsComplete"],
        flaqSpent: json["FlaqSpent"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Campaign": campaign!.toJson(),
        "User": user!.toJson(),
        "CreatedAt": createdAt!.toIso8601String(),
        "IsComplete": isComplete,
        "FlaqSpent": flaqSpent,
      };
}

class UserClass {
  UserClass({
    required this.id,
    this.data,
  });

  String? id;
  dynamic? data;

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        id: json["Id"],
        data: json["CampaignData"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "CampaignData": data,
      };
}
