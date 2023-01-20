import 'package:auto_run/core/const.dart';
import 'package:flutter/material.dart';

class VehicalModelPage extends StatefulWidget {
  const VehicalModelPage(
      {Key? key, required this.onSelect, required this.selectedModel})
      : super(key: key);

  final String selectedModel;
  final Function onSelect;

  @override
  State<VehicalModelPage> createState() => _VehicalModelPageState();
}

class _VehicalModelPageState extends State<VehicalModelPage> {
  List<String> vehicalModel = [
    'Ape',
    'Gemini',
    'Cargo',
    'Magic Iris',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Which model of vehicle is it ?',
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
              onTap: () => widget.onSelect(vehicalModel[i]),
              visualDensity: const VisualDensity(vertical: -4),
              title: Text(
                vehicalModel[i],
                selectionColor: Theme.of(context).indicatorColor,
                style: TextStyle(color: Theme.of(context).primaryColorDark),
              ),
              trailing: widget.selectedModel == vehicalModel[i]
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
          itemCount: vehicalModel.length,
        )),
      ],
    );
  }
}
