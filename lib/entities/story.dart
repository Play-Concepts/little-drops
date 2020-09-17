class Story {
  String recordId;
  StoryData data;

  Story({
    this.recordId,
    this.data
  });

  Story.fromJson(jsonObject) {
    this.recordId = jsonObject['recordId'];
    this.data = StoryData.fromJson(jsonObject['data']);
  }
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
}