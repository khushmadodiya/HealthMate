import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../globle.dart';


class DropDownForTimming extends StatefulWidget {
  @override
  _DropDownForTimmingState createState() => _DropDownForTimmingState();
}

class _DropDownForTimmingState extends State<DropDownForTimming> {



  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black,width: 1.5),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: PopupMenuButton<String>(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        offset: Offset(10,10),
        elevation: 8,
        // color: colors,
        onSelected: (String value) {
          setState(() {
            selectedTimming = value;
          });
        },
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry<String>>[

            PopupMenuItem<String>(
              value: am,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Colors.white),
                    color: selectedTimming == am ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(10)
                ),

                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    am,
                    style: TextStyle(
                      fontSize: 16.0,

                    ),
                  ),
                ),
              ),
            ),
            PopupMenuItem<String>(
              value: pm,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Colors.white),
                    color: selectedTimming == pm ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(10)
                ),
                width: 300,
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    pm,
                    style: TextStyle(
                      fontSize: 16.0,

                    ),
                  ),
                ),
              ),
            ),
            PopupMenuItem<String>(
              value: both,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Colors.white),
                    color: selectedTimming == both ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(10)
                ),
                width: 300,
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    both,
                    style: TextStyle(
                      fontSize: 16.0,

                    ),
                  ),
                ),
              ),
            ),

          ];
        },
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                selectedTimming ?? 'Select an item',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
    // return Container(
    //   child: Chj,
    // );
  }
}
