import 'package:equatable/equatable.dart';

class TaskCard extends Equatable {
  final String title;
  final int icon;
  final String color;
  final List<dynamic>? todos;

  const TaskCard({
    required this.title,
    required this.icon,
    required this.color,
    this.todos,
  });

  TaskCard copyWith({
    String? title,
    int? icon,
    String? color,
    List<dynamic>? todos,
  }) {
    return TaskCard(
      title: title ?? this.title,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      todos: todos ?? this.todos,
    );
  }

  factory TaskCard.fromJson(Map<String, dynamic> json) => TaskCard(
        title: json['title'] as String,
        icon: json['icon'] as int,
        color: json['color'] as String,
        todos: json['todos'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'icon': icon,
        'color': color,
        'todos': todos,
      };

  @override
  List<Object> get props {
    return [title, icon, color];
  }
}
