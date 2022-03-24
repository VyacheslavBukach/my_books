// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Book _$$_BookFromJson(Map<String, dynamic> json) => _$_Book(
      uuid: json['uuid'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      isPopular: json['isPopular'] as bool,
      isNewRelease: json['isNewRelease'] as bool,
      genre: json['genre'] as String,
      description: json['description'] as String,
      posterUrl: json['posterUrl'] as String,
    );

Map<String, dynamic> _$$_BookToJson(_$_Book instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'title': instance.title,
      'author': instance.author,
      'isPopular': instance.isPopular,
      'isNewRelease': instance.isNewRelease,
      'genre': instance.genre,
      'description': instance.description,
      'posterUrl': instance.posterUrl,
    };
