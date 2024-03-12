class Task {
  static const String collectionName = 'Tasks';

  String? id;
  String? title;
  String? description;
  DateTime? date;
  bool? isDone;

  Task(
      {this.id = '',
      required this.title,
      required this.description,
      required this.date,
      this.isDone = false});

  // obj => map
  Map<String, dynamic> toJson() {
    return {
      'id': id as String,
      'title': title as String,
      'description': description as String,
      'date': date!.millisecondsSinceEpoch,
      'isDone': isDone as bool
    };
  }

  // map => obj
  Task.fromJson(Map<String, dynamic> jsonData)
      : this(
      id: jsonData['id'],
            title: jsonData['title'],
            description: jsonData['description'],
            date: (jsonData['date'] is int)
                ? DateTime.fromMillisecondsSinceEpoch(jsonData['date'])
                : DateTime.fromMillisecondsSinceEpoch(
                    jsonData['date'].millisecondsSinceEpoch),
            isDone: jsonData['isDone']);
}
