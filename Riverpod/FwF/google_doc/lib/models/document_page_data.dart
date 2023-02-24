import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_quill/flutter_quill.dart';

class DocumentPageData extends Equatable {
  final String id;
  final String title;
  final Delta content;

  const DocumentPageData({
    required this.id,
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    final encodedContent = jsonEncode(content.toJson());
    return {
      '\$id': id,
      'title': title,
      'content': encodedContent,
    };
  }

  factory DocumentPageData.fromMap(Map<String, dynamic> map) {
    final contentJson =
        (map['content'] == null) ? [] : jsonDecode(map['content']);
    return DocumentPageData(
      id: map['\$id'] ?? '',
      title: map['title'] ?? '',
      content: Delta.fromJson(contentJson),
    );
  }

  String toJson() => json.encode(toMap());

  factory DocumentPageData.fromJson(String source) =>
      DocumentPageData.fromMap(json.decode(source));

  @override
  List<Object?> get props => [title, content];

  DocumentPageData copyWith({
    String? id,
    String? title,
    Delta? content,
  }) {
    return DocumentPageData(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }

  @override
  String toString() {
    return 'DocumentPageData{id: $id, title: $title, content: $content}';
  }
}
