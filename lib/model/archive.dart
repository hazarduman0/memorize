final String tableArchives = 'archives';

class ArchiveFields {
  static final List<String> values = [
    id,
    isPinned,
    archiveName,
    description,
    color,
    time
  ];

  static const String id = '_id';
  static const String isPinned = 'isPinned';
  static const String archiveName = 'archiveName';
  static const String description = 'description';
  static const String color = 'color';
  static const String time = 'time';
}

class Archive {
  final int? id;
  final bool isPinned;
  final String archiveName;
  final String description;
  final String color;
  final DateTime createdTime;

  Archive(
      {this.id,
      required this.isPinned,
      required this.archiveName,
      required this.description,
      required this.color,
      required this.createdTime});

  Archive copy({
    int? id,
    bool? isPinned,
    String? archiveName,
    String? description,
    String? color,
    DateTime? createdTime,
  }) =>
      Archive(
        id: id ?? this.id,
        isPinned: isPinned ?? this.isPinned,
        archiveName: archiveName ?? this.archiveName,
        description: description ?? this.description,
        color: color ?? this.color,
        createdTime: createdTime ?? this.createdTime,
      );

  static Archive fromJson(Map<String, Object?> json) => Archive(
    id: json[ArchiveFields.id] as int?,
    isPinned: json[ArchiveFields.isPinned] == 1, 
    archiveName: json[ArchiveFields.archiveName] as String, 
    description: json[ArchiveFields.description] as String, 
    color: json[ArchiveFields.color] as String, 
    createdTime: DateTime.parse(json[ArchiveFields.time] as String));  

  Map<String, Object?> toJson() => {
        ArchiveFields.id: id,
        ArchiveFields.isPinned: isPinned ? 1 : 0,
        ArchiveFields.archiveName: archiveName,
        ArchiveFields.description: description,
        ArchiveFields.color: color,
        ArchiveFields.time: createdTime.toIso8601String(),
      };
}
