import 'package:drops/services/delete_service.dart';
import 'package:drops/services/profile_service.dart';
import 'package:drops/utils/data_keys.dart';
import 'package:get/get.dart';
import 'package:drops/entities/profile.dart';
import 'package:drops/entities/child.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';

class ProfileRepository {
  final ProfileService profileService = Get.find<ProfileService>();
  final DeleteService deleteService = Get.find<DeleteService>();
  final GetStorage box = GetStorage(dkStore);

  Future<Profile> getProfile() {
    if (box.hasData(dkProfile)) {
      Iterable body = json.decode(box.read<String>(dkProfile)!);
      return Future.value(Profile.fromJson(body.first));
    }
    return profileService.getProfile();
  }

  Future<Profile> saveProfile(String name) => profileService.saveProfile(name);
  Future<Profile> updateProfile(String recordId, String name) => profileService.updateProfile(recordId, name);

  Future<List<Child>> getChildren() {
    if (box.hasData(dkChildren)) {
      Iterable jsonChildren = json.decode(box.read<String>(dkChildren)!);
      List<Child> children = jsonChildren.map((jsonObject) => Child.fromJson(jsonObject)).toList();
      return Future.value(children);
    }
    return profileService.getChildren();
  }

  Future<Child> saveChild(String name, { String relationship: 'child', String gender: '', String ageGroup: ''})
    => profileService.saveChild(name, relationship: relationship, gender: gender, ageGroup: ageGroup);

  Future<Child> updateChild(String recordId, String name, { String relationship: 'child', String gender: '', String ageGroup: ''})
  => profileService.updateChild(recordId, name, relationship: relationship, gender: gender, ageGroup: ageGroup);

  Future<bool> deleteChild(String recordId)
  => deleteService.delete(recordId).whenComplete(() => box.remove(dkChildren));
}