import 'package:flutter/material.dart';

Widget defalutFormfeild({
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged<String>? onFieldSubmitted,
  GestureTapCallback? onTap,
  ValueChanged<String>? onChanged,
  required FormFieldValidator<String> valdiate,
  required String label,
  required IconData prefix,
  bool ispassword = false,
  IconData? suffix,
  Function? suffixpressed,
  bool isClicable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: ispassword,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      onTap: onTap,
      validator: valdiate,
      decoration: InputDecoration(
        labelText: label,
        enabled: isClicable,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixpressed!();
                },
                icon: Icon(suffix))
            : null,
        border: const OutlineInputBorder(),
      ),
    );
Widget buildTaskItem(Map model) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text(
              '${model['time']}',
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${model['title']}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                '${model['date']}',
                style: TextStyle(fontSize: 20, color: Colors.grey[400]),
              )
            ],
          )
        ],
      ),
    );
