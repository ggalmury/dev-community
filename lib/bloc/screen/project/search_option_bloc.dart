import 'package:bloc/bloc.dart';
import 'package:dev_community/utils/enum.dart';
import 'package:equatable/equatable.dart';

class SearchOptionBloc
    extends Bloc<DefaultSearchOptionEvent, DefaultSearchOptionState> {
  SearchOptionBloc() : super(InitSearchOptionState()) {
    on<DefaultSearchOptionEvent>((event, emit) {
      if (event is InitSearchOptionEvent) {
      } else if (event is SetSearchOptionEvent) {}
    });
  }
}

// event
abstract class DefaultSearchOptionEvent extends Equatable {}

class InitSearchOptionEvent extends DefaultSearchOptionEvent {
  InitSearchOptionEvent();
  @override
  List<Object?> get props => [];
}

class SetSearchOptionEvent extends DefaultSearchOptionEvent {
  final SearchOption searchOption;
  final String data;

  SetSearchOptionEvent({required this.searchOption, required this.data});

  @override
  List<Object?> get props => [searchOption, data];
}

// state
abstract class DefaultSearchOptionState extends Equatable {
  final Map<SearchOption, List<String>> searchOptions;

  const DefaultSearchOptionState({required this.searchOptions});
}

class InitSearchOptionState extends DefaultSearchOptionState {
  InitSearchOptionState() : super(searchOptions: {});

  @override
  List<Object?> get props => [searchOptions];
}

class CurrentSearchOptionState extends DefaultSearchOptionState {
  const CurrentSearchOptionState({required super.searchOptions});

  @override
  List<Object?> get props => [searchOptions];
}
