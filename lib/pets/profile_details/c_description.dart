import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:userapp/pets/profile_details/models/m_description.dart';

import '../../language/m_language.dart';
import '../../styles/text_styles.dart';
import 'c_component_title.dart';
import '../../language/c_language_selection.dart';

class PetDescriptionComponent extends StatefulWidget {
  const PetDescriptionComponent({
    super.key,
    required this.descriptions,
    // required this.addDescription,
    // required this.removeDescription,
  });

  //Pictures
  final List<Description> descriptions;

  @override
  State<PetDescriptionComponent> createState() =>
      _PetDescriptionComponentState();
}

class _PetDescriptionComponentState extends State<PetDescriptionComponent> {
  // final ValueSetter<Description> addDescription;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ComponentTitle(text: "Description"),
        ListView.builder(
          itemCount: widget.descriptions.length + 1,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            if (index == widget.descriptions.length) {
              return NewDescriptionTranslation(
                descriptions: widget.descriptions,
                addNewDescription: (text, language) {
                  setState(() {
                    widget.descriptions.add(Description(text, language));
                  });
                },
              );
            } else {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: DescriptionTranslation(
                  //Pass by reference
                  description: widget.descriptions.elementAt(index),
                  index: index,
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

class DescriptionTranslation extends StatelessWidget {
  const DescriptionTranslation({
    super.key,
    required this.index,
    required this.description,
  });

  final Description description;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            initialValue: description.text,
            decoration: InputDecoration(
              hintText: "Enter Description",
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.grey.shade600,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1.25,
                ),
              ),
            ),
            onChanged: (value) {
              EasyDebounce.debounce(
                'description$index',
                const Duration(milliseconds: 500),
                () => description.text = value,
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 16),
          child: Container(
            height: 50,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade500),
              color: Colors.grey.shade100,
            ),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(description.language.languageImagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )),
          ),
        )
      ],
    );
  }
}

class NewDescriptionTranslation extends StatelessWidget {
  NewDescriptionTranslation({
    super.key,
    required this.addNewDescription,
    required this.descriptions,
  });

  final List<Description> descriptions;
  final Function(String text, Language language) addNewDescription;

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextFormField(
            controller: _controller,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              labelText: "Add new Translation",
              labelStyle: newDescriptionLabel,
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.grey.shade600,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 16),
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => LanguagePickerDialogComponent(
                  excludeLanguageCodes:
                      isolateLanguageCodesFromDescription(descriptions),
                ),
              ).then((value) {
                if (value != null) {
                  addNewDescription(_controller.text, value);
                }
              });
            },
            child: Container(
              height: 50,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
                color: Colors.grey.shade50,
              ),
              child: const Center(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox.expand(
                  child: FittedBox(
                    child: Icon(Icons.language),
                  ),
                ),
              )),
            ),
          ),
        )
      ],
    );
  }
}
