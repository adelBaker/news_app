
// To parse this JSON data, do
//
//     final favorite = favoriteFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Favorite {
  Favorite({
    required this.sportCounter,
    required this.scienceCounter,
    required this.buisnessCounter,
  });

  String sportCounter;
  String scienceCounter;
  String buisnessCounter;

  factory Favorite.fromJson(String str) => Favorite.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Favorite.fromMap(Map<String, dynamic> json) => Favorite(
    sportCounter: json["sport_counter"],
    scienceCounter: json["science_counter"],
    buisnessCounter: json["buisness_counter"],
  );

  Map<String, dynamic> toMap() => {
    "sport_counter": sportCounter,
    "science_counter": scienceCounter,
    "buisness_counter": buisnessCounter,
  };
}
