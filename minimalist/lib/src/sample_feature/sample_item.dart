class SampleItem {
  final int id;
  bool isDone;
  final String taskName; 

  SampleItem(this.id, {this.taskName = '', this.isDone = false});

  Map<String, dynamic> toJson() => {
    'id': id,
    'isDone': isDone,
    'taskName': taskName, 
  };

  factory SampleItem.fromJson(Map<String, dynamic> json) {
    return SampleItem(
      json['id'],
      taskName: json['taskName'] ?? '', 
      isDone: json['isDone'],
    );
  }
}
