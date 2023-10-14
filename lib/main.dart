import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}


class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;
  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';

  @override
  Widget build(BuildContext context) {
    Widget calcButton(String btntxt, Color btncolor, Color textcolor, String btnText) {
      return Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: btncolor,
        ),
        child: ElevatedButton(
          onPressed: () {
            calculation(btnText);
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all<CircleBorder>(CircleBorder()),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.all(20),
            ),
          ),
          child: Text(
            btntxt,
            style: TextStyle(
              fontSize: 35,
              color: textcolor,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('Calculator'), backgroundColor: Colors.black),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SingleChildScrollView(
  scrollDirection: Axis.vertical,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          text,  // Muestra el valor actualizado de la variable text
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.white,
            fontSize: 100,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('AC', Color.fromARGB(255, 146, 87, 255), Colors.black, 'AC'),
                calcButton('+/-', Color.fromARGB(255, 146, 87, 255), Colors.black, '+/-'),
                calcButton('%', Color.fromARGB(255, 146, 87, 255), Colors.black, '%'),
                calcButton('/', Color.fromARGB(255, 176, 252, 100), Colors.black, '/'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('7', Color.fromARGB(255, 221, 169, 255), Colors.black, '7'),
                calcButton('8', const Color.fromARGB(255, 255, 255, 255), Colors.black, '8'),
                calcButton('9', const Color.fromARGB(255, 255, 255, 255), Colors.black, '9'),
                calcButton('x', Color.fromARGB(255, 255, 255, 255), Colors.black, 'x'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('4', Color.fromARGB(255, 221, 169, 255), Colors.black, '4'),
                calcButton('5', const Color.fromARGB(255, 255, 255, 255), Colors.black, '5'),
                calcButton('6', const Color.fromARGB(255, 255, 255, 255), Colors.black, '6'),
                calcButton('-', Color.fromARGB(255, 255, 255, 255), Colors.black, '-'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('1', Color.fromARGB(255, 221, 169, 255), Colors.black, '1'),
                calcButton('2', const Color.fromARGB(255, 255, 255, 255), Colors.black, '2'),
                calcButton('3', const Color.fromARGB(255, 255, 255, 255), Colors.black, '3'),
                calcButton('+', Color.fromARGB(255, 255, 255, 255), Colors.black, '+'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: ElevatedButton(
                    onPressed: () {
                      // Coloca aquí el código que se ejecutará al presionar el botón
                    },
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      primary: Colors.grey[850],
                    ),
                    child: Text(
                      "0",
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                calcButton('.', const Color.fromARGB(255, 255, 255, 255), Colors.black, '.'),
                calcButton('=', Color.fromARGB(255, 255, 255, 255), Colors.black, '='),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void calculation(String btnText) {
  if (btnText == 'AC') {
    text = '0';
    numOne = 0;
    numTwo = 0;
    result = '';
    finalResult = '0';
    opr = '';
    preOpr = '';
  } else if (opr == '=' && btnText == '=') {
    if (preOpr == '+') {
      finalResult = add().toString();
    } else if (preOpr == '-') {
      finalResult = sub().toString();
    } else if (preOpr == 'x') {
      finalResult = mul().toString();
    } else if (preOpr == '/') {
      finalResult = div().toString();
    }
  } else if (btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {
    if (result.isNotEmpty) {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        if (result != '.') {
          numTwo = double.parse(result);
        }
      }
      if (opr == '+') {
        finalResult = add().toString();
      } else if (opr == '-') {
        finalResult = sub().toString();
      } else if (opr == 'x') {
        finalResult = mul().toString();
      } else if (opr == '/') {
        finalResult = div().toString();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    }
  } else if (btnText == '%') {
    if (result.isNotEmpty) {
      result = (double.parse(result) / 100).toString();
      finalResult = doesContainDecimal(result).toString();
    }
  } else if (btnText == '.') {
    if (result.isNotEmpty && !result.contains('.')) {
      result = result + '.';
      finalResult = result;
    }
  } else if (btnText == '+/-') {
    if (result.isNotEmpty) {
      if (result.startsWith('-')) {
        result = result.substring(1);
      } else if (result != '0') {
        result = '-' + result;
      }
      finalResult = result;
    }
  } else {
    result = result + btnText;
    finalResult = result;
  }

  setState(() {
    text = finalResult;
  });
}

  double add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  double sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  double mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  double div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  double doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0)) {
        return double.parse(splitDecimal[0]);
      }
    }
    return double.parse(result);
  }
}
