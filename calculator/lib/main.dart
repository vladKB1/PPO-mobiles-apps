import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'layouts/Portrait.dart';
import 'layouts/Landscape.dart';

bool isSetPortrait = false;
bool isSetLandscape = false;

void main() => runApp(MaterialApp(
    theme: ThemeData(
        primaryColor: Colors.black,
    ),
    home: OrientationBuilder(
        builder: (context, orientation) {       
            print("orientation = $orientation");   
            if (orientation == Orientation.portrait) {      
                if (isSetLandscape) {
                    setRotate();
                }          
                return Portrait();
            } else {              
                if (isSetPortrait) {
                    setRotate();
                }         
                return Landscape();
            }            
        }),
    ),
);

Future setPortrait() async {
    isSetPortrait = true;
    isSetLandscape = false;
    await SystemChrome.setPreferredOrientations([    
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);        
}

Future setLandscape() async {
    isSetPortrait = false;
    isSetLandscape = true;    
    await SystemChrome.setPreferredOrientations([    
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
    ]);  
}

Future setRotate() async {
    isSetPortrait = false;
    isSetLandscape = false;
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);    
}