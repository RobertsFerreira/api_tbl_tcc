import 'package:map_fields/map_fields.dart';

class TypeUserModel {
  final String id;
  final String name;
  final String? description;

  TypeUserModel({
    required this.id,
    required this.name,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory TypeUserModel.fromMap(Map<String, dynamic> map) {
    final mapFields = MapFields.load(map);
    return TypeUserModel(
      id: mapFields.getString('id'),
      name: mapFields.getString('name'),
      description: mapFields.getString('description', ''),
    );
  }
}
