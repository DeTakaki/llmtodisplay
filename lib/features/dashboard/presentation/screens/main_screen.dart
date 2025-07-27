import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:llmtodisplay/constants/app_sizes.dart';
import 'package:llmtodisplay/core/presentation/widgets/custom_text_field.dart';
import 'package:llmtodisplay/core/services/llm_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final TextEditingController _textController1 = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();
  final _promptTextController = TextEditingController();
  Map<String, dynamic>? _prompts;

  @override
  void initState() {
    super.initState();
    _loadPrompts();
  }

  Future<void> _loadPrompts() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'lib/stubs/prompts.json',
      );
      setState(() {
        _prompts = json.decode(jsonString);
      });
    } catch (e) {
      debugPrint('Error loading prompts: $e');
    }
  }

  final _llmService = LLMService();

  Future<void> _handlePrompt() async {
    final prompt = _promptTextController.text;
    if (prompt.isEmpty) return;

    // First fade out
    setState(() {
      _contentOpacity = 0.0;
    });

    // Get layout changes from LLM
    final layoutChange = await _llmService.interpretLayoutChanges(prompt);

    if (layoutChange != null) {
      // Wait for fade out animation
      await Future.delayed(const Duration(milliseconds: 300));

      setState(() {
        // Update button dimensions if provided
        if (layoutChange.buttonWidth != null) {
          _buttonWidth = layoutChange.buttonWidth!;
        }
        if (layoutChange.buttonHeight != null) {
          _buttonHeight = layoutChange.buttonHeight!;
        }

        // Update colors if provided
        if (layoutChange.buttonColor != null) {
          _buttonColor = Color(
            int.parse(layoutChange.buttonColor!.replaceAll('#', '0xFF')),
          );
        }
        if (layoutChange.containerColor != null) {
          _containerColor = Color(
            int.parse(layoutChange.containerColor!.replaceAll('#', '0xFF')),
          );
        }

        // Update text fields if provided
        if (layoutChange.textfield1 != null) {
          _hintText1 = layoutChange.textfield1!;
        }
        if (layoutChange.textfield2 != null) {
          _hintText2 = layoutChange.textfield2!;
        }
      });

      // Fade back in
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() {
        _contentOpacity = 1.0;
      });
    } else {
      // If no changes, just fade back in
      setState(() {
        _contentOpacity = 1.0;
      });
    }

    // Clear the prompt field after applying changes
    _promptTextController.clear();
    FocusScope.of(context).unfocus();
  }

  // Default values
  static const defaultButtonWidth = 120.0;
  static const defaultButtonHeight = 40.0;
  static const defaultButtonColor = Colors.blue;
  static const defaultContainerColor = Color(0xFFEEEEEE); // Colors.grey[200]
  static const defaultHintText1 = 'First Input';
  static const defaultHintText2 = 'Second Input';

  double _buttonWidth = defaultButtonWidth;
  double _buttonHeight = defaultButtonHeight;
  Color _buttonColor = defaultButtonColor;
  Color _containerColor = defaultContainerColor;
  String _hintText1 = defaultHintText1;
  String _hintText2 = defaultHintText2;
  double _contentOpacity = 1.0;

  void _resetToDefaults() {
    setState(() {
      _buttonWidth = defaultButtonWidth;
      _buttonHeight = defaultButtonHeight;
      _buttonColor = defaultButtonColor;
      _containerColor = defaultContainerColor;
      _hintText1 = defaultHintText1;
      _hintText2 = defaultHintText2;
    });
  }

  @override
  void dispose() {
    _textController1.dispose();
    _textController2.dispose();
    _promptTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Dashboard'),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(Sizes.p8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(77),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: Sizes.p8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                controller: _promptTextController,
                hintText: 'Apply changes to layout here',
              ),
              const SizedBox(height: Sizes.p8),
              SizedBox(
                width: 200, // Fixed width for the button
                child: ElevatedButton(
                  onPressed: () => _handlePrompt(),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('Apply'),
                ),
              ),
            ],
          ),
        ),
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        height: double.infinity,
        padding: const EdgeInsets.all(Sizes.p8),
        color: _containerColor,
        child: Center(
          child: Column(
            spacing: Sizes.p8,
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _contentOpacity,
                child: CustomTextField(
                  controller: _textController1,
                  labelText: _hintText1,
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _contentOpacity,
                child: CustomTextField(
                  controller: _textController2,
                  labelText: _hintText2,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                width: _buttonWidth,
                height: _buttonHeight,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Add button action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _buttonColor,
                  ),
                  child: const Text('Submit'),
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _contentOpacity,
                child: ElevatedButton(
                  onPressed: _resetToDefaults,
                  child: const Text('Reset to Defaults'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
