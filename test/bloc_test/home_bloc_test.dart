import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_books/blocs/home_bloc/home_bloc.dart';

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

void main() {
  group('whenListen', () {
    test("Let's mock the MockHomeBloc's stream!", () {
      final bloc = MockHomeBloc();

      whenListen(bloc, Stream.fromIterable([0, 1, 2, 3]));

      expectLater(bloc.stream, emitsInOrder(<int>[0, 1, 2, 3]));
    });
  });

  group('MockHomeBloc', () {
    blocTest<MockHomeBloc, HomeState>(
      'emits [] when nothing is added',
      build: () => MockHomeBloc(),
      expect: () => const <int>[],
    );

    blocTest<MockHomeBloc, HomeState>(
      'emits [1] when SignOutEvent',
      build: () => MockHomeBloc(),
      act: (bloc) => bloc.add(SignOutEvent()),
      expect: () => UnauthenticatedState(),
    );
  });
}
