import 'dart:convert';

PermissionEntity permissionEntityFromJson(String str) =>
    PermissionEntity.fromJson(json.decode(str));

String permissionEntityToJson(PermissionEntity data) =>
    json.encode(data.toJson());

class PermissionEntity {
  final bool isRequesting;
  final bool isAllGranted;

  PermissionEntity({
    required this.isRequesting,
    required this.isAllGranted,
  });

  PermissionEntity copyWith({
    bool? isRequesting,
    bool? isAllGranted,
  }) =>
      PermissionEntity(
        isRequesting: isRequesting ?? this.isRequesting,
        isAllGranted: isAllGranted ?? this.isAllGranted,
      );

  factory PermissionEntity.fromJson(Map<String, dynamic> json) =>
      PermissionEntity(
        isRequesting: json["isRequesting"],
        isAllGranted: json["isAllGranted"],
      );

  Map<String, dynamic> toJson() => {
        "isRequesting": isRequesting,
        "isAllGranted": isAllGranted,
      };
}
