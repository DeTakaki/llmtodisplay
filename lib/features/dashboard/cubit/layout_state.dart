import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class LayoutState extends Equatable {
  final double buttonWidth;
  final double buttonHeight;
  final Color buttonColor;
  final Color containerColor;
  final String hintText1;
  final String hintText2;
  final double contentOpacity;
  final bool isLoading;

  const LayoutState({
    required this.buttonWidth,
    required this.buttonHeight,
    required this.buttonColor,
    required this.containerColor,
    required this.hintText1,
    required this.hintText2,
    this.contentOpacity = 1.0,
    this.isLoading = false,
  });

  factory LayoutState.initial() => const LayoutState(
    buttonWidth: 120.0,
    buttonHeight: 40.0,
    buttonColor: Colors.blue,
    containerColor: Color(0xFFEEEEEE),
    hintText1: 'First Input',
    hintText2: 'Second Input',
  );

  LayoutState copyWith({
    double? buttonWidth,
    double? buttonHeight,
    Color? buttonColor,
    Color? containerColor,
    String? hintText1,
    String? hintText2,
    double? contentOpacity,
    bool? isLoading,
  }) {
    return LayoutState(
      buttonWidth: buttonWidth ?? this.buttonWidth,
      buttonHeight: buttonHeight ?? this.buttonHeight,
      buttonColor: buttonColor ?? this.buttonColor,
      containerColor: containerColor ?? this.containerColor,
      hintText1: hintText1 ?? this.hintText1,
      hintText2: hintText2 ?? this.hintText2,
      contentOpacity: contentOpacity ?? this.contentOpacity,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
    buttonWidth,
    buttonHeight,
    buttonColor,
    containerColor,
    hintText1,
    hintText2,
    contentOpacity,
    isLoading,
  ];
}
