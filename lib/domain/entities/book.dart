import 'package:freezed_annotation/freezed_annotation.dart';

part 'book.freezed.dart';
part 'book.g.dart';

// const _kUuid = 'uuid';
// const _kTitle = 'title';
// const _kAuthor = 'author';
// const _kIsPopular = 'isPopular';
// const _kIsNewRelease = 'isNewRelease';
// const _kGenre = 'genre';
// const _kDescription = 'description';
// const _kPosterUrl = 'posterUrl';

@Freezed()
class Book with _$Book {
  const factory Book({
    required String uuid,
    required String title,
    required String author,
    required bool isPopular,
    required bool isNewRelease,
    required String genre,
    required String description,
    required String posterUrl,
  }) = _Book;

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
}
