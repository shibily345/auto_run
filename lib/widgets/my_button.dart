import 'package:flutter/material.dart';

Widget DecisionButton(BuildContext context, IconData icon, String text,
    Function onPressed, double width,
    {double height = 50}) {
  return InkWell(
    onTap: () => onPressed(),
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              offset: const Offset(10, 10),
              color: Theme.of(context).splashColor,
            ),
            BoxShadow(
              blurRadius: 10,
              offset: const Offset(-10, -10),
              color: Theme.of(context).shadowColor,
            ),
          ]),
      child: Row(
        children: [
          Container(
            width: 65,
            height: height,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    offset: const Offset(10, 10),
                    color: Theme.of(context).splashColor,
                  ),
                  BoxShadow(
                    blurRadius: 10,
                    offset: const Offset(-10, -10),
                    color: Theme.of(context).shadowColor,
                  ),
                ]),
            child: Center(
              child: Icon(
                icon,
                color: Theme.of(context).indicatorColor,
              ),
            ),
          ),
          Expanded(
              child: Text(
            text,
            style: TextStyle(color: Theme.of(context).primaryColorDark),
            textAlign: TextAlign.center,
          )),
        ],
      ),
    ),
  );
}
