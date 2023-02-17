import 'package:equatable/equatable.dart';

class TextRepresentation extends Equatable {
  final String? language;
  final String? script;

  const TextRepresentation({
    this.language,
    this.script,
  });

  static TextRepresentation fromJson(Map<String, dynamic> json) {
    return TextRepresentation(
      language: json['language'],
      script: json['script'],
    );
  }

  @override
  List<Object?> get props => [
        language,
        script,
      ];
}
