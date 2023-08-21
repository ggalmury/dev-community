import 'package:bloc/bloc.dart';
import 'package:dev_community/main.dart';
import 'package:dev_community/utils/enum.dart';
import 'package:dev_community/utils/helpers/helper.dart';
import 'package:equatable/equatable.dart';

class SearchFilterBloc
    extends Bloc<DefaultSearchFilterEvent, DefaultSearchFilterState> {
  SearchFilterBloc() : super(InitSearchFilterState()) {
    on<DefaultSearchFilterEvent>((event, emit) {
      if (event is InitSearchFilterEvent) {
        _initSearchFilterEventHandler(event, emit);
      } else if (event is SetSearchFilterEvent) {
        _setSearchFilterEventHandler(event, emit);
      } else if (event is ResetSearchFilterEvent) {
        _resetSearchFilterEventHandler(event, emit);
      }
    });
  }

  void _initSearchFilterEventHandler(InitSearchFilterEvent event, emit) {
    emit(InitSearchFilterState());
  }

  void _setSearchFilterEventHandler(SetSearchFilterEvent event, emit) {
    List<String> copiedList = Helper().toggleListElement<String>(
        state.filterMap[event.category]!, event.data);

    final newFilterMap =
        Map<SearchFilterCategory, List<String>>.from(state.filterMap);

    newFilterMap[event.category] = copiedList;

    emit(CurrentSearchFilterState(filterMap: newFilterMap));
    loggerNoStack.i("SetSearchFilterEvent: ${state.filterMap}");
  }

  void _resetSearchFilterEventHandler(ResetSearchFilterEvent event, emit) {
    final newFilterMap =
        Map<SearchFilterCategory, List<String>>.from(state.filterMap);

    newFilterMap[event.category] = [];

    emit(CurrentSearchFilterState(filterMap: newFilterMap));
    loggerNoStack.i("ResetSearchFilterEvent: ${state.filterMap}");
  }
}

// event
abstract class DefaultSearchFilterEvent extends Equatable {}

class InitSearchFilterEvent extends DefaultSearchFilterEvent {
  InitSearchFilterEvent();

  @override
  List<Object?> get props => [];
}

class SetSearchFilterEvent extends DefaultSearchFilterEvent {
  final SearchFilterCategory category;
  final String data;

  SetSearchFilterEvent({required this.category, required this.data});

  @override
  List<Object?> get props => [category, data];
}

class ResetSearchFilterEvent extends DefaultSearchFilterEvent {
  final SearchFilterCategory category;

  ResetSearchFilterEvent({required this.category});

  @override
  List<Object?> get props => [category];
}

// state
abstract class DefaultSearchFilterState extends Equatable {
  final Map<SearchFilterCategory, List<String>> filterMap;

  const DefaultSearchFilterState({required this.filterMap});
}

class InitSearchFilterState extends DefaultSearchFilterState {
  InitSearchFilterState()
      : super(filterMap: {
          SearchFilterCategory.techSkill: [],
          SearchFilterCategory.position: [],
          SearchFilterCategory.process: [],
          SearchFilterCategory.location: [],
          SearchFilterCategory.type: [],
        });

  @override
  List<Object?> get props => [filterMap];
}

class CurrentSearchFilterState extends DefaultSearchFilterState {
  const CurrentSearchFilterState({required super.filterMap});

  @override
  List<Object?> get props => [filterMap];
}
