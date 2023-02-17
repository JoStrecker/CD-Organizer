import 'package:equatable/equatable.dart';

class Label extends Equatable {
  final String id;
  final String name;

  const Label({
    required this.id,
    required this.name,
  });

  static Label fromJson(Map<String, dynamic> json) {
    return Label(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
