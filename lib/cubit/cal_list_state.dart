part of 'cal_list_cubit.dart';

@immutable
sealed class CalListState {}

// first render from local data
final class CalListLoading extends CalListState {}

final class CalListError extends CalListState {
  final ErrorStates errState;

  CalListError({required this.errState});
}

final class CalListDataLoaded extends CalListState {
  final List<CalEvent> data;
  final DateTime date;
  final bool prevEnabled;
  final bool nextEnabled;

  CalListDataLoaded(
      {required this.data,
      required this.date,
      required this.prevEnabled,
      required this.nextEnabled});
}
