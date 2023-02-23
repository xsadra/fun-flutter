import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_quill/flutter_quill.dart';

class DocumentPageData extends Equatable {
  final String title;
  final Delta content;

  const DocumentPageData({
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    var encodedContent = jsonEncode(content.toJson());
    return {
      'title': title,
      'content': encodedContent,
    };
  }

  factory DocumentPageData.fromMap(Map<String, dynamic> map) {
    final contentJson =
        (map['content'] == null) ? [] : jsonDecode(map['content']);
    return DocumentPageData(
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
    String? title,
    Delta? content,
  }) {
    return DocumentPageData(
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }
}
