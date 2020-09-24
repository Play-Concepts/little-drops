
import 'package:drops/entities/pda_record.dart';

class Child extends PdaRecord {
  Child({ String endpoint, String recordId, dynamic data}) {
    super.endpoint = endpoint;
    super.recordId = recordId;
    super.data = data;
  }

  Child.fromJson(jsonObject) {
    this.endpoint = jsonObject['endpoint'];
    this.recordId = jsonObject['recordId'];
    this.data = ChildData.fromJson(jsonObject['data']);
  }

  @override
  String toString() {
    // TODO: implement toString
    return '${this.recordId}: ${this.data.name} ${this.data.relationship}';
  }
}

class ChildData {
  String image;
  String name;
  String message;
  int score;
  String relationship;
  String gender;
  String ageGroup;

  ChildData({
    this.image,
    this.name,
    this.message,
    this.score,
    this.relationship,
    this.gender,
    this.ageGroup
  });

  ChildData.fromJson(jsonObject) {
    this.image = jsonObject['image'];
    this.name = jsonObject['name'];
    this.message = jsonObject['message'];
    this.score = jsonObject['score'];
    this.relationship = jsonObject['relationship'];
    this.gender = jsonObject['gender'];
    this.ageGroup = jsonObject['ageGroup'];
  }
}