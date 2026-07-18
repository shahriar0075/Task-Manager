class TaskModel{
  late final String id;
  late final String title;
  late final String description;
  late final String status;
  late final String createDate;

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    title = json['title'] ?? '';
    description = json['description'] ?? '';
    status = json['status'] ?? '';
    createDate = json['createdDate'] ?? '';
  }
}