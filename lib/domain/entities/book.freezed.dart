// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'book.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Book _$BookFromJson(Map<String, dynamic> json) {
  return _Book.fromJson(json);
}

/// @nodoc
class _$BookTearOff {
  const _$BookTearOff();

  _Book call(
      {required String uuid,
      required String title,
      required String author,
      required bool isPopular,
      required bool isNewRelease,
      required String genre,
      required String description,
      required String posterUrl}) {
    return _Book(
      uuid: uuid,
      title: title,
      author: author,
      isPopular: isPopular,
      isNewRelease: isNewRelease,
      genre: genre,
      description: description,
      posterUrl: posterUrl,
    );
  }

  Book fromJson(Map<String, Object?> json) {
    return Book.fromJson(json);
  }
}

/// @nodoc
const $Book = _$BookTearOff();

/// @nodoc
mixin _$Book {
  String get uuid => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get author => throw _privateConstructorUsedError;
  bool get isPopular => throw _privateConstructorUsedError;
  bool get isNewRelease => throw _privateConstructorUsedError;
  String get genre => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get posterUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BookCopyWith<Book> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookCopyWith<$Res> {
  factory $BookCopyWith(Book value, $Res Function(Book) then) =
      _$BookCopyWithImpl<$Res>;
  $Res call(
      {String uuid,
      String title,
      String author,
      bool isPopular,
      bool isNewRelease,
      String genre,
      String description,
      String posterUrl});
}

/// @nodoc
class _$BookCopyWithImpl<$Res> implements $BookCopyWith<$Res> {
  _$BookCopyWithImpl(this._value, this._then);

  final Book _value;
  // ignore: unused_field
  final $Res Function(Book) _then;

  @override
  $Res call({
    Object? uuid = freezed,
    Object? title = freezed,
    Object? author = freezed,
    Object? isPopular = freezed,
    Object? isNewRelease = freezed,
    Object? genre = freezed,
    Object? description = freezed,
    Object? posterUrl = freezed,
  }) {
    return _then(_value.copyWith(
      uuid: uuid == freezed
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      author: author == freezed
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      isPopular: isPopular == freezed
          ? _value.isPopular
          : isPopular // ignore: cast_nullable_to_non_nullable
              as bool,
      isNewRelease: isNewRelease == freezed
          ? _value.isNewRelease
          : isNewRelease // ignore: cast_nullable_to_non_nullable
              as bool,
      genre: genre == freezed
          ? _value.genre
          : genre // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      posterUrl: posterUrl == freezed
          ? _value.posterUrl
          : posterUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$BookCopyWith<$Res> implements $BookCopyWith<$Res> {
  factory _$BookCopyWith(_Book value, $Res Function(_Book) then) =
      __$BookCopyWithImpl<$Res>;
  @override
  $Res call(
      {String uuid,
      String title,
      String author,
      bool isPopular,
      bool isNewRelease,
      String genre,
      String description,
      String posterUrl});
}

/// @nodoc
class __$BookCopyWithImpl<$Res> extends _$BookCopyWithImpl<$Res>
    implements _$BookCopyWith<$Res> {
  __$BookCopyWithImpl(_Book _value, $Res Function(_Book) _then)
      : super(_value, (v) => _then(v as _Book));

  @override
  _Book get _value => super._value as _Book;

  @override
  $Res call({
    Object? uuid = freezed,
    Object? title = freezed,
    Object? author = freezed,
    Object? isPopular = freezed,
    Object? isNewRelease = freezed,
    Object? genre = freezed,
    Object? description = freezed,
    Object? posterUrl = freezed,
  }) {
    return _then(_Book(
      uuid: uuid == freezed
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      author: author == freezed
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      isPopular: isPopular == freezed
          ? _value.isPopular
          : isPopular // ignore: cast_nullable_to_non_nullable
              as bool,
      isNewRelease: isNewRelease == freezed
          ? _value.isNewRelease
          : isNewRelease // ignore: cast_nullable_to_non_nullable
              as bool,
      genre: genre == freezed
          ? _value.genre
          : genre // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      posterUrl: posterUrl == freezed
          ? _value.posterUrl
          : posterUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Book implements _Book {
  const _$_Book(
      {required this.uuid,
      required this.title,
      required this.author,
      required this.isPopular,
      required this.isNewRelease,
      required this.genre,
      required this.description,
      required this.posterUrl});

  factory _$_Book.fromJson(Map<String, dynamic> json) => _$$_BookFromJson(json);

  @override
  final String uuid;
  @override
  final String title;
  @override
  final String author;
  @override
  final bool isPopular;
  @override
  final bool isNewRelease;
  @override
  final String genre;
  @override
  final String description;
  @override
  final String posterUrl;

  @override
  String toString() {
    return 'Book(uuid: $uuid, title: $title, author: $author, isPopular: $isPopular, isNewRelease: $isNewRelease, genre: $genre, description: $description, posterUrl: $posterUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Book &&
            const DeepCollectionEquality().equals(other.uuid, uuid) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.author, author) &&
            const DeepCollectionEquality().equals(other.isPopular, isPopular) &&
            const DeepCollectionEquality()
                .equals(other.isNewRelease, isNewRelease) &&
            const DeepCollectionEquality().equals(other.genre, genre) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.posterUrl, posterUrl));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uuid),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(author),
      const DeepCollectionEquality().hash(isPopular),
      const DeepCollectionEquality().hash(isNewRelease),
      const DeepCollectionEquality().hash(genre),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(posterUrl));

  @JsonKey(ignore: true)
  @override
  _$BookCopyWith<_Book> get copyWith =>
      __$BookCopyWithImpl<_Book>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BookToJson(this);
  }
}

abstract class _Book implements Book {
  const factory _Book(
      {required String uuid,
      required String title,
      required String author,
      required bool isPopular,
      required bool isNewRelease,
      required String genre,
      required String description,
      required String posterUrl}) = _$_Book;

  factory _Book.fromJson(Map<String, dynamic> json) = _$_Book.fromJson;

  @override
  String get uuid;
  @override
  String get title;
  @override
  String get author;
  @override
  bool get isPopular;
  @override
  bool get isNewRelease;
  @override
  String get genre;
  @override
  String get description;
  @override
  String get posterUrl;
  @override
  @JsonKey(ignore: true)
  _$BookCopyWith<_Book> get copyWith => throw _privateConstructorUsedError;
}
