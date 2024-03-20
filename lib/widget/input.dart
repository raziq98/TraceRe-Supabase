import 'package:flutter/material.dart';

import '../utilities/theme.dart';

class txtFormField extends StatefulWidget {
  const txtFormField(
      {super.key,
      this.isEdit,
      this.isEditable,
      this.texthint,
      required this.controller,
      this.text});
  final bool? isEdit, isEditable;
  final TextEditingController controller;
  final String? texthint;
  final String? text;

  @override
  State<txtFormField> createState() => _txtFormFieldState();
}

class _txtFormFieldState extends State<txtFormField> {
  @override
  void initState() {
    super.initState();
    if (widget.text != null || widget.text != '') {
      widget.controller.text = widget.text ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: TextFormField(
        controller: widget.controller,
        style: ThemeConstant.blackTextBold18,
        enabled: widget.isEdit == true
            ? widget.isEditable == true
                ? true
                : false
            : false,
        autofocus: true,
        decoration: InputDecoration(
          label: Text(
            widget.texthint ?? '',
            style: ThemeConstant.blackTextBold18,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: ThemeConstant.trcGreen, width: 3),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: ThemeConstant.trcBlue, width: 3),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        readOnly: widget.isEdit == false ? true : false,
      ),
    );
  }
}
