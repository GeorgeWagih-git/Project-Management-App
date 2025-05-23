class ProjectFileModel {
  final int id;
  final String fileName;
  final String fileUrl;

  ProjectFileModel(
      {required this.id, required this.fileName, required this.fileUrl});

  factory ProjectFileModel.fromJson(Map<String, dynamic> json) {
    return ProjectFileModel(
      id: json['id'],
      fileName: json['fileName'],
      fileUrl: json['fileUrl'],
    );
  }
}
