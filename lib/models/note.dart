import 'package:freezed_annotation/freezed_annotation.dart';
part 'note.g.dart';
part 'note.freezed.dart';

@freezed
class Note with _$Note {
  const factory Note({required String name, required String text, required String category, int? number, String? status}) = _Note;

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
}
