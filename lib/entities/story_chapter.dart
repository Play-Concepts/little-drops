import 'package:drops/entities/pda_record.dart';

class StoryChapter extends PdaRecord {
  StoryChapter({ String endpoint, String recordId, dynamic data}) {
    super.endpoint = endpoint;
    super.recordId = recordId;
    super.data = data;
  }

  StoryChapter.fromJson(jsonObject) {
    this.endpoint = jsonObject['endpoint'];
    this.recordId = jsonObject['recordId'];
    this.data = StoryChapterData.fromJson(jsonObject['data']);
  }

  @override
  String toString() => '${this.recordId}: ${this.data.title}';
}

class StoryChapterData {
  String title;
  String story;
  int index;

  StoryChapterData({
    this.title,
    this.story,
    this.index
  });

  StoryChapterData.fromJson(jsonObject) {
    this.title = jsonObject['title'];
    this.story = jsonObject['story'];
    this.index = jsonObject['index'];
  }
}
