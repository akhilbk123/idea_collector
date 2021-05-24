// To parse this JSON data, do
//
//     final usermodel = usermodelFromJson(jsonString);

import 'dart:convert';

Usermodel usermodelFromJson(String str) => Usermodel.fromJson(json.decode(str));

String usermodelToJson(Usermodel data) => json.encode(data.toJson());

class Usermodel {
  Usermodel({
    this.ideas,
    this.id,
  });

  String ideas;
  int id;

  factory Usermodel.fromJson(Map<String, dynamic> json) => Usermodel(
        ideas: json["ideas"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "ideas": ideas,
        "id": id,
      };
}
