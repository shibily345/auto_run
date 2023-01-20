import 'package:auto_run/core/const.dart';
import 'package:flutter/material.dart';

class VehicalMakePage extends StatefulWidget {
  const VehicalMakePage(
      {Key? key, required this.onSelect, required this.selectedVehical})
      : super(key: key);

  final String selectedVehical;
  final Function onSelect;

  @override
  State<VehicalMakePage> createState() => _VehicalMakePageState();
}

class _VehicalMakePageState extends State<VehicalMakePage> {
  List<String> vehicalMake = [
    'TATA',
    'Piaggio',
    'Atul',
    'Bajaj',
    'Mahendra',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Compeny of vehicle ?',
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
                  onTap: () => widget.onSelect(vehicalMake[i]),
                  visualDensity: const VisualDensity(vertical: -4),
                  title: Text(
                    vehicalMake[i],
                    selectionColor: Theme.of(context).indicatorColor,
                    style: TextStyle(color: Theme.of(context).primaryColorDark),
                  ),
                  trailing: widget.selectedVehical == vehicalMake[i]
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
              itemCount: vehicalMake.length),
        ),
      ],
    );
  }
}
