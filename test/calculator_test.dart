import 'package:flutter_test/flutter_test.dart';
import 'package:my_books/calculator.dart';

void main() {
  test('Sum_5Plus2_Returned7', () {
    final calculator = Calculator();
    var result = calculator.sum(number1: 5, number2: 2);
    expect(result, 7);
  });

  test('Difference_5Minus2_Returned3', () {
    final calculator = Calculator();
    var result = calculator.difference(number1: 5, number2: 2);
    expect(result, 3);
  });

  test('Multiply_5Multiply2_Returned10', () {
    final calculator = Calculator();
    var result = calculator.multiply(number1: 5, number2: 2);
    expect(result, 10);
  });

  test('Divide_5DivideBy2_Returned2.5', () {
    final calculator = Calculator();
    var result = calculator.divide(number1: 5, number2: 2);
    expect(result, 2.5);
  });
}
