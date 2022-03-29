import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'book.freezed.dart';
part 'book.g.dart';

@Freezed()
class Book with _$Book {
  const factory Book({
    required String id,
    required String title,
    required String author,
    required double popular,
    required DateTime createdAt,
    required List<String> genre,
    required String description,
    required String posterUrl,
  }) = _Book;

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
}
