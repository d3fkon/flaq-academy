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

class Articles {
  String? url;
  String? title;
  String? iconUrl;

  Articles({this.url, this.title, this.iconUrl});

  Articles.fromJson(Map<String, dynamic> json) {
    url = json['Url'];
    title = json['Title'];
    iconUrl = json['IconUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Url'] = this.url;
    data['Title'] = this.title;
    data['IconUrl'] = this.iconUrl;
    return data;
  }
}

class Campaign {
  String id;
  Quizzes? quizzes;
  String description;
  String title;
  num? requiredFlaq;
  num? flaqReward;
  String? tickerName;
  String? tickerImageUrl;
  num? airdropPerUser;
  num? totalAirdrop;
  num? currentAirdrop;
  String? taskType;
  List<Articles>? articles;
  String? yTVideoUrl;
  String? image;

  Campaign(
      {required this.id,
      this.quizzes,
      required this.description,
      required this.title,
      this.requiredFlaq,
      this.flaqReward,
      this.tickerName,
      this.tickerImageUrl,
      this.airdropPerUser,
      this.totalAirdrop,
      this.currentAirdrop,
      this.taskType,
      this.articles,
      this.yTVideoUrl,
      this.image});

  Campaign.fromJson(Map<String, dynamic> json)
      : id = json['Id'],
        quizzes = json['Quizzes'] != null
            ? new Quizzes.fromJson(json['Quizzes'])
            : null,
        description = json['Description'],
        title = json['Title'],
        requiredFlaq = json['RequiredFlaq'],
        flaqReward = json['FlaqReward'],
        tickerName = json['TickerName'],
        tickerImageUrl = json['TickerImageUrl'],
        airdropPerUser = json['AirdropPerUser'],
        totalAirdrop = json['TotalAirdrop'],
        currentAirdrop = json['CurrentAirdrop'],
        taskType = json['TaskType'],
        yTVideoUrl = json['YTVideoUrl'],
        image = json['Image'] {
    if (json['Articles'] != null) {
      articles = <Articles>[];
      json['Articles'].forEach((v) {
        articles!.add(new Articles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    if (this.quizzes != null) {
      data['Quizzes'] = this.quizzes!.toJson();
    }
    data['Description'] = this.description;
    data['Title'] = this.title;
    data['RequiredFlaq'] = this.requiredFlaq;
    data['FlaqReward'] = this.flaqReward;
    data['TickerName'] = this.tickerName;
    data['TickerImageUrl'] = this.tickerImageUrl;
    data['AirdropPerUser'] = this.airdropPerUser;
    data['TotalAirdrop'] = this.totalAirdrop;
    data['CurrentAirdrop'] = this.currentAirdrop;
    data['TaskType'] = this.taskType;
    if (this.articles != null) {
      data['Articles'] = this.articles!.map((v) => v.toJson()).toList();
    }
    data['YTVideoUrl'] = this.yTVideoUrl;
    data['Image'] = this.image;
    return data;
  }
}

class Quizzes {
  Quizzes({
    required this.ids,
    this.data,
  });

  List<String>? ids;
  dynamic data;

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
