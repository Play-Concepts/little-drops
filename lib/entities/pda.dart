class Pda {
  String _hatName;
  String _hatCluster;

  String get hatName => _hatName;
  String get hatCluster => _hatCluster;

  Pda.fromJson(Map<String, dynamic> jsonObject) {
    _hatName = jsonObject['hatName'];
    _hatCluster = jsonObject['hatCluster'];
  }
}
