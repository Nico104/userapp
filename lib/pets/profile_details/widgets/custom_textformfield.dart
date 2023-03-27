import 'package:flutter/material.dart';

import '../../../styles/text_styles.dart';

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
  });

  final String? initialValue;
  final String? hintText;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool autofocus;

  @override
  State<CustomTextFormFieldActive> createState() =>
      _CustomTextFormFieldActiveState();
}

class _CustomTextFormFieldActiveState extends State<CustomTextFormFieldActive> {
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    initFocusNodes();
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(_isFocused ? 0.16 : 0.04),
            blurRadius: _isFocused ? 8 : 6,
            offset: const Offset(1, 3), // changes position of shadow
          ),
        ],
      ),
      child: TextFormField(
        autofocus: widget.autofocus,
        keyboardType: widget.keyboardType,
        maxLines: widget.maxLines,
        textInputAction: widget.textInputAction,
        focusNode: _focusNode,
        controller: _textEditingController,
        cursorColor: Colors.black.withOpacity(0.74),
        style: textFieldText,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: textFieldHint,
          fillColor: Colors.white,
          filled: true,
          suffixIconColor: Colors.grey,
          suffixIcon: _isFocused
              ? GestureDetector(
                  onTap: () {
                    _textEditingController.clear();
                  },
                  child: const Icon(Icons.delete),
                )
              : null,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.84),
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.24),
              width: 0.5,
            ),
          ),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}

class CustomTextFormFieldInactive extends StatefulWidget {
  const CustomTextFormFieldInactive({
    super.key,
    this.hintText,
    this.maxLines,
    this.textInputAction,
    this.onChanged,
    this.keyboardType,
  });

  final String? hintText;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;

  @override
  State<CustomTextFormFieldInactive> createState() =>
      _CustomTextFormFieldInactiveState();
}

class _CustomTextFormFieldInactiveState
    extends State<CustomTextFormFieldInactive> {
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    initFocusNodes();
  }

  void initFocusNodes() {
    _focusNode = FocusNode();
    _textEditingController = TextEditingController();
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(_isFocused ? 0.16 : 0.04),
            blurRadius: _isFocused ? 8 : 6,
            offset: const Offset(1, 3), // changes position of shadow
          ),
        ],
      ),
      child: TextFormField(
        keyboardType: widget.keyboardType,
        maxLines: widget.maxLines,
        textInputAction: widget.textInputAction,
        focusNode: _focusNode,
        controller: _textEditingController,
        cursorColor: const Color(0xFF707070).withOpacity(0.28),
        style: textFieldText,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: textFieldHint,
          fillColor: Colors.white,
          filled: true,
          suffixIconColor: Colors.grey,
          suffixIcon: _isFocused
              ? GestureDetector(
                  onTap: () {
                    _textEditingController.clear();
                  },
                  child: const Icon(Icons.delete),
                )
              : null,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.84),
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.24),
              width: 0.5,
            ),
          ),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
