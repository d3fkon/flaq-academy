import 'dart:convert';

QuizResponse quizResponseFromJson(String str) =>
    QuizResponse.fromJson(json.decode(str));

String quizResponseToJson(QuizResponse data) => json.encode(data.toJson());

class QuizResponse {
  QuizResponse({
    required this.data,
    required this.statusCode,
  });

  QuizData data;
  int statusCode;

  factory QuizResponse.fromJson(Map<String, dynamic> json) => QuizResponse(
        data: QuizData.fromJson(json["Data"]),
        statusCode: json["StatusCode"],
      );

  Map<String, dynamic> toJson() => {
        "Data": data.toJson(),
        "StatusCode": statusCode,
      };
}

class QuizData {
  QuizData({
    required this.id,
    required this.title,
    required this.questions,
  });

  String id;
  String title;
  List<Question> questions;

  factory QuizData.fromJson(Map<String, dynamic> json) => QuizData(
        id: json["Id"],
        title: json["Title"],
        questions: List<Question>.from(
            json["Questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Title": title,
        "Questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}

class Question {
  Question({
    required this.question,
    required this.description,
    required this.options,
    required this.answerIndex,
  });

  String question;
  String description;
  List<String> options;
  int answerIndex;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        question: json["Question"],
        description: json["Description"],
        options: List<String>.from(json["Options"].map((x) => x)),
        answerIndex: json["AnswerIndex"],
      );

  Map<String, dynamic> toJson() => {
        "Question": question,
        "Description": description,
        "Options": List<dynamic>.from(options.map((x) => x)),
        "AnswerIndex": answerIndex,
      };
}
