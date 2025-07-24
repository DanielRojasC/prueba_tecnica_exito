part of 'example_bloc.dart';

@immutable
sealed class ExampleEvent {}

final class ExampleInitialEvent extends ExampleEvent {}
