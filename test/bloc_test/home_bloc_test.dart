import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_books/blocs/home_bloc/home_bloc.dart';

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

void main() {
  group('whenListen', () {
    test("Let's mock the CounterBloc's stream!", () {
      // Create Mock CounterBloc Instance
      final bloc = MockHomeBloc();

      // Stub the listen with a fake Stream
      whenListen(bloc, Stream.fromIterable([0, 1, 2, 3]));

      // Expect that the CounterBloc instance emitted the stubbed Stream of
      // states
      expectLater(bloc.stream, emitsInOrder(<int>[0, 1, 2, 3]));
    });
  });

  group('CounterBloc', () {
    blocTest<MockHomeBloc, int>(
      'emits [] when nothing is added',
      build: () => MockHomeBloc(),
      expect: () => const <int>[],
    );

    blocTest<MockHomeBloc, int>(
      'emits [1] when CounterIncrementPressed is added',
      build: () => MockHomeBloc(),
      act: (bloc) => bloc.add(CounterIncrementPressed()),
      expect: () => const <int>[1],
    );
  });
}
