import 'package:hive_flutter/hive_flutter.dart';
part 'video_model.g.dart';

@HiveType(typeId: 1)
class VideoModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String? video;

  VideoModel(this.id, this.video);
}
