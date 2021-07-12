import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RectangleTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextInputType? textInputType;
  final bool? obscureText;
  final EdgeInsets? padding;

  const RectangleTextField({
    @required this.controller,
    this.hint,
    this.focusNode,
    this.nextFocusNode,
    this.textInputType,
    this.obscureText,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Container(
          padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
          width: 300,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 12,
                    offset: Offset(0, 4))
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                textDirection: TextDirection.ltr,
                textAlignVertical: TextAlignVertical.center,
                maxLines: 1,
                keyboardType: textInputType ?? TextInputType.text,
                keyboardAppearance: Brightness.dark,
                focusNode: focusNode,
                onFieldSubmitted: (value) =>
                    FocusScope.of(context).requestFocus(nextFocusNode),
                obscureText: obscureText ?? false,
                textAlign: TextAlign.start,
                cursorColor: Theme.of(context).primaryColor,
                controller: controller,
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    ?.copyWith(fontSize: 16),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 1)),
                    errorStyle: TextStyle(fontSize: 0, color: Colors.red),
                    errorText: "",
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 1)),
                    errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 0.35)),
                    disabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0.35),
                    ),
                    hintText: hint,
                    hintStyle: Theme.of(context).textTheme.headline5?.copyWith(
                        fontSize: 14, fontWeight: FontWeight.normal)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return null;
                  }
                  return "";
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
