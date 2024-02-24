import 'package:flutter/material.dart';
import 'package:to_do_application/my_theme.dart';

class TitleAndDropDownWidget extends StatefulWidget {
  String title;
  List<String> content;

  String selectedLanguage = '';

  TitleAndDropDownWidget(
      {super.key, required this.title, required this.content}) {
    selectedLanguage = content[0];
  }

  @override
  State<TitleAndDropDownWidget> createState() => _TitleAndDropDownWidgetState();
}

class _TitleAndDropDownWidgetState extends State<TitleAndDropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.title,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: MyTheme.blackColor),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: MyTheme.wightColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: MyTheme.primaryColor, width: 3),
            ),
            child: DropdownButton<String>(
              value: widget.selectedLanguage,
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              style: TextStyle(color: MyTheme.primaryColor, fontSize: 18),
              underline: Container(
                color: Colors.transparent,
              ),
              onChanged: (newValue) {
                setState(() {
                  widget.selectedLanguage = newValue!;
                });
              },
              items:
                  widget.content.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
