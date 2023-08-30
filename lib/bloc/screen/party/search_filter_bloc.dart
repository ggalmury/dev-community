import 'package:bloc/bloc.dart';
import 'package:dev_community/main.dart';
import 'package:dev_community/utils/enums/global.dart';
import 'package:dev_community/utils/helpers/helper.dart';
import 'package:equatable/equatable.dart';

class SearchFilterBloc extends Bloc<SearchFilterEvent, SearchFilterState> {
  SearchFilterBloc() : super(InitSearchFilterState()) {
    on<SearchFilterEvent>((event, emit) {
      if (event is InitSearchFilterEvent) {
        _initState(event, emit);
      } else if (event is SetSearchFilterEvent) {
        _setFilter(event, emit);
      } else if (event is ResetSearchFilterEvent) {
        _resetFilter(event, emit);
      }
    });
  }

  void _initState(InitSearchFilterEvent event, emit) {
    emit(InitSearchFilterState());
  }

  void _setFilter(SetSearchFilterEvent event, emit) {
    List<String> copiedList = Helper().toggleListElement<String>(
        state.filterMap[event.category]!, event.data);

    final newFilterMap =
        Map<SearchFilterCategory, List<String>>.from(state.filterMap);

    newFilterMap[event.category] = copiedList;

    emit(CurrentSearchFilterState(filterMap: newFilterMap));
    loggerNoStack.i("SetSearchFilterEvent: ${state.filterMap}");
  }

  void _resetFilter(ResetSearchFilterEvent event, emit) {
    final newFilterMap =
        Map<SearchFilterCategory, List<String>>.from(state.filterMap);

    newFilterMap[event.category] = [];

    emit(CurrentSearchFilterState(filterMap: newFilterMap));
    loggerNoStack.i("ResetSearchFilterEvent: ${state.filterMap}");
  }
}

// event
abstract class SearchFilterEvent extends Equatable {}

class InitSearchFilterEvent extends SearchFilterEvent {
  InitSearchFilterEvent();

  @override
  List<Object?> get props => [];
}

class SetSearchFilterEvent extends SearchFilterEvent {
  final SearchFilterCategory category;
  final String data;

  SetSearchFilterEvent({required this.category, required this.data});

  @override
  List<Object?> get props => [category, data];
}

class ResetSearchFilterEvent extends SearchFilterEvent {
  final SearchFilterCategory category;

  ResetSearchFilterEvent({required this.category});

  @override
  List<Object?> get props => [category];
}

// state
abstract class SearchFilterState extends Equatable {
  final Map<SearchFilterCategory, List<String>> filterMap;

  const SearchFilterState({required this.filterMap});
}

class InitSearchFilterState extends SearchFilterState {
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

class CurrentSearchFilterState extends SearchFilterState {
  const CurrentSearchFilterState({required super.filterMap});

  @override
  List<Object?> get props => [filterMap];
}
