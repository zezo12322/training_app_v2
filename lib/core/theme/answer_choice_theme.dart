import 'package:flutter/material.dart';

/// Theme extension to customize quiz answer choice appearance.
class AnswerChoiceTheme extends ThemeExtension<AnswerChoiceTheme> {
  final Color selectedBorder;
  final Color selectedBackground;
  final Color unselectedBorder;
  final Color selectedIcon;
  final Color unselectedIcon;
  final TextStyle? selectedTextStyle;
  final TextStyle? unselectedTextStyle;

  const AnswerChoiceTheme({
    required this.selectedBorder,
    required this.selectedBackground,
    required this.unselectedBorder,
    required this.selectedIcon,
    required this.unselectedIcon,
    this.selectedTextStyle,
    this.unselectedTextStyle,
  });

  @override
  AnswerChoiceTheme copyWith({
    Color? selectedBorder,
    Color? selectedBackground,
    Color? unselectedBorder,
    Color? selectedIcon,
    Color? unselectedIcon,
    TextStyle? selectedTextStyle,
    TextStyle? unselectedTextStyle,
  }) => AnswerChoiceTheme(
    selectedBorder: selectedBorder ?? this.selectedBorder,
    selectedBackground: selectedBackground ?? this.selectedBackground,
    unselectedBorder: unselectedBorder ?? this.unselectedBorder,
    selectedIcon: selectedIcon ?? this.selectedIcon,
    unselectedIcon: unselectedIcon ?? this.unselectedIcon,
    selectedTextStyle: selectedTextStyle ?? this.selectedTextStyle,
    unselectedTextStyle: unselectedTextStyle ?? this.unselectedTextStyle,
  );

  @override
  AnswerChoiceTheme lerp(ThemeExtension<AnswerChoiceTheme>? other, double t) {
    if (other is! AnswerChoiceTheme) return this;
    return AnswerChoiceTheme(
      selectedBorder:
          Color.lerp(selectedBorder, other.selectedBorder, t) ?? selectedBorder,
      selectedBackground:
          Color.lerp(selectedBackground, other.selectedBackground, t) ??
          selectedBackground,
      unselectedBorder:
          Color.lerp(unselectedBorder, other.unselectedBorder, t) ??
          unselectedBorder,
      selectedIcon:
          Color.lerp(selectedIcon, other.selectedIcon, t) ?? selectedIcon,
      unselectedIcon:
          Color.lerp(unselectedIcon, other.unselectedIcon, t) ?? unselectedIcon,
      selectedTextStyle: TextStyle.lerp(
        selectedTextStyle,
        other.selectedTextStyle,
        t,
      ),
      unselectedTextStyle: TextStyle.lerp(
        unselectedTextStyle,
        other.unselectedTextStyle,
        t,
      ),
    );
  }
}
