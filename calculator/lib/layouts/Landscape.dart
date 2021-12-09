import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import '../buttons/Button.dart';
import '../buttons/Colors.dart';

class Landscape extends StatefulWidget {
  const Landscape({Key? key}) : super(key: key);

  @override
  _LandscapeState createState() => _LandscapeState();
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
double portraitLength = 0;

class _LandscapeState extends State<Landscape> {
  bool checkLength(double width) {
    if (((expression.length + 1) * (width / 2) > portraitLength) ||
        expression.length + 1 > 18) {
      return true;
    } else {
      return false;
    }
  }

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
      if (checkLength(width)) return;

      if (!isDot) {
        isDot = true;
        isEmpty = false;
        setState(() => expression += text);
      }
    } else if (text == '%') {
      if (!isEmpty) {
        if (isOper && history != '') {
          history = history.substring(0, history.length - 1);
        }
        expression += '/100';
        evaluate('=', width);
      }
    } else {
      if (isEmpty && text == '0') return;

      if (checkLength(width)) return;

      if (isEvaluate) {
        isEmpty = true;
        isEvaluate = false;
        isDot = false;
      }

      if (isEmpty) {
        expression = '';
        if (text != '0') isEmpty = false;
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

    if (checkLength(width)) return;
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

    double ans = 0;
    print(history);
    try {
      ans = exp.evaluate(EvaluationType.REAL, cm);
    } catch (e) {
      setState(() => expression = 'ОШИБКА');
      setState(() => clr = 'AC');

      history = '';
      isEvaluate = false;
      isDot = false;
      isEmpty = true;
      isOper = false;
      return;
    }
    expression = ans.toString();

    if (expression.endsWith('.0'))
      expression = expression.substring(0, expression.length - 2);

    setState(() => expression);

    history = '';
    isEvaluate = true;
    isDot = expression.contains('.');
  }

  @override
  Widget build(BuildContext context) {
    portraitLength = MediaQuery.of(context).size.width;

    var sz = min(MediaQuery.of(context).size.width * 0.08,
        MediaQuery.of(context).size.height * 0.13);
    Button.width = sz;
    Button.height = sz;
    Button.margin = EdgeInsets.fromLTRB(0, 5, 0, 5);
    double size = 0.35;

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
                fontSize: sz / 1.5,
                color: Colors.white,
              ),
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Button('(', scienceOperation, Colors.white, size / 1.72)
                    .createBtn(calculation),
                Button(')', scienceOperation, Colors.white, size / 1.72)
                    .createBtn(calculation),
                Button('mc', scienceOperation, Colors.white, size / 1.72)
                    .createBtn(calculation),
                Button('m+', scienceOperation, Colors.white, size / 1.72)
                    .createBtn(calculation),
                Button('m-', scienceOperation, Colors.white, size / 1.72)
                    .createBtn(calculation),
                Button('mr', scienceOperation, Colors.white, size / 1.72)
                    .createBtn(calculation),
                Button(clr, stdOperation1, Colors.black, size / 1.55)
                    .createBtn(clear),
                Button('+/-', stdOperation1, Colors.black, size / 1.5)
                    .createBtn(calculation),
                Button('%', stdOperation1, Colors.black, size)
                    .createBtn(calculation),
                Button('÷', stdOperation2, Colors.white, size)
                    .createBtn(calculation),
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Button('2ⁿᵈ', scienceOperation, Colors.white, size / 1.72)
                    .createBtn(calculation),
                Button('x²', scienceOperation, Colors.white, size / 1.72)
                    .createBtn(calculation),
                Button('x³', scienceOperation, Colors.white, size / 1.72)
                    .createBtn(calculation),
                Button('xʸ', scienceOperation, Colors.white, size / 1.72)
                    .createBtn(calculation),
                Button('eˣ', scienceOperation, Colors.white, size / 1.72)
                    .createBtn(calculation),
                Button('10ˣ', scienceOperation, Colors.white, size / 1.72)
                    .createBtn(calculation),
                Button('7', digits, Colors.white, size).createBtn(calculation),
                Button('8', digits, Colors.white, size).createBtn(calculation),
                Button('9', digits, Colors.white, size).createBtn(calculation),
                Button('×', stdOperation2, Colors.white, size)
                    .createBtn(calculation),
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Button('¹⁄ₓ', scienceOperation, Colors.white, size / 1.72)
                    .createBtn(calculation),
                Button('√x', scienceOperation, Colors.white, size / 1.72)
                    .createBtn(calculation),
                Button('∛x', scienceOperation, Colors.white, size / 1.72)
                    .createBtn(calculation),
                Button('∜x', scienceOperation, Colors.white, size / 1.72)
                    .createBtn(calculation),
                Button('ln', scienceOperation, Colors.white, size / 1.72)
                    .createBtn(calculation),
                Button('log₁₀', scienceOperation, Colors.white, size / 2.01)
                    .createBtn(calculation),
                Button('4', digits, Colors.white, size).createBtn(calculation),
                Button('5', digits, Colors.white, size).createBtn(calculation),
                Button('6', digits, Colors.white, size).createBtn(calculation),
                Button('—', stdOperation2, Colors.white, size)
                    .createBtn(calculation),
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Button('x!', scienceOperation, Colors.white, size / 1.72)
                    .createBtn(calculation),
                Button('sin', scienceOperation, Colors.white, size / 1.72)
                    .createBtn(calculation),
                Button('cos', scienceOperation, Colors.white, size / 1.72)
                    .createBtn(calculation),
                Button('tan', scienceOperation, Colors.white, size / 1.72)
                    .createBtn(calculation),
                Button('e', scienceOperation, Colors.white, size / 1.72)
                    .createBtn(calculation),
                Button('EE', scienceOperation, Colors.white, size / 1.72)
                    .createBtn(calculation),
                Button('1', digits, Colors.white, size).createBtn(calculation),
                Button('2', digits, Colors.white, size).createBtn(calculation),
                Button('3', digits, Colors.white, size).createBtn(calculation),
                Button('+', stdOperation2, Colors.white, size)
                    .createBtn(calculation),
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Button('Rad', scienceOperation, Colors.white, size / 1.72)
                    .createBtn(calculation),
                Button('sinh', scienceOperation, Colors.white, size / 1.9)
                    .createBtn(calculation),
                Button('cosh', scienceOperation, Colors.white, size / 2.05)
                    .createBtn(calculation),
                Button('tanh', scienceOperation, Colors.white, size / 1.9)
                    .createBtn(calculation),
                Button('π', scienceOperation, Colors.white, size / 1.72)
                    .createBtn(calculation),
                Button('Rand', scienceOperation, Colors.white, size / 2.2)
                    .createBtn(calculation),
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
