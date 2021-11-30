import 'package:flutter/material.dart';

class Button {
    dynamic value = '';
    Color? colorBtn;
    Color? colorVal;
    double size = 0;

    static double width = 0;
    static double height = 0; 
    static EdgeInsets margin = EdgeInsets.all(0);
    static bool isPortrait = true;
    

    Button(this.value, this.colorBtn, this.colorVal, this.size);


    Widget createBtn() {            
        return Container(
            width: Button.width,
            height: Button.height,
            margin: Button.margin,           
            child: ElevatedButton(
                onPressed: () => {

                },
                child: Text('${this.value}',
                    style: TextStyle(
                        fontSize: size * width,
                        color: this.colorVal,                        
                    ),
                ),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Button.isPortrait ? 100 : 50.0),                            
                        ),
                    ),
                    backgroundColor: MaterialStateProperty.all(this.colorBtn),                   
                ),
            )
        );
    }

    Widget createIconBtn(Function f) {
        return Container(
            width: Button.width,
            height: Button.height,
            margin: Button.margin,  
            child: Ink(
                decoration: ShapeDecoration(
                    color: Colors.grey[850],
                    shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Button.isPortrait ? 100 : 50.0),                            
                        ),                                                                                            
                ),
                child: IconButton(                                    
                    onPressed: () => f, 
                    icon: Icon(this.value),                                 
                    color: Colors.white,     
                    iconSize: size * width,                                
                ),
            ),
        );
    }
}