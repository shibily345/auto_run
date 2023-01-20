import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VehicalModelYearPage extends StatefulWidget {
  const VehicalModelYearPage({Key? key, required this.onSelect})
      : super(key: key);

  final Function onSelect;

  @override
  State<VehicalModelYearPage> createState() => _VehicalModelYearPageState();
}

class _VehicalModelYearPageState extends State<VehicalModelYearPage> {
  List<int> years = [
    2000,
    2001,
    2002,
    2003,
    2004,
    2005,
    2006,
    2007,
    2008,
    2009,
    2010,
    2011,
    2012,
    2013,
    2014,
    2015,
    2016,
    2017,
    2018,
    2019,
    2020,
    2021,
    2022,
    2023,
    2024,
    2025,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'vehicle model year ?',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColorDark),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
            child: Center(
          child: CupertinoPicker.builder(
            childCount: years.length,
            itemBuilder: (BuildContext context, int index) {
              return Center(
                  child: Text(
                years[index].toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).indicatorColor),
              ));
            },
            itemExtent: 100,
            onSelectedItemChanged: (value) {
              widget.onSelect(years[value]);
            },
          ),
        )),
      ],
    );
  }
}
