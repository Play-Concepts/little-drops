import 'package:drops/entities/pda_record.dart';

class Profile extends PdaRecord {
  Profile({ String? endpoint, String? recordId, dynamic data}) {
    super.endpoint = endpoint;
    super.recordId = recordId;
    super.data = data;
  }

  Profile.fromJson(jsonObject) {
    this.endpoint = jsonObject['endpoint'];
    this.recordId = jsonObject['recordId'];
    this.data = ProfileData.fromJson(jsonObject['data']);
  }

  @override
  String toString() {
    // TODO: implement toString
    return '${this.recordId}: ${this.data.name}';
  }
}

class ProfileData {
  String? image;
  String? name;

  ProfileData({
    this.image,
    this.name,
  });

  ProfileData.fromJson(jsonObject) {
    this.image = jsonObject['image'];
    this.name = jsonObject['name'];
  }
}