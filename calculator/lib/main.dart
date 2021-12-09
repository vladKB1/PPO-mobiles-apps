import 'package:flutter/material.dart';
import 'layouts/Portrait.dart';
import 'layouts/Landscape.dart';

void main() => runApp(
      MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.black,
        ),
        home: OrientationBuilder(builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return Portrait();
          } else {
            return Landscape();
          }
        }),
      ),
    );
