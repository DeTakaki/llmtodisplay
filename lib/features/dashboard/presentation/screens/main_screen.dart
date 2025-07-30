import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:llmtodisplay/constants/app_sizes.dart';
import 'package:llmtodisplay/core/presentation/widgets/custom_text_field.dart';
import 'package:llmtodisplay/core/services/llm_service.dart';
import 'package:llmtodisplay/features/dashboard/cubit/layout_cubit.dart';
import 'package:llmtodisplay/features/dashboard/cubit/layout_state.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit(LLMService()),
      child: const DashboardView(),
    );
  }
}

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final TextEditingController _textController1 = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();
  final _promptTextController = TextEditingController();

  void _handlePrompt() {
    final prompt = _promptTextController.text;
    if (prompt.isEmpty) return;

    context.read<LayoutCubit>().handlePrompt(prompt);
    _promptTextController.clear();
    FocusScope.of(context).unfocus();
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
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
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
                    width: 200,
                    child: ElevatedButton(
                      onPressed: state.isLoading ? null : _handlePrompt,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      child: Text(state.isLoading ? 'Applying...' : 'Apply'),
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
            color: state.containerColor,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: state.contentOpacity,
                    child: CustomTextField(
                      controller: _textController1,
                      labelText: state.hintText1,
                    ),
                  ),
                  const SizedBox(height: Sizes.p8),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: state.contentOpacity,
                    child: CustomTextField(
                      controller: _textController2,
                      labelText: state.hintText2,
                    ),
                  ),
                  const SizedBox(height: Sizes.p8),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    width: state.buttonWidth,
                    height: state.buttonHeight,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Add button action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: state.buttonColor,
                      ),
                      child: const Text('Submit'),
                    ),
                  ),
                  const SizedBox(height: Sizes.p8),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: state.contentOpacity,
                    child: ElevatedButton(
                      onPressed: () =>
                          context.read<LayoutCubit>().resetToDefaults(),
                      child: const Text('Reset to Defaults'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
