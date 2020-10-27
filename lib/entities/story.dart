import 'package:drops/entities/pda_record.dart';

class Story extends PdaRecord {
  Story({ String endpoint, String recordId, dynamic data}) {
    super.endpoint = endpoint;
    super.recordId = recordId;
    super.data = data;
  }

  Story.fromJson(jsonObject) {
    this.endpoint = jsonObject['endpoint'];
    this.recordId = jsonObject['recordId'];
    this.data = StoryData.fromJson(jsonObject['data']);
  }

  @override
  String toString() => '${this.recordId} (${this.isDirty}): ${this.data.title} ${this.data.description}';
}

class StoryData {
  String image;
  String title;
  String backgroundImages;
  String description;

  StoryData({
    this.image,
    this.title,
    this.backgroundImages,
    this.description
  });

  StoryData.fromJson(jsonObject) {
    this.image = jsonObject['image'];
    this.title = jsonObject['title'];
    this.backgroundImages = jsonObject['backgroundImages'];
    this.description = jsonObject['description'];
  }

  StoryData clone() {
    return StoryData(
      image: this.image,
      title: this.title,
      backgroundImages: this.backgroundImages,
      description: this.description
    );
  }
}