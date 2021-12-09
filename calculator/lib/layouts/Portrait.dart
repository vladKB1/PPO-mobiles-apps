import 'dart:math';

import 'package:flutter/material.dart';
import '../buttons/Button.dart';
import '../buttons/Colors.dart';
import '../main.dart';
import 'package:math_expressions/math_expressions.dart';

class Portrait extends StatefulWidget {
  Portrait({Key? key}) : super(key: key);

  @override
  _PortraitState createState() => _PortraitState();
}

String history = '';
String expression = '';
String clr = 'AC';

class _PortraitState extends State<Portrait> {
  void calculation(String text, double width) {
    if (text == '+/-') {
      if (expression[0] != '-') {
        setState(() {
          expression = '-' + expression;
        });
      } else {
        setState(() {
          expression = expression.substring(1);
        });
      }
      return;
    }

    if (text == '—') text = '-';
    if (text == '×') text = '*';
    if (text == '÷') text = '/';
    if (text == ',') text = '.';

    setState(() => expression += text);

    if (clr == 'AC') {
      setState(() {
        clr = 'C';
      });
    }
  }

  void delete(String text, double width) {
    if (expression.length > 0) {
      setState(() {
        expression = expression.substring(0, expression.length - 1);
      });
    }
  }

  void clear(String text, double width) {
    if (clr == 'AC') {
      setState(() {
        expression = '';
        history = '';
      });
    } else {
      setState(() {
        expression = '';
        clr = 'AC';
      });
    }
  }

  void evaluate(String text, double width) {
    Parser p = Parser();
    Expression exp = p.parse(expression);
    ContextModel cm = ContextModel();

    setState(() {
      history = expression;
      expression = exp.evaluate(EvaluationType.REAL, cm).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    var sz = min(MediaQuery.of(context).size.width * 0.20,
        MediaQuery.of(context).size.height * 0.13);
    var space = sz / 5;
    Button.width = sz;
    Button.height = sz;
    Button.margin = EdgeInsets.fromLTRB(0, 12, 0, 12);
    Button.isPortrait = true;
    double size = 0.44;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            child: Text(
              expression,
              style: TextStyle(
                fontSize: sz,
                color: Colors.white,
              ),
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Button(clr, stdOperation1, Colors.black, size).createBtn(clear),
                Button('+/-', stdOperation1, Colors.black, size)
                    .createBtn(calculation),
                Button('%', stdOperation1, Colors.black, size)
                    .createBtn(calculation),
                Button('÷', stdOperation2, Colors.white, size)
                    .createBtn(calculation),
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Button('7', digits, Colors.white, size).createBtn(calculation),
                Button('8', digits, Colors.white, size).createBtn(calculation),
                Button('9', digits, Colors.white, size).createBtn(calculation),
                Button('×', stdOperation2, Colors.white, size)
                    .createBtn(calculation),
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Button('4', digits, Colors.white, size).createBtn(calculation),
                Button('5', digits, Colors.white, size).createBtn(calculation),
                Button('6', digits, Colors.white, size).createBtn(calculation),
                Button('—', stdOperation2, Colors.white, size)
                    .createBtn(calculation),
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Button('1', digits, Colors.white, size).createBtn(calculation),
                Button('2', digits, Colors.white, size).createBtn(calculation),
                Button('3', digits, Colors.white, size).createBtn(calculation),
                Button('+', stdOperation2, Colors.white, size)
                    .createBtn(calculation),
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Button('0', digits, Colors.white, size).createBtn(calculation),
                Button('←', digits, Colors.white, size).createBtn(delete),
                Button(',', digits, Colors.white, size).createBtn(calculation),
                Button('=', stdOperation2, Colors.white, size)
                    .createBtn(evaluate),
              ]),
        ],
      ),
    );
  }
}
