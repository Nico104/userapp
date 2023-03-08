import 'package:flutter/material.dart';

class CustomTextFormFieldActive extends StatefulWidget {
  const CustomTextFormFieldActive({
    super.key,
    this.hintText,
    this.initialValue,
    this.maxLines,
    this.textInputAction,
    this.onChanged,
    this.keyboardType,
  });

  final String? initialValue;
  final String? hintText;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;

  @override
  State<CustomTextFormFieldActive> createState() =>
      _CustomTextFormFieldActiveState();
}

class _CustomTextFormFieldActiveState extends State<CustomTextFormFieldActive> {
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;
  bool _showSuffix = false;

  @override
  void initState() {
    super.initState();
    initFocusNodes();
  }

  void initFocusNodes() {
    _focusNode = FocusNode();
    _textEditingController = TextEditingController(text: widget.initialValue);
    _focusNode.addListener(() {
      if (_focusNode.hasFocus && !_showSuffix) {
        setState(() {
          _showSuffix = true;
        });
      } else if ((!_focusNode.hasFocus && _showSuffix)) {
        setState(() {
          _showSuffix = false;
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
    return TextFormField(
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      textInputAction: widget.textInputAction,
      focusNode: _focusNode,
      controller: _textEditingController,
      cursorColor: Colors.black.withOpacity(0.74),
      decoration: InputDecoration(
        hintText: widget.hintText,
        // labelText: "Oner",
        fillColor: Colors.white,
        filled: true,
        suffixIconColor: Colors.grey,
        suffixIcon: _showSuffix
            ? GestureDetector(
                onTap: () {
                  _textEditingController.clear();
                },
                child: const Icon(Icons.delete),
              )
            : null,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.5,
          ),
        ),
      ),
      onChanged: widget.onChanged,
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
  bool _showSuffix = false;

  @override
  void initState() {
    super.initState();
    initFocusNodes();
  }

  void initFocusNodes() {
    _focusNode = FocusNode();
    _textEditingController = TextEditingController();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus && !_showSuffix) {
        setState(() {
          _showSuffix = true;
        });
      } else if ((!_focusNode.hasFocus && _showSuffix)) {
        setState(() {
          _showSuffix = false;
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
    return TextFormField(
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      textInputAction: widget.textInputAction,
      focusNode: _focusNode,
      controller: _textEditingController,
      cursorColor: const Color(0xFF707070).withOpacity(0.28),
      decoration: InputDecoration(
        hintText: widget.hintText,
        fillColor: Colors.white,
        filled: true,
        suffixIconColor: Colors.grey,
        suffixIcon: _showSuffix
            ? GestureDetector(
                onTap: () {
                  _textEditingController.clear();
                },
                child: const Icon(Icons.delete),
              )
            : null,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: const Color(0xFF707070).withOpacity(0.28),
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: const Color(0xFF707070).withOpacity(0.28),
            width: 1.5,
          ),
        ),
      ),
      onChanged: widget.onChanged,
    );
  }
}
