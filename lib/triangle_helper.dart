import 'package:my_books/calculator.dart';

class TriangleHelper {
  final Calculator calculator;
  double oneSide = 0.0;
  double secondSide = 0.0;
  double thirdSide = 0.0;
  double height = 0.0;

  TriangleHelper({
    required this.calculator,
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
