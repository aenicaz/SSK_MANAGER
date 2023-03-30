const String techTypeTableName = 'TechType';

class TechTypeFields {
  static final List<String> values = [
    id,
    idType,
    typeName,
  ];

  static const String id = 'id';
  static const String idType = 'id_type';
  static const String typeName = 'type_name';
}

class TechType {
  int id;
  int idType;
  String typeName;

  TechType({
    required this.id,
    required this.idType,
    required this.typeName,
  });

  @override
  String toString() {
    return '''TechType is: {id: $id, id_type: $idType, type_name: $typeName
    }''';
  }

  Map<String, dynamic> toMap() {
    return {
      'id,': id,
      'id_type,': idType,
      'type_name,': typeName,
    };
  }

  Map<String, Object?> toJson() => {
        TechTypeFields.id: id,
        TechTypeFields.idType: idType,
        TechTypeFields.typeName: typeName,
      };

  static TechType fromJson(Map<String, Object?> json) => TechType(
        id: json[TechTypeFields.id] as int,
        idType: json[TechTypeFields.idType] as int,
        typeName: json[TechTypeFields.typeName] as String,
      );
}
