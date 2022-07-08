final String tableQuizs = 'quizs';

class QuizFields {
  static final List<String> values = [
    id,
    archiveID,
    trueCount,
    falseCount,
    noAnswerCount,
    correctRate,
    wordCount,
    countDown,
    date
  ];

  static const String id = '_id';
  static const String archiveID = 'archiveID';
  static const String trueCount = 'trueCount';
  static const String falseCount = 'falseCount';
  static const String noAnswerCount = 'noAnswerCount';
  static const String correctRate = 'correctRate';
  static const String wordCount = 'wordCount';
  static const String countDown = 'countDown';
  static const String date = 'date';
}

class Quiz {
  final int? id;
  final int archiveID;
  final int trueCount;
  final int falseCount;
  final int noAnswerCount;
  final double correctRate;
  final int wordCount;
  final DateTime countDown;
  final DateTime date;

  Quiz({
    required this.id,
    required this.archiveID,
    required this.trueCount,
    required this.falseCount,
    required this.noAnswerCount,
    required this.correctRate,
    required this.wordCount,
    required this.countDown,
    required this.date,
  });

  Quiz copy({
    int? id,
    int? archiveID,
    int? trueCount,
    int? falseCount,
    int? noAnswerCount,
    double? correctRate,
    int? wordCount,
    DateTime? countDown,
    DateTime? date,
  }) =>
      Quiz(
        id: id ?? this.id,
        archiveID: archiveID ?? this.archiveID,
        trueCount: trueCount ?? this.trueCount,
        falseCount: falseCount ?? this.falseCount,
        noAnswerCount: noAnswerCount ?? this.noAnswerCount,
        correctRate: correctRate ?? this.correctRate,
        wordCount: wordCount ?? this.wordCount,
        countDown: countDown ?? this.countDown,
        date: date ?? this.date,
      );

  static Quiz fromJson(Map<String, Object?> json) => Quiz(
      id: json[QuizFields.id] as int?,
      archiveID: json[QuizFields.archiveID] as int,
      trueCount: json[QuizFields.trueCount] as int,
      falseCount: json[QuizFields.falseCount] as int,
      noAnswerCount: json[QuizFields.noAnswerCount] as int,
      correctRate: json[QuizFields.correctRate] as double,
      wordCount: json[QuizFields.wordCount] as int,
      countDown: DateTime.parse(json[QuizFields.countDown] as String),
      date: DateTime.parse(json[QuizFields.date] as String));

  Map<String, Object?> toJson() => {
        QuizFields.id: id,
        QuizFields.archiveID: archiveID,
        QuizFields.trueCount: trueCount,
        QuizFields.falseCount: falseCount,
        QuizFields.noAnswerCount: noAnswerCount,
        QuizFields.correctRate: correctRate,
        QuizFields.wordCount: wordCount,
        QuizFields.countDown: countDown.second,
        QuizFields.date: date.toIso8601String(),
      };
}
