import 'package:equatable/equatable.dart';

class ASCalendarPanelSwitcherOption<T> extends Equatable {
  final T type;
  final String title;
  final bool isActive;
  final Function(T) onChanged;

  const ASCalendarPanelSwitcherOption(
      {required this.title, required this.onChanged, required this.isActive, required this.type});

  @override
  List<Object?> get props => [title, isActive, onChanged, type];

  ASCalendarPanelSwitcherOption<T> copyWith({
    T? type,
    String? title,
    bool? isActive,
    Function(T)? onChanged,
  }) {
    return ASCalendarPanelSwitcherOption(
      type: type ?? this.type,
      title: title ?? this.title,
      isActive: isActive ?? this.isActive,
      onChanged: onChanged ?? this.onChanged,
    );
  }
}
