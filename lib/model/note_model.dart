class NoteModel {
  final int? id;
  final String? title;
  final String? content;
  final String createdAt;
  final String updatedAt;
  final int isFavorite;
  final int userId;
  final int? categoryId;
  final String? imagePath;
  final String? pdfPath;

  NoteModel({
    this.id,
    this.title,
    this.content,
    required this.createdAt,
    required this.updatedAt,
    this.isFavorite = 0,
    required this.userId,
    this.categoryId,
    this.imagePath,
    this.pdfPath
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'is_favorite': isFavorite,
      'user_id': userId,
      'category_id': categoryId,
      'image_path': imagePath,
      'pdfPath': pdfPath,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      isFavorite: map['is_favorite'] ?? 0,
      userId: map['user_id'],
      categoryId: map['category_id'],
      imagePath: map['image_path'],
      pdfPath: map['pdfPath'],
    );
  }
}
