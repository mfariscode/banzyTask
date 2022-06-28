// To parse this JSON data, do
//
//     final foodReportModel = foodReportModelFromJson(jsonString);

import 'dart:convert';

FoodReportModel foodReportModelFromJson(String str) => FoodReportModel.fromJson(json.decode(str));

String foodReportModelToJson(FoodReportModel data) => json.encode(data.toJson());

class FoodReportModel {
  FoodReportModel({
    required this.user,
    required this.reports,
  });

  User user;
  List<Report> reports;

  factory FoodReportModel.fromJson(Map<String, dynamic> json) => FoodReportModel(
    user: User.fromJson(json["user"]),
    reports: List<Report>.from(json["reports"].map((x) => Report.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "reports": List<dynamic>.from(reports.map((x) => x.toJson())),
  };
}

class Report {
  Report({
    required this.date,
    required this.optIns,
  });

  String date;
  OptIns optIns;

  factory Report.fromJson(Map<String, dynamic> json) => Report(
    date: json["date"],
    optIns: json["opt_ins"].isEmpty ? OptIns(breakfast: "---", lunch: "---", dinner: "---") : OptIns.fromJson(json["opt_ins"]),
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "opt_ins": optIns.toJson(),
  };
}

class OptIns {
  OptIns({
    required this.breakfast,
    required this.lunch,
    required this.dinner,
  });

  var breakfast;
  var lunch;
  var dinner;

  factory OptIns.fromJson(Map<String, dynamic> json) => OptIns(
    breakfast: json["breakfast"],
    lunch: json["lunch"],
    dinner: json["dinner"],
  );

  Map<String, dynamic> toJson() => {
    "breakfast": breakfast,
    "lunch": lunch,
    "dinner": dinner,
  };
}

class User {
  User({
    required this.fName,
    required this.lName,
    required this.image,
  });

  String fName;
  String lName;
  dynamic image;

  factory User.fromJson(Map<String, dynamic> json) => User(
    fName: json["f_name"],
    lName: json["l_name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "f_name": fName,
    "l_name": lName,
    "image": image,
  };
}
