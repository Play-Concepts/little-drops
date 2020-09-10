class Pda {
  String _hatName;
  String _hatCluster;

  String get hatName => _hatName;
  String get hatCluster => _hatCluster;

  Pda.fromParams(String _hat_name, String _hat_cluster) {
    _hatName = _hat_name;
    _hatCluster = _hat_cluster;
  }

  Pda.fromJson(Map<String, dynamic> jsonObject) {
    _hatName = jsonObject['hatName'];
    _hatCluster = jsonObject['hatCluster'];
  }
}
