class SampleItem {
  final int id;
  bool isDone;

  SampleItem(this.id, {this.isDone = false});

  /// Convert a SampleItem into a JSON object
  Map<String, dynamic> toJson() => {
    'id': id,
    'isDone': isDone,
  };

  /// Create a SampleItem from a JSON object
  factory SampleItem.fromJson(Map<String, dynamic> json) {
    return SampleItem(
      json['id'],
      isDone: json['isDone'],
    );
  }
}
