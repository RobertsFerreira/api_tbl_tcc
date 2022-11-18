import 'package:map_fields/map_fields.dart';

class ApelacaoModel {
  final String id;
  final String apelacao;
  final GroupCustom group;

  ApelacaoModel({
    required this.id,
    required this.apelacao,
    required this.group,
  });

  factory ApelacaoModel.fromMap(Map<String, dynamic> map) {
    final mapFields = MapFields.load(map);
    return ApelacaoModel(
      id: mapFields.getString('id'),
      apelacao: mapFields.getString('apelacao'),
      group: GroupCustom.fromMap(mapFields.getMap<String, dynamic>('group')),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'apelacao': apelacao,
      'group': group.toMap(),
    };
  }
}

class GroupCustom {
  final String id;
  final String reference;
  final List<CustomUser> users;

  GroupCustom({
    required this.id,
    required this.reference,
    required this.users,
  });

  factory GroupCustom.fromMap(Map<String, dynamic> map) {
    final mapFields = MapFields.load(map);

    final mapUsers = mapFields.getList<Map<String, dynamic>>('users_groups');

    return GroupCustom(
      id: mapFields.getString('id'),
      reference: mapFields.getString('reference'),
      users: mapUsers.map((user) {
        final mapFields = MapFields.load(user);
        final userMap = mapFields.getMap<String, dynamic>('user');
        return CustomUser.fromMap(userMap);
      }).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reference': reference,
      'users_group': users.map((user) => user.toMap()).toList(),
    };
  }
}

class CustomUser {
  final String id;
  final String name;

  CustomUser({
    required this.id,
    required this.name,
  });

  factory CustomUser.fromMap(Map<String, dynamic> map) {
    final MapFields mapFields = MapFields.load(map);
    return CustomUser(
      id: mapFields.getString('id'),
      name: mapFields.getString('name'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
