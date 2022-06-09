final String tableWords = 'words';

class WordFields {
  static final List<String> values = [id, archiveID, word, time];

  static const String id = '_id';
  static const String archiveID = 'archiveID';
  static const String word = 'word';
  static const String time = 'time';
}

class Word {
  final int? id;
  final int? archiveId;
  final String word;
  final DateTime createdTime;

  Word(
      {this.id,
      required this.archiveId,
      required this.word,
      required this.createdTime, int? archiveID});

  Word copy({
    int? id,
    int? archiveID,
    String? word,
    DateTime? createdTime
  }) => Word(
    id: id ?? this.id,
    archiveId: archiveId, //?? this.archiveId, 
    word: word ?? this.word, 
    createdTime: createdTime ?? this.createdTime);

  static Word fromJson(Map<String, Object?> json) => Word(
    id: json[WordFields.id] as int?,
    archiveId: json[WordFields.archiveID] as int?, 
    word: json[WordFields.word] as String,
    createdTime: DateTime.parse(json[WordFields.time] as String));

  Map<String, Object?> toJson() => {
        WordFields.id: id,
        WordFields.archiveID: archiveId,
        WordFields.word: word,
        WordFields.time: createdTime.toIso8601String(),
      };   

}
