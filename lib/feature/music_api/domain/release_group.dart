import 'package:equatable/equatable.dart';

class ReleaseGroup extends Equatable {
  final String id;
  final String title;
  final String? typeId;
  final String? primaryType;
  final String? primaryTypeId;
  final List<String>? secondaryTypes;
  final List<String>? secondaryTypeIds;

  const ReleaseGroup({
    required this.id,
    required this.title,
    this.typeId,
    this.primaryType,
    this.primaryTypeId,
    this.secondaryTypes,
    this.secondaryTypeIds,
  });

  static ReleaseGroup fromJson(Map<String, dynamic> json) {
    return ReleaseGroup(
      id: json['id'],
      title: json['title'],
      typeId: json['type-id'],
      primaryType: json['primary-type'],
      primaryTypeId: json['primary-type-id'],
      secondaryTypes: (json['secondary-types'] as List?)?.map((e) => e as String).toList(),
      secondaryTypeIds: (json['secondary-type-ids'] as List?)?.map((e) => e as String).toList(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        typeId,
        primaryType,
        primaryTypeId,
        secondaryTypes,
        secondaryTypeIds,
      ];
}
