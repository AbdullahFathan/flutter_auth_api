import 'dart:convert';

List<Quotes> quotesFromJson(String str) =>
    List<Quotes>.from(json.decode(str).map((x) => Quotes.fromJson(x)));

String quotesToJson(List<Quotes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Quotes {
  Quotes({
    this.anime,
    this.character,
    this.quote,
  });

  String? anime;
  String? character;
  String? quote;

  factory Quotes.fromJson(Map<String, dynamic> json) => Quotes(
        anime: json["anime"],
        character: json["character"],
        quote: json["quote"],
      );

  Map<String, dynamic> toJson() => {
        "anime": anime,
        "character": character,
        "quote": quote,
      };
}
