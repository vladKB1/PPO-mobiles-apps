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
String expression = '0';
String clr = 'AC';
bool isEmpty = true;
bool isOper = false;
bool isEvaluate = false;
bool isDot = false;
Map<String, String> oper = {
  '—': '-',
  '×': '*',
  '÷': '/',
  ',': '.',
  '+': '+',
};

class _PortraitState extends State<Portrait> {
  void calculation(String text, double width) {
    if (expression == 'ОШИБКА') {
      expression = '0';
    }

    String? txt = oper[text];
    if (txt != null) text = txt;

    if (text == '+/-') {
      if (expression[0] != '-' && !isEmpty) {
        setState(() => expression = '-' + expression);
      } else if (expression[0] == '-') {
        setState(() => expression = expression.substring(1));
      }
      return;
    }

    if (text == '/' || text == '*' || text == "-" || text == '+') {
      if (!isOper) {
        isEvaluate = false;
        isOper = true;
        isEmpty = true;

        history += expression + text;
        expression = '0';
      } else if (isOper && isEmpty) {
        history = history.substring(0, history.length - 1) + text;
      } else if (isOper && !isEmpty) {
        evaluate('=', width);
        history += expression + text;
        expression = '0';
        isDot = false;
        isEmpty = true;
        isEvaluate = false;
      }
    } else if (text == '.') {
      if (!isDot) {
        isDot = true;
        isEmpty = false;
        setState(() => expression += text);
      }
    } else if (text == '%') {
      if (!isEmpty) {
        if (isOper) {
          history = history.substring(0, history.length - 1);
        }
        expression += '/100';
        evaluate('=', width);
      }
    } else {
      if (isEmpty && text == '0') return;

      if (isEvaluate) {
        isEmpty = true;
        isEvaluate = false;
      }

      if (isEmpty) {
        expression = '';
        isEmpty = false;
      }
      setState(() => expression += text);
    }

    if (clr == 'AC') {
      setState(() => clr = 'C');
    }
  }

  void delete(String text, double width) {
    if (expression == 'ОШИБКА') {
      setState(() => expression = '0');
      return;
    }

    if (!isEmpty) {
      setState(
          () => expression = expression.substring(0, expression.length - 1));
      if (expression == '') {
        isEmpty = true;
        setState(() => expression = '0');
        setState(() => clr = 'AC');
      }
    }
  }

  void clear(String text, double width) {
    if (clr == 'AC') {
      history = '';
      isEmpty = true;
      isOper = false;
      isEvaluate = false;
      isDot = false;
      setState(() => expression = '0');
    } else if (clr == 'C') {
      isEmpty = true;
      isDot = false;
      setState(() {
        expression = '0';
        clr = 'AC';
      });
    }
  }

  void evaluate(String text, double width) {
    if (expression == 'ОШИБКА') {
      setState(() => expression = '0');
      return;
    }

    history += expression;

    Parser p = Parser();
    Expression exp = p.parse(history);
    print(history);
    ContextModel cm = ContextModel();

    if (history.endsWith('/0')) {
      setState(() => expression = 'ОШИБКА');
      setState(() => clr = 'AC');

      history = '';
      isEvaluate = false;
      isDot = false;
      isEmpty = true;
      isOper = false;
      return;
    }

    setState(
        () => expression = exp.evaluate(EvaluationType.REAL, cm).toString());
    history = '';
    isEvaluate = true;
    isDot = expression.contains('.');
  }

  @override
  Widget build(BuildContext context) {
    var sz = min(MediaQuery.of(context).size.width * 0.20,
        MediaQuery.of(context).size.height * 0.13);
    Button.width = sz;
    Button.height = sz;
    Button.margin = EdgeInsets.fromLTRB(0, 12, 0, 12);
    Button.isPortrait = true;
    double size = 0.44;

    double expMargin = sz / 5;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.fromLTRB(0, 0, expMargin, expMargin / 2),
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
