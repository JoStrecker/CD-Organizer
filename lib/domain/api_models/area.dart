import 'package:equatable/equatable.dart';

class Area extends Equatable {
  final String id;
  final List<String> iso31661codes;
  final String name;
  final String sortName;

  const Area({
    required this.id,
    required this.iso31661codes,
    required this.name,
    required this.sortName,
  });

  static Area fromJson(Map<String, dynamic> json) {
    return Area(
      id: json['id'],
      iso31661codes: json['iso-3166-1-codes'].toList(),
      name: json['name'],
      sortName: json['sort-name'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        iso31661codes,
        name,
        sortName,
      ];
}
