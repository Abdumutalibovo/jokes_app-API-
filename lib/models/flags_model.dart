class Flags {
  bool? nsfw;
  bool? religious;
  bool? political;
  bool? racist;
  bool? sexist;
  bool? explicit;

  Flags({
    required this.nsfw,
    required this.religious,
    required this.political,
    required this.racist,
    required this.explicit,
    required this.sexist,
  });

  factory Flags.fromJson(Map<String, dynamic> json){
    return Flags(
      nsfw: json['nsfw'] ?? null,
      religious: json['religious'] ?? null,
      political: json['political'] ?? null,
      racist: json['racist'] ?? null,
      explicit: json['explicit'] ?? null,
      sexist: json['sexist'] ?? null,
    );
  }
}
