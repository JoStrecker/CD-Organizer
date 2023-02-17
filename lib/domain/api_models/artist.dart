import 'package:equatable/equatable.dart';

class Artist extends Equatable {
  final String? disambiguation;
  final String id;
  final String name;
  final String sortname;

  const Artist({
    this.disambiguation,
    required this.id,
    required this.name,
    required this.sortname,
  });

  static Artist fromJson(Map<String, dynamic> json) {
    return Artist(
      disambiguation: json['disambiguation'],
      id: json['id'],
      name: json['name'],
      sortname: json['sort-name'],
    );
  }

  @override
  List<Object?> get props => [
        disambiguation,
        id,
        name,
        sortname,
      ];
}
