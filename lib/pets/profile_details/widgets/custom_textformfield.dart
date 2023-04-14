import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:userapp/theme/theme_provider.dart';
import '../../../theme/custom_colors.dart';
import '../../../theme/custom_text_styles.dart';

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
  });

  final String? initialValue;
  final String? hintText;
  final int? maxLines;
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
    _focusNode = FocusNode();
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

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, _) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 125),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            boxShadow: (_isFocused && !widget.ignoreBoxShadow)
                ? kElevationToShadow[2]
                : kElevationToShadow[0],
            // boxShadow: [
            //   BoxShadow(
            //     color: _isFocused
            //         ? getCustomColors(context).shadow ?? Colors.transparent
            //         : getCustomColors(context).lightShadow ?? Colors.transparent,
            //     blurRadius: _isFocused ? 8 : 6,
            //     offset: const Offset(1, 3), // changes position of shadow
            //   ),
            // ],
          ),
          child: TextFormField(
            expands: widget.expands,
            textAlignVertical: widget.expands ? TextAlignVertical.top : null,
            obscureText: _obscureText,
            validator: widget.validator,
            autofocus: widget.autofocus,
            keyboardType: widget.keyboardType,
            maxLines: widget.isPassword ? 1 : widget.maxLines,
            textInputAction: widget.textInputAction,
            focusNode: _focusNode,
            controller: _textEditingController,
            cursorColor: getCustomColors(context).hardBorder,
            style: Theme.of(context).textTheme.labelMedium,
            decoration: InputDecoration(
              alignLabelWithHint: widget.expands ? true : null,
              errorText: widget.errorText,
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 0.5,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
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
                          _textEditingController.clear();
                        }
                      },
                      child: Icon(
                        _getSuffix(widget.isPassword, _obscureText),
                      ),
                    )
                  : null,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: BorderSide(
                  color:
                      getCustomColors(context).hardBorder ?? Colors.transparent,
                  width: (theme.getTheme().brightness == Brightness.dark)
                      ? 2.5
                      : 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
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

// class CustomTextFormFieldInactive extends StatefulWidget {
//   const CustomTextFormFieldInactive({
//     super.key,
//     this.hintText,
//     this.maxLines,
//     this.textInputAction,
//     this.onChanged,
//     this.keyboardType,
//   });

//   final String? hintText;
//   final int? maxLines;
//   final TextInputAction? textInputAction;
//   final Function(String)? onChanged;
//   final TextInputType? keyboardType;

//   @override
//   State<CustomTextFormFieldInactive> createState() =>
//       _CustomTextFormFieldInactiveState();
// }

// class _CustomTextFormFieldInactiveState
//     extends State<CustomTextFormFieldInactive> {
//   late TextEditingController _textEditingController;
//   late FocusNode _focusNode;
//   bool _isFocused = false;

//   @override
//   void initState() {
//     super.initState();
//     initFocusNodes();
//   }

//   void initFocusNodes() {
//     _focusNode = FocusNode();
//     _textEditingController = TextEditingController();
//     _focusNode.addListener(() {
//       if (_focusNode.hasFocus && !_isFocused) {
//         setState(() {
//           _isFocused = true;
//         });
//       } else if ((!_focusNode.hasFocus && _isFocused)) {
//         setState(() {
//           _isFocused = false;
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _focusNode.dispose();
//     _textEditingController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 125),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(2),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(_isFocused ? 0.16 : 0.04),
//             blurRadius: _isFocused ? 8 : 6,
//             offset: const Offset(1, 3), // changes position of shadow
//           ),
//         ],
//       ),
//       child: TextFormField(
//         keyboardType: widget.keyboardType,
//         maxLines: widget.maxLines,
//         textInputAction: widget.textInputAction,
//         focusNode: _focusNode,
//         controller: _textEditingController,
//         cursorColor: const Color(0xFF707070).withOpacity(0.28),
//         style: textFieldText,
//         decoration: InputDecoration(
//           hintText: widget.hintText,
//           hintStyle: textFieldHint,
//           fillColor: Colors.white,
//           filled: true,
//           suffixIconColor: Colors.grey,
//           suffixIcon: _isFocused
//               ? GestureDetector(
//                   onTap: () {
//                     _textEditingController.clear();
//                   },
//                   child: const Icon(Icons.delete),
//                 )
//               : null,
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(2),
//             borderSide: BorderSide(
//               color: Colors.black.withOpacity(0.84),
//               width: 1,
//             ),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8),
//             borderSide: BorderSide(
//               color: Colors.black.withOpacity(0.24),
//               width: 0.5,
//             ),
//           ),
//         ),
//         onChanged: widget.onChanged,
//       ),
//     );
//   }
// }
