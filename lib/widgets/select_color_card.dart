import 'package:flutter/material.dart';

class SelectColorCard extends StatelessWidget {
  final Function onTap;
  final Color color;
  final String title;

  const SelectColorCard({
    Key key,
    @required this.onTap,
    @required this.color,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          alignment: Alignment.center,
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
        ),
      ),
    );
  }
}
