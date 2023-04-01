import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/auth/auth_widgets.dart';

import '../../../pets/profile_details/widgets/custom_textformfield.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final TextEditingController _textEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Us"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 28, right: 28),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 32),
              Container(
                width: 55.w,
                height: 55.w,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: const DecorationImage(
                    image: NetworkImage("https://picsum.photos/500"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: kElevationToShadow[2],
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: CustomTextFormField(
                  textEditingController: _textEditingController,
                  ignoreBoxShadow: true,
                  thickUnfocusedBorder: true,
                  maxLines: null,
                  showSuffix: false,
                  expands: true,
                  labelText: "Send us a Message",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'I cannot be empty mate';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              const SizedBox(height: 28),
              CustomBigButton(
                label: "Send",
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    print(_textEditingController.text);
                  }
                },
              ),
              const SizedBox(height: 42),
            ],
          ),
        ),
      ),
    );
  }
}
