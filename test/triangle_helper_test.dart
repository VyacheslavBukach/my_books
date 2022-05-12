import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_books/calculator.dart';
import 'package:my_books/triangle_helper.dart';

import 'triangle_helper_test.mocks.dart';

@GenerateMocks([Calculator])
void main() {
  late Calculator calculator;
  late TriangleHelper triangleHelper;

  setUp(() {
    calculator = MockCalculator();
    triangleHelper = TriangleHelper(calculator: calculator);

    triangleHelper.oneSide = 3;
    triangleHelper.secondSide = 4;
    triangleHelper.thirdSide = 5;
    triangleHelper.height = 10;
  });

  test('calculate perimeter', () {
    when(calculator.sum(number1: 3, number2: 4)).thenReturn(7);
    when(calculator.sum(number1: 7, number2: 5)).thenReturn(12);

    final perimeter = triangleHelper.findPerimeter();

    expect(perimeter, 12);
  });

  test('calculate square', () {
    when(calculator.divide(number1: 1, number2: 2)).thenReturn(0.5);
    when(calculator.multiply(number1: 0.5, number2: 5)).thenReturn(2.5);
    when(calculator.multiply(number1: 2.5, number2: 10)).thenReturn(25);

    final square = triangleHelper.findSquare();

    expect(square, 25);
  });
}
