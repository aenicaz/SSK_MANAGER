const String userTableName = 'UserTest';

class UserFields {
  static final List<String> values = [
    id,
    name,
    status,
    jobTitle,
  ];

  static const String id = '_id';
  static const String name = '_name';
  static const String status = '_status';
  static const String jobTitle = '_jobTitle';
}

class User {
  int? id;
  String? name;
  String? status;
  String? jobTitle;

  User({
    this.id,
    this.name,
    this.status,
    this.jobTitle,
  });

  @override
  String toString() {
    return '''Recod: {id: $id, name: $name, status: $status, jobTitle: $jobTitle}''';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'jobTitle': jobTitle,
    };
  }

  Map<String, Object?> toJson() => {
        UserFields.id: id,
        UserFields.name: name,
        UserFields.status: status,
        UserFields.jobTitle: jobTitle
      };

  static User fromJson(Map<String, Object?> json) => User(
      id: json[UserFields.id] as int?,
      name: json[UserFields.name] as String,
      status: json[UserFields.status] as String,
      jobTitle: json[UserFields.jobTitle] as String);
}
