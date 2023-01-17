import 'package:auto_run/core/const.dart';
import 'package:flutter/material.dart';

class LocationPage extends StatefulWidget {
  LocationPage(
      {Key? key, required this.selectedLocation, required this.onSelect})
      : super(key: key);

  final String selectedLocation;

  final Function onSelect;

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  List<String> locations = [
    'Kasergod',
    'Kannoor',
    'Wayanad',
    'Kozhikode',
    'Malappuram',
    'Palakkad',
    'Thrissur',
    'Ernankulam',
    'Alappuzha',
    'Idukki',
    'PathanamThitta',
    'Kollam',
    'Kottayam',
    'Thiruvanndapuram',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'What Service District you want to register?',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
              itemBuilder: (ctx, i) {
                return ListTile(
                  onTap: () => widget.onSelect(locations[i]),
                  visualDensity: VisualDensity(vertical: -4),
                  title: Text(locations[i]),
                  trailing: widget.selectedLocation == locations[i]
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: yellow,
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                );
              },
              itemCount: locations.length),
        ),
      ],
    );
  }
}
