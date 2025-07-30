import 'dart:convert';

import 'package:flutter/widgets.dart';

class LayoutChange {
  final double? buttonWidth;
  final double? buttonHeight;
  final String? buttonColor;
  final String? containerColor;
  final String? textfield1;
  final String? textfield2;

  LayoutChange({
    this.buttonWidth,
    this.buttonHeight,
    this.buttonColor,
    this.containerColor,
    this.textfield1,
    this.textfield2,
  });

  factory LayoutChange.fromJson(Map<String, dynamic> json) {
    return LayoutChange(
      buttonWidth: json['buttonWidth']?.toDouble(),
      buttonHeight: json['buttonHeight']?.toDouble(),
      buttonColor: json['buttonColor'],
      containerColor: json['containerColor'],
      textfield1: json['textfield1'],
      textfield2: json['textfield2'],
    );
  }
}

class LLMService {
  static const String _systemPrompt = '''
You are a UI layout assistant. Convert natural language instructions into specific layout changes.
Response must be a JSON object with these possible fields (only include fields that need to change):
{
  "buttonWidth": number (pixels),
  "buttonHeight": number (pixels),
  "buttonColor": string (hex color),
  "containerColor": string (hex color),
  "textfield1": string (label text),
  "textfield2": string (label text)
}

Examples:
"make everything bigger" -> {"buttonWidth": 250, "buttonHeight": 60}
"use dark theme" -> {"buttonColor": "#212121", "containerColor": "#424242"}
"make it colorful" -> {"buttonColor": "#FF4081", "containerColor": "#E1F5FE"}
''';

  /// Interprets natural language into layout changes
  Future<LayoutChange?> interpretLayoutChanges(String prompt) async {
    try {
      // TODO: Replace this with actual LLM API call
      // This would be where you make the API call to your chosen LLM service
      // Example using OpenAI (pseudocode):
      // final response = await openAI.complete({
      //   systemPrompt: _systemPrompt,
      //   userPrompt: prompt,
      //   temperature: 0.7,
      // });

      // For now, returning a mock response
      final mockResponse = _mockLLMResponse(prompt);
      if (mockResponse == null) return null;

      return LayoutChange.fromJson(jsonDecode(mockResponse));
    } catch (e) {
      debugPrint('Error interpreting layout changes: $e');
      return null;
    }
  }

  String? _mockLLMResponse(String prompt) {
    final normalizedPrompt = prompt.toLowerCase();

    if (normalizedPrompt.contains('bigger')) {
      return '{"buttonWidth": 250, "buttonHeight": 60}';
    } else if (normalizedPrompt.contains('dark')) {
      return '{"buttonColor": "#212121", "containerColor": "#424242"}';
    } else if (normalizedPrompt.contains('colorful')) {
      return '{"buttonColor": "#FF4081", "containerColor": "#E1F5FE"}';
    } else if (normalizedPrompt.contains('small') ||
        normalizedPrompt.contains('compact')) {
      return '{"buttonWidth": 80, "buttonHeight": 20, "buttonColor": "#2196F3"}';
    } else if (normalizedPrompt.contains('professional') ||
        normalizedPrompt.contains('business')) {
      return '{"buttonColor": "#0D47A1", "containerColor": "#FFFFFF", "textfield1": "Enter Details", "textfield2": "Additional Information"}';
    }

    return null;
  }
}
