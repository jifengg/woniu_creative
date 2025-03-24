import 'package:json_annotation/json_annotation.dart';
import 'base_db_model.dart';
import 'custom_formatter.dart';
part 'base_owner_model.g.dart';

@JsonSerializable()
class BaseOwnerModel extends BaseDbModel {
  /// 所有者ID
  @JsonKey(name: 'owner_id')
  final int? ownerId;

  BaseOwnerModel({this.ownerId, super.createdAt, super.updatedAt});

  factory BaseOwnerModel.fromJson(Map<String, dynamic> json) =>
      _$BaseOwnerModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BaseOwnerModelToJson(this);
}
