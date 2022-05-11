import 'package:flutter_test/flutter_test.dart';
import 'package:my_books/calculator.dart';

void main() {
  late Calculator calculator;

  setUp(() {
    calculator = Calculator();
  });

  test('sum test', () {
    var result1 = calculator.sum(number1: 1, number2: 1);
    expect(result1, 2);
    var result2 = calculator.sum(number1: 2, number2: 2);
    expect(result2, 4);
    var result3 = calculator.sum(number1: 3, number2: 3);
    expect(result3, 6);
  });

  test('difference test', () {
    var result1 = calculator.difference(number1: 1, number2: 1);
    expect(result1, 0);
    var result2 = calculator.difference(number1: 2, number2: 2);
    expect(result2, 0);
    var result3 = calculator.difference(number1: 3, number2: 3);
    expect(result3, 0);
  });

  test('multiply test', () {
    var result1 = calculator.multiply(number1: 1, number2: 1);
    expect(result1, 1);
    var result2 = calculator.multiply(number1: 2, number2: 2);
    expect(result2, 4);
    var result3 = calculator.multiply(number1: 3, number2: 3);
    expect(result3, 9);
  });

  test('division test', () {
    var result1 = calculator.divide(number1: 1, number2: 1);
    expect(result1, 1);
    var result2 = calculator.divide(number1: 2, number2: 2);
    expect(result2, 1);
    var result3 = calculator.divide(number1: 3, number2: 3);
    expect(result3, 1);
  });
}
