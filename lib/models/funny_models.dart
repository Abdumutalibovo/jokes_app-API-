import 'package:jokes_app/models/jokes_model.dart';

class Funnys {
  bool? error;
  num? amount;
  List<Jokes>? jokes;

  Funnys({
    required this.error,
    required this.amount,
    required this.jokes,
  });

  factory Funnys.fromJson(Map<String, dynamic> json) {
    return Funnys(
      error: json['error']??"",
      amount: json['amount']??0,
      jokes:
          (json['jokes'] as List)
          .map((joke) => Jokes.fromJson(joke))
          .toList(),
    );
  }
}
