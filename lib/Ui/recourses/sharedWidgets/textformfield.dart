import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {required this.hint,
      this.validator,
      this.minLines,
      super.key,
      this.onChanged,
      this.readOnly = false,
      this.autovalidate = false,
      this.autofocus = false,
      this.label = "",
      this.keybordtupe = TextInputType.number,
      required this.width,
      required this.controller,
      this.ontap,
      this.oneditcomplete,
      this.onsave,
      this.onsubmitted,
      this.focuasnode,
      this.textInputAction = TextInputAction.unspecified});
  final TextInputType keybordtupe;
  final String hint;
  final FocusNode? focuasnode;
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final String? Function(String?)? onsubmitted;
  final String? Function()? ontap;
  final String? Function()? oneditcomplete;
  final String? Function(String?)? onsave;
  final double width;
  final int? minLines;
  final bool autovalidate;
  final bool autofocus;
  final bool readOnly;
  final TextInputAction textInputAction;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: width,
          child: TextFormField(
              minLines: minLines,
              focusNode: focuasnode,
              textDirection: TextDirection.ltr,
              enableInteractiveSelection: true,
              onEditingComplete: oneditcomplete,
              textAlign: TextAlign.end,
              textInputAction: TextInputAction.unspecified,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: const TextStyle(
                  color: Colors.blue, fontWeight: FontWeight.w500),
              autofocus: autofocus,
              onFieldSubmitted: onsubmitted,
              readOnly: readOnly,
              onTap: ontap,
              onSaved: onsave,
              onChanged: onChanged,
              inputFormatters: const [],
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validator,
              controller: controller,
              decoration: InputDecoration(
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.teal)),
                  border: const OutlineInputBorder(),
                  hintText: hint,
                  labelText: label.isEmpty ? hint : label,
                  labelStyle: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  fillColor: const Color.fromARGB(31, 184, 161, 161),
                  filled: true)),
        ),
      ],
    );
  }
}
