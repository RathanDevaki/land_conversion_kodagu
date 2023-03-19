import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/application_provider.dart';

// class DropDowno extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Custom Dropdown Demo',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Custom Dropdown Demo'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               CustomDropdown(
//                 items: ['Option 1', 'Option 2', 'Option 3'],
//                 hint: 'Select an option',
//                 onChanged: (value) {
//                   print('Selected value: $value');
//                 },
//                 validator: (value) {
//                   if (value == null) {
//                     return 'Please select an option';
//                   }
//                   return null;
//                 },
//               ),
//               CustomDropdown(
//                 items: ['1', '2 2', ' 3'],
//                 hint: 'Please select option',
//                 onChanged: (value) {
//                   print('Selected value 2: $value');
//                 },
//                 validator: (value) {
//                   if (value == null) {
//                     return 'La Espada';
//                   }
//                   return null;
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String hint;
  final Function(String?) onChanged;
  final Function(String?) validator;
  final String? value;

  CustomDropdown({
    required this.items,
    required this.hint,
    required this.onChanged,
    required this.validator,
    required this.value,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? _value;

  @override
  Widget build(BuildContext context) {
    ApplicationProvider provider =
        Provider.of<ApplicationProvider>(context, listen: false);
    return Container(
      child: DropdownButtonFormField<String>(
        value: widget.value,
        onChanged: (value) {
          setState(() {
            log('=>Login ${provider.selectedMain}');
            _value = value;
            widget.onChanged(value);
          });
        },
        isExpanded: true,
        decoration: InputDecoration(
          labelText: widget.hint,
          labelStyle: TextStyle(fontSize: 14),
          fillColor: Colors.amber,
        ),
        items: widget.items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        validator: (value) {
          return widget.validator(value);
        },
      ),
    );
  }
}
