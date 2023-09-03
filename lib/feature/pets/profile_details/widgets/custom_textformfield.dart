import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:userapp/general/utils_theme/theme_provider.dart';
import '../../../../general/utils_theme/custom_colors.dart';
import '../../../../general/utils_theme/custom_text_styles.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.initialValue,
    this.maxLines,
    this.textInputAction,
    this.onChanged,
    this.keyboardType,
    this.autofocus = false,
    this.errorText,
    this.labelText,
    this.validator,
    this.isPassword = false,
    this.textEditingController,
    this.ignoreBoxShadow = false,
    this.thickUnfocusedBorder = false,
    this.showSuffix = true,
    this.expands = false,
    this.prefix,
    this.inputFormatters,
    this.confirmDeleteDialog,
    this.focusNode,
    this.maxLenght,
  });

  final String? initialValue;
  final String? hintText;
  final int? maxLines;
  final int? maxLenght;
  final TextInputAction? textInputAction;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool autofocus;

  final String? labelText;
  final String? errorText;
  final String? Function(String?)? validator;
  final bool isPassword;
  final bool showSuffix;

  final bool thickUnfocusedBorder;
  final bool expands;

  final TextEditingController? textEditingController;
  //TODO Breaks shadow when showing error for some reason
  final bool ignoreBoxShadow;

  final Widget? prefix;
  final List<TextInputFormatter>? inputFormatters;

  final Widget? confirmDeleteDialog;

  final FocusNode? focusNode;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;
  bool _isFocused = false;

  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    initFocusNodes();
    if (widget.isPassword) {
      _obscureText = true;
    } else {
      _obscureText = false;
    }
  }

  void initFocusNodes() {
    if (widget.focusNode != null) {
      _focusNode = widget.focusNode!;
    } else {
      _focusNode = FocusNode();
    }
    if (widget.textEditingController != null) {
      _textEditingController =
          widget.textEditingController ?? TextEditingController();
    } else {
      _textEditingController = TextEditingController(text: widget.initialValue);
    }

    _focusNode.addListener(() {
      if (_focusNode.hasFocus && !_isFocused) {
        setState(() {
          _isFocused = true;
        });
      } else if ((!_focusNode.hasFocus && _isFocused)) {
        setState(() {
          _isFocused = false;
        });
      }
    });
  }

  void clearTextInput() {
    _textEditingController.clear();
    if (widget.onChanged != null) {
      widget.onChanged!("");
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, _) {
        return Stack(
          children: [
            AnimatedContainer(
              // height: ,
              duration: const Duration(milliseconds: 125),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: (_isFocused && !widget.ignoreBoxShadow)
                    ? kElevationToShadow[2]
                    : kElevationToShadow[0],
              ),
              child: TextFormField(
                enabled: false,
              ),
            ),
            TextFormField(
              inputFormatters: widget.inputFormatters,
              expands: widget.expands,
              textAlignVertical: widget.expands ? TextAlignVertical.top : null,
              obscureText: _obscureText,
              validator: widget.validator,
              autofocus: widget.autofocus,
              keyboardType: widget.keyboardType,
              maxLines: widget.isPassword ? 1 : widget.maxLines,
              maxLength: widget.maxLenght,
              textInputAction: widget.textInputAction,
              // focusNode: widget.focusNode,
              focusNode: _focusNode,
              controller: _textEditingController,
              cursorColor: getCustomColors(context).hardBorder,
              style: Theme.of(context).textTheme.labelMedium,
              decoration: InputDecoration(
                alignLabelWithHint: widget.expands ? true : null,
                errorText: widget.errorText,
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 0.5,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 1,
                  ),
                ),
                hintText: (widget.hintText != null && widget.labelText == null)
                    ? widget.hintText
                    : null,
                labelText: (widget.hintText == null && widget.labelText != null)
                    ? widget.labelText
                    : null,
                hintStyle: getCustomTextStyles(context).textFormFieldHint,
                labelStyle: getCustomTextStyles(context).textFormFieldLabel,
                fillColor: Theme.of(context).primaryColor,
                filled: true,
                //TODO suffixColor
                suffixIconColor: getCustomColors(context).hardBorder,
                suffixIcon: (_isFocused && widget.showSuffix)
                    ? GestureDetector(
                        onTap: () {
                          if (widget.isPassword) {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          } else {
                            if (widget.confirmDeleteDialog != null) {
                              showDialog(
                                context: context,
                                builder: (_) => widget.confirmDeleteDialog!,
                              ).then((value) {
                                if (value != null && value is bool) {
                                  if (value == true) {
                                    clearTextInput();
                                  }
                                }
                              });
                            } else {
                              clearTextInput();
                            }
                          }
                        },
                        child: Icon(
                          _getSuffix(widget.isPassword, _obscureText),
                        ),
                      )
                    : null,
                prefixIcon: widget.prefix,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: getCustomColors(context).hardBorder ??
                        Colors.transparent,
                    width: (theme.getTheme().brightness == Brightness.dark)
                        ? 1.5
                        : 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: widget.thickUnfocusedBorder
                        ? (getCustomColors(context).hardBorder ??
                                Colors.transparent)
                            .withOpacity(0.5)
                        : getCustomColors(context).lightBorder ??
                            Colors.transparent,
                    width: widget.thickUnfocusedBorder ? 1 : 0.5,
                  ),
                ),
              ),
              onChanged: widget.onChanged,
            ),
          ],
        );
      },
    );
  }
}

IconData _getSuffix(bool isPassword, bool obscureOn) {
  if (isPassword && obscureOn) {
    return Icons.visibility_outlined;
  } else if (isPassword && !obscureOn) {
    return Icons.visibility_off_outlined;
  } else {
    return Icons.delete;
  }
}
