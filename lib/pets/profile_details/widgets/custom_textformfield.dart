import 'package:flutter/material.dart';
import '../../../theme/custom_colors.dart';
import '../../../theme/custom_text_styles.dart';

class CustomTextFormFieldActive extends StatefulWidget {
  const CustomTextFormFieldActive({
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

  @override
  State<CustomTextFormFieldActive> createState() =>
      _CustomTextFormFieldActiveState();
}

class _CustomTextFormFieldActiveState extends State<CustomTextFormFieldActive> {
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
    _textEditingController = TextEditingController(text: widget.initialValue);
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 125),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        boxShadow: _isFocused ? kElevationToShadow[2] : kElevationToShadow[0],
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
          suffixIcon: _isFocused
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
              color: getCustomColors(context).hardBorder ?? Colors.transparent,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: getCustomColors(context).lightBorder ?? Colors.transparent,
              width: 0.5,
            ),
          ),
        ),
        onChanged: widget.onChanged,
      ),
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
