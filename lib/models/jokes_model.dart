import 'package:jokes_app/models/flags_model.dart';

class Jokes {
  String? category;
  String? type;
  String? setup;
  String? delivery;
  Flags? flags;
  String? safe;
  String? joke;
  int? id;
  String? lang;

  Jokes({
    required this.category,
    required this.type,
    required this.setup,
    required this.delivery,
    required this.flags,
    required this.safe,
    required this.id,
    required this.lang,
    required this.joke,
  });

  factory Jokes.fromJson(Map<String, dynamic> json) {
    return Jokes(
      category: json['category']??"",
      type: json['type']??"",
      setup: json['setup']??json['category'],
      delivery: json['delivery']??json['joke'],
      flags: Flags.fromJson(json['flags']),
      safe: json['json']??"",
      id: json['id']??0,
      lang: json['lang']??"",
      joke: json['joke']??"",
    );
  }
}
