import 'package:cd_organizer/feature/music_api/domain/label.dart';
import 'package:equatable/equatable.dart';

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
      label: json['label'] != null ? Label.fromJson(json['label']) : null,
    );
  }

  @override
  List<Object?> get props => [
        catalogNumber,
        label,
      ];
}
