import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../models/m_document.dart';

class DocumentListTile extends StatelessWidget {
  const DocumentListTile({super.key, required this.document});

  final Document document;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(document.documentName),
      ],
    );
  }
}
