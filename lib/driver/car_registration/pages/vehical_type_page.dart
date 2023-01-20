import 'package:auto_run/core/const.dart';
import 'package:flutter/material.dart';

class VehicalTypePage extends StatefulWidget {
  const VehicalTypePage(
      {Key? key, required this.onSelect, required this.selectedVehical})
      : super(key: key);

  final String selectedVehical;
  final Function onSelect;

  @override
  State<VehicalTypePage> createState() => _VehicalTypePageState();
}

class _VehicalTypePageState extends State<VehicalTypePage> {
  List<String> vehicalType = [
    'Electric',
    'Disel',
    'CNG',
    'Petrole',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'What type of vehicle is it?',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColorDark),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
              itemBuilder: (ctx, i) {
                return ListTile(
                  onTap: () => widget.onSelect(vehicalType[i]),
                  visualDensity: const VisualDensity(vertical: -4),
                  title: Text(
                    vehicalType[i],
                    selectionColor: Theme.of(context).indicatorColor,
                    style: TextStyle(color: Theme.of(context).primaryColorDark),
                  ),
                  trailing: widget.selectedVehical == vehicalType[i]
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: yellow,
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                );
              },
              itemCount: vehicalType.length),
        ),
      ],
    );
  }
}
