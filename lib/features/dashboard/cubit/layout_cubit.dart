import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:llmtodisplay/core/services/llm_service.dart';
import 'package:llmtodisplay/features/dashboard/cubit/layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  final LLMService _llmService;

  LayoutCubit(this._llmService) : super(LayoutState.initial());

  Future<void> handlePrompt(String prompt) async {
    if (prompt.isEmpty) return;

    // Fade out
    emit(state.copyWith(contentOpacity: 0.0, isLoading: true));
    await Future.delayed(const Duration(milliseconds: 300));

    // Get layout changes
    final layoutChange = await _llmService.interpretLayoutChanges(prompt);

    if (layoutChange != null) {
      // Update state with new values
      emit(
        state.copyWith(
          buttonWidth: layoutChange.buttonWidth,
          buttonHeight: layoutChange.buttonHeight,
          buttonColor: layoutChange.buttonColor != null
              ? Color(
                  int.parse(layoutChange.buttonColor!.replaceAll('#', '0xFF')),
                )
              : null,
          containerColor: layoutChange.containerColor != null
              ? Color(
                  int.parse(
                    layoutChange.containerColor!.replaceAll('#', '0xFF'),
                  ),
                )
              : null,
          hintText1: layoutChange.textfield1,
          hintText2: layoutChange.textfield2,
        ),
      );
    }

    // Fade back in
    await Future.delayed(const Duration(milliseconds: 100));
    emit(state.copyWith(contentOpacity: 1.0, isLoading: false));
  }

  void resetToDefaults() {
    emit(LayoutState.initial());
  }
}
