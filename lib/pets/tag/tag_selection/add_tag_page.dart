import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:userapp/auth/auth_widgets.dart';
import 'package:userapp/pets/profile_details/widgets/custom_textformfield.dart';
import '../../../utils/widgets/four_grouped_input_formatter.dart';
import '../../profile_details/u_profile_details.dart';
import '../../u_pets.dart';

class AddFinmaTagPage extends StatefulWidget {
  const AddFinmaTagPage({
    super.key,
    required this.petProfileId,
  });

  final int petProfileId;

  @override
  State<AddFinmaTagPage> createState() => _AddFinmaTagPageState();
}

class _AddFinmaTagPageState extends State<AddFinmaTagPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();
  int activationCodeLength = 16;

  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Finma Tag"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 28),
            const Text("Where to find Activition code usw. here :)"),
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.all(16),
              child: CustomTextFormField(
                errorText: errorText,
                textEditingController: _textEditingController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(
                    // activationCodeLength + (activationCodeLength / 4).round() - 1,
                    activationCodeLength,
                  ),
                  // CustomFourGroupedInputFormatter(),
                ],
                labelText: "Enter 16 Symbold Activation Code",
                validator: (val) {
                  if (val != null) {
                    if (val.length == 16) {
                      return null;
                    }
                  }
                  return "Activation Code is 16 Symbols long. lease put ALL of them in here";
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: CustomBigButton(
                label: "Add Finma Tag",
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      errorText = null;
                    });

                    assignTagToUser(_textEditingController.text).then(
                      (tag) {
                        connectTagFromPetProfile(
                                widget.petProfileId, tag.collarTagId)
                            .then((value) => Navigator.pop(context));
                      },
                    ).onError((error, stackTrace) {
                      setState(() {
                        errorText =
                            "Ups...Something appears to be wrong. MAke sure to check the Activation Code again";
                      });
                    });
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
