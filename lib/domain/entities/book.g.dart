// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Book _$$_BookFromJson(Map<String, dynamic> json) => _$_Book(
      id: json['id'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      popular: (json['popular'] as num).toDouble(),
      isNewRelease: json['isNewRelease'] as bool,
      genre: (json['genre'] as List<dynamic>).map((e) => e as String).toList(),
      description: json['description'] as String,
      posterUrl: json['posterUrl'] as String,
    );

Map<String, dynamic> _$$_BookToJson(_$_Book instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'popular': instance.popular,
      'isNewRelease': instance.isNewRelease,
      'genre': instance.genre,
      'description': instance.description,
      'posterUrl': instance.posterUrl,
    };
