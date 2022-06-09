final String tableMeanings = 'meanings';

class MeaningFields {
  static final List<String> values = [id, wordId, meaning, time];

  static const String id = '_id';
  static const String wordId = 'wordID';
  static const String meaning = 'meaning';
  static const String time = 'time';
}

class Meaning {
  final int? id;
  final int? wordId;
  final String meaning;
  final DateTime createdTime;

  Meaning(
      {this.id,
      required this.wordId,
      required this.meaning,
      required this.createdTime});

  Meaning copy({int? id, int? archiveID, String? meaning, DateTime? createdTime}) =>
      Meaning(
          id: id ?? this.id,
          wordId: wordId  ?? this.wordId,
          meaning: meaning ?? this.meaning,
          createdTime: createdTime ?? this.createdTime);

  static Meaning fromJson(Map<String, Object?> json) => Meaning(
      id: json[MeaningFields.id] as int?,
      wordId: json[MeaningFields.wordId] as int,
      meaning: json[MeaningFields.meaning] as String,
      createdTime: DateTime.parse(json[MeaningFields.time] as String));

  Map<String, Object?> toJson() => {
        MeaningFields.id: id,
        MeaningFields.wordId: wordId,
        MeaningFields.meaning: meaning,
        MeaningFields.time: createdTime.toIso8601String(),
      };
}
