import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/app_colors.dart';

/// OTP-style boxed input: one bordered box per character (letters and
/// digits, shown uppercase), backed by a single hidden text field so
/// typing/deleting flows naturally across the boxes.
class OtpStyleInput extends StatefulWidget {
  final TextEditingController controller;
  final int length;
  final ValueChanged<String>? onCompleted;

  const OtpStyleInput({
    super.key,
    required this.controller,
    this.length = 10,
    this.onCompleted,
  });

  @override
  State<OtpStyleInput> createState() => _OtpStyleInputState();
}

class _UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(text: newValue.text.toUpperCase());
  }
}

class _OtpStyleInputState extends State<OtpStyleInput> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fill = theme.inputDecorationTheme.fillColor;
    final isDark = theme.brightness == Brightness.dark;
    final borderColor = isDark
        ? AppColors.white.withValues(alpha: 0.10)
        : AppColors.neutral.withValues(alpha: 0.12);

    return GestureDetector(
      onTap: _focusNode.requestFocus,
      child: Stack(
        children: [
          // Hidden field that actually receives the keyboard input.
          Positioned.fill(
            child: Opacity(
              opacity: 0,
              child: TextField(
                controller: widget.controller,
                focusNode: _focusNode,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.characters,
                maxLength: widget.length,
                showCursor: false,
                autocorrect: false,
                enableSuggestions: false,
                enableInteractiveSelection: false,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
                  _UpperCaseTextFormatter(),
                ],
                decoration: const InputDecoration(counterText: ''),
                onChanged: (value) {
                  if (value.length == widget.length) {
                    widget.onCompleted?.call(value);
                  }
                },
              ),
            ),
          ),
          AnimatedBuilder(
            animation: Listenable.merge([widget.controller, _focusNode]),
            builder: (context, _) {
              final text = widget.controller.text;
              return Row(
                children: List.generate(widget.length, (i) {
                  final digit = i < text.length ? text[i] : '';
                  final isCurrent =
                      _focusNode.hasFocus && i == text.length;
                  return Expanded(
                    child: Container(
                      height: 6.2.h,
                      margin: EdgeInsets.only(
                        right: i == widget.length - 1 ? 0 : 0.7.w,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: fill,
                        borderRadius: BorderRadius.circular(8.sp),
                        border: Border.all(
                          color:
                              isCurrent ? AppColors.primary : borderColor,
                          width: isCurrent ? 1.8 : 1,
                        ),
                      ),
                      child: Text(
                        digit,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}
