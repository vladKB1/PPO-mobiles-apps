import 'package:flutter/material.dart';
import '../buttons/Button.dart';
import '../buttons/Colors.dart';

class Portrait extends StatefulWidget {
    const Portrait({ Key? key }) : super(key: key);

    @override
    _PortraitState createState() => _PortraitState();
}

class _PortraitState extends State<Portrait> {
    
    @override
    Widget build(BuildContext context) {
        Button.width = MediaQuery.of(context).size.width * 0.20;
        Button.height = MediaQuery.of(context).size.width * 0.20;
        Button.margin = EdgeInsets.fromLTRB(0, 12, 0, 12);                      
        Button.isPortrait = true; 
        double size = 0.44;

        return Scaffold(            
            backgroundColor: Colors.black,
            body: Column(                   
                mainAxisAlignment: MainAxisAlignment.end,                     
                children: [
                    Row(     
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[      
                            Button('AC', stdOperation1, Colors.black, size).createBtn(),
                            Button('+/-', stdOperation1, Colors.black, size).createBtn(),
                            Button('%', stdOperation1, Colors.black, size).createBtn(),
                            Button('÷', stdOperation2, Colors.white, size).createBtn(),                                                      
                        ]
                    ),                    
                    Row(  
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                            Button('7', digits, Colors.white, size).createBtn(),                            
                            Button('8', digits, Colors.white, size).createBtn(),                            
                            Button('9', digits, Colors.white, size).createBtn(),                            
                            Button('×', stdOperation2, Colors.white, size).createBtn(),                            
                        ]
                    ),                    
                    Row(    
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,                  
                        children: <Widget>[
                            Button('4', digits, Colors.white, size).createBtn(),                            
                            Button('5', digits, Colors.white, size).createBtn(),                            
                            Button('6', digits, Colors.white, size).createBtn(),                            
                            Button('—', stdOperation2, Colors.white, size).createBtn(),                                                                                      
                        ]
                    ),                    
                    Row(  
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,                      
                        children: <Widget>[
                            Button('1', digits, Colors.white, size).createBtn(),                            
                            Button('2', digits, Colors.white, size).createBtn(),                            
                            Button('3', digits, Colors.white, size).createBtn(),                            
                            Button('+', stdOperation2, Colors.white, size).createBtn(),                            
                        ]
                    ),                    
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,                     
                        children: <Widget>[  
                            Button(Icons.screen_rotation_outlined, digits, Colors.white, size).createIconBtn(() => {}),
                            Button('0', digits, Colors.white, size).createBtn(),                            
                            Button(',', digits, Colors.white, size).createBtn(),                            
                            Button('=', stdOperation2, Colors.white, size).createBtn(),                                                        
                        ]
                    ),
                ],
            ),
        );
    }
}