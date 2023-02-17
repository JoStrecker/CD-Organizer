import 'package:equatable/equatable.dart';

import 'label.dart';

class LabelInfo extends Equatable {
  final String? catalogNumber;
  final Label? label;

  const LabelInfo({
    this.catalogNumber,
    this.label,
  });

  static LabelInfo fromJson(Map<String, dynamic> json) {
    return LabelInfo(
      catalogNumber: json['catalog-number'],
      label: json['label'].map<Label>((e) => Label.fromJson(e)),
    );
  }

  @override
  List<Object?> get props => [
        catalogNumber,
        label,
      ];
}
