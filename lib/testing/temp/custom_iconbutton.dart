import 'package:flutter/material.dart';

import '../../View/upload.dart';

class CustomIconButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function(BuildContext) onPressed;
  const CustomIconButton(
      {Key? key,
      required this.text,
      required this.icon,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
      constraints: BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: ElevatedButton(
        onPressed: () => onPressed(context),
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => Upload(),
        //     ));

        //  color: Theme.of(context).accentColor,
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                Icon(
                  icon,
                  color: Colors.red,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
