import 'package:my_books/calculator.dart';

class TriangleHelper {
  final Calculator calculator;
  final double oneSide;
  final double secondSide;
  final double thirdSide;
  final double height;

  TriangleHelper({
    required this.calculator,
    required this.oneSide,
    required this.secondSide,
    required this.thirdSide,
    required this.height,
  });

  double findSquare() {
    var result1 = calculator.divide(number1: 1, number2: 2);
    var result2 = calculator.multiply(number1: result1, number2: thirdSide);
    var result3 = calculator.multiply(number1: result2, number2: height);
    return result3;
  }

  double findPerimeter() {
    var result1 = calculator.sum(number1: oneSide, number2: secondSide);
    var result2 = calculator.sum(number1: result1, number2: thirdSide);
    return result2;
  }
}
