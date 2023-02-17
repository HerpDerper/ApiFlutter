// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Note _$$_NoteFromJson(Map<String, dynamic> json) => _$_Note(
      name: json['name'] as String,
      text: json['text'] as String,
      category: json['category'] as String,
      number: json['number'] as int?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$$_NoteToJson(_$_Note instance) => <String, dynamic>{
      'name': instance.name,
      'text': instance.text,
      'category': instance.category,
      'number': instance.number,
      'status': instance.status,
    };
