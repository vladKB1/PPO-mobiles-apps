import "package:flutter/material.dart";

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Widget calcbuttion(String btntxt, Color btncolor, Color txtcolor) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          calculation(btntxt);
        },
        child: Text(
          btntxt,
          style: TextStyle(
            fontSize: 35,
            color: txtcolor,
          ),
        ),
        shape: CircleBorder(),
        color: btncolor,
        padding: EdgeInsets.all(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Calculator"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    text,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white, fontSize: 100),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcbuttion("AC", Colors.grey, Colors.black),
                calcbuttion("+/-", Colors.grey, Colors.black),
                calcbuttion("%", Colors.grey, Colors.black),
                calcbuttion("/", Color(0XFFFFA000), Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcbuttion("7", Color(0xFF303030), Colors.white),
                calcbuttion("8", Color(0xFF303030), Colors.white),
                calcbuttion("9", Color(0xFF303030), Colors.white),
                calcbuttion("x", Color(0XFFFFA000), Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcbuttion("4", Color(0xFF303030), Colors.white),
                calcbuttion("5", Color(0xFF303030), Colors.white),
                calcbuttion("6", Color(0xFF303030), Colors.white),
                calcbuttion("-", Color(0XFFFFA000), Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcbuttion("1", Color(0xFF303030), Colors.white),
                calcbuttion("2", Color(0xFF303030), Colors.white),
                calcbuttion("3", Color(0xFF303030), Colors.white),
                calcbuttion("+", Color(0XFFFFA000), Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                  onPressed: () {},
                  shape: StadiumBorder(),
                  child: Text(
                    "0",
                    style: TextStyle(fontSize: 35, color: Colors.white),
                  ),
                  color: Color(0xFF303030),
                ),
                calcbuttion(".", Color(0xFF303030), Colors.white),
                calcbuttion("=", Color(0XFFFFA000), Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
