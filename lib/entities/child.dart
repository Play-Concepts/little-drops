
import 'package:drops/entities/pda_record.dart';
import 'package:drops/utils/random_data.dart';

class Child extends PdaRecord {
  Child({ String? endpoint, String? recordId, dynamic data}) {
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
  String? image;
  String? name;
  String? relationship;
  String? ageGroup;
  int? score;
  String? message;

  ChildData({
    this.image,
    this.name,
    this.relationship,
    this.ageGroup,
    this.score,
    this.message
  });

  ChildData.fromJsonReal(jsonObject) {
    this.image = jsonObject['image'];
    this.name = jsonObject['name'];
    this.relationship = jsonObject['relationship'];
    this.ageGroup = jsonObject['ageGroup'];
    this.score = jsonObject['score'];
    this.message = jsonObject['message'];
  }

  ChildData.fromJson(jsonObject) {
    this.image = randomChildImage();
    this.name = jsonObject['name'];
    this.relationship = jsonObject['relationship'];
    this.ageGroup = jsonObject['ageGroup'];
    this.score = randomScore();
    this.message = randomMessage();
  }
}