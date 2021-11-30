import 'package:flutter/material.dart';
import '../buttons/Button.dart';
import '../buttons/Colors.dart';

class Landscape extends StatefulWidget {
    const Landscape({ Key? key }) : super(key: key);

    @override
    _LandscapeState createState() => _LandscapeState();
}

class _LandscapeState extends State<Landscape> {
    
    @override
    Widget build(BuildContext context) {
        Button.width = MediaQuery.of(context).size.width * 0.08;
        Button.height = MediaQuery.of(context).size.height * 0.12;
        Button.margin = EdgeInsets.fromLTRB(0, 5, 0, 5);        
        Button.isPortrait = false;   
        double size = 0.37;           

        return Scaffold(            
            backgroundColor: Colors.black,
            body: Column(                   
                mainAxisAlignment: MainAxisAlignment.end,                     
                children: [
                    Row(     
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[   
                            Button('(', scienceOperation, Colors.white, size / 1.72).createBtn(),
                            Button(')', scienceOperation, Colors.white, size / 1.72).createBtn(),
                            Button('mc', scienceOperation, Colors.white, size / 1.72).createBtn(),
                            Button('m+', scienceOperation, Colors.white, size / 1.72).createBtn(),
                            Button('m-', scienceOperation, Colors.white, size / 1.72).createBtn(),  
                            Button('mr', scienceOperation, Colors.white, size / 1.72).createBtn(),  
                            Button('AC', stdOperation1, Colors.black, size).createBtn(),
                            Button('+/-', stdOperation1, Colors.black, size).createBtn(),
                            Button('%', stdOperation1, Colors.black, size).createBtn(),
                            Button('÷', stdOperation2, Colors.white, size).createBtn(),                                                      
                        ]
                    ),                    
                    Row(  
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                            Button('2ⁿᵈ', scienceOperation, Colors.white, size / 1.72).createBtn(),
                            Button('x²', scienceOperation, Colors.white, size / 1.72).createBtn(),
                            Button('x³', scienceOperation, Colors.white, size / 1.72).createBtn(),
                            Button('xʸ', scienceOperation, Colors.white, size / 1.72).createBtn(),
                            Button('eˣ', scienceOperation, Colors.white, size / 1.72).createBtn(), 
                            Button('10ˣ', scienceOperation, Colors.white, size / 1.72).createBtn(), 
                            Button('7', digits, Colors.white, size).createBtn(),                            
                            Button('8', digits, Colors.white, size).createBtn(),                            
                            Button('9', digits, Colors.white, size).createBtn(),                            
                            Button('×', stdOperation2, Colors.white, size).createBtn(),                            
                        ]
                    ),                    
                    Row(    
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,                  
                        children: <Widget>[
                            Button('¹⁄ₓ', scienceOperation, Colors.white, size / 1.72).createBtn(),
                            Button('√x', scienceOperation, Colors.white, size / 1.72).createBtn(),
                            Button('∛x', scienceOperation, Colors.white, size / 1.72).createBtn(),
                            Button('∜x', scienceOperation, Colors.white, size / 1.72).createBtn(),
                            Button('ln', scienceOperation, Colors.white, size / 1.72).createBtn(),
                            Button('log₁₀', scienceOperation, Colors.white, size / 1.72).createBtn(),  
                            Button('4', digits, Colors.white, size).createBtn(),                            
                            Button('5', digits, Colors.white, size).createBtn(),                            
                            Button('6', digits, Colors.white, size).createBtn(),                            
                            Button('—', stdOperation2, Colors.white, size).createBtn(),                                                                                      
                        ]
                    ),                    
                    Row(  
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,                      
                        children: <Widget>[
                            Button('x!', scienceOperation, Colors.white, size / 1.72).createBtn(),
                            Button('sin', scienceOperation, Colors.white, size / 1.72).createBtn(),
                            Button('cos', scienceOperation, Colors.white, size / 1.72).createBtn(),
                            Button('tan', scienceOperation, Colors.white, size / 1.72).createBtn(),
                            Button('e', scienceOperation, Colors.white, size / 1.72).createBtn(), 
                            Button('EE', scienceOperation, Colors.white, size / 1.72).createBtn(), 
                            Button('1', digits, Colors.white, size).createBtn(),                            
                            Button('2', digits, Colors.white, size).createBtn(),                            
                            Button('3', digits, Colors.white, size).createBtn(),                            
                            Button('+', stdOperation2, Colors.white, size).createBtn(),                            
                        ]
                    ),                    
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,                     
                        children: <Widget>[  
                            Button('Rad', scienceOperation, Colors.white, size / 1.72).createBtn(),
                            Button('sinh', scienceOperation, Colors.white, size / 1.72).createBtn(),
                            Button('cosh', scienceOperation, Colors.white, size / 1.72).createBtn(),
                            Button('tanh', scienceOperation, Colors.white, size / 1.72).createBtn(),
                            Button('π', scienceOperation, Colors.white, size / 1.72).createBtn(), 
                            Button('Rand', scienceOperation, Colors.white , size / 1.72).createBtn(), 
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