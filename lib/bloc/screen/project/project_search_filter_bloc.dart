import 'package:bloc/bloc.dart';
import 'package:dev_community/main.dart';
import 'package:dev_community/utils/enum.dart';
import 'package:dev_community/utils/helpers/helper.dart';
import 'package:equatable/equatable.dart';

class ProjectSearchFilterBloc extends Bloc<DefaultProjectSearchFilterEvent,
    DefaultProjectSearchFilterState> {
  ProjectSearchFilterBloc() : super(InitProjectSearchFilterState()) {
    on<DefaultProjectSearchFilterEvent>((event, emit) {
      if (event is InitProjectSearchFilterEvent) {
        _initProjectSearchFilterEventHandler(event, emit);
      } else if (event is SetProjectSearchFilterEvent) {
        _setProjectSearchFilterEventHandler(event, emit);
      }
    });
  }

  void _initProjectSearchFilterEventHandler(
      InitProjectSearchFilterEvent event, emit) {
    emit(InitProjectSearchFilterState());
  }

  void _setProjectSearchFilterEventHandler(
      SetProjectSearchFilterEvent event, emit) {
    List<String> copiedList = Helper().toggleListElement<String>(
        state.filterMap[event.category]!, event.data);

    final newFilterMap =
        Map<SearchFilterCategory, List<String>>.from(state.filterMap);

    newFilterMap[event.category] = copiedList;

    emit(CurrentProjectSearchFilterState(filterMap: newFilterMap));
    loggerNoStack.i(state.filterMap);
  }
}

// event
abstract class DefaultProjectSearchFilterEvent extends Equatable {}

class InitProjectSearchFilterEvent extends DefaultProjectSearchFilterEvent {
  InitProjectSearchFilterEvent();

  @override
  List<Object?> get props => [];
}

class SetProjectSearchFilterEvent extends DefaultProjectSearchFilterEvent {
  final SearchFilterCategory category;
  final String data;

  SetProjectSearchFilterEvent({required this.category, required this.data});

  @override
  List<Object?> get props => [data];
}

// state
abstract class DefaultProjectSearchFilterState extends Equatable {
  final Map<SearchFilterCategory, List<String>> filterMap;

  const DefaultProjectSearchFilterState({required this.filterMap});
}

class InitProjectSearchFilterState extends DefaultProjectSearchFilterState {
  InitProjectSearchFilterState()
      : super(filterMap: {
          SearchFilterCategory.techSkill: [],
          SearchFilterCategory.position: [],
          SearchFilterCategory.process: [],
          SearchFilterCategory.deadline: [],
        });

  @override
  List<Object?> get props => [filterMap];
}

class CurrentProjectSearchFilterState extends DefaultProjectSearchFilterState {
  const CurrentProjectSearchFilterState({required super.filterMap});

  @override
  List<Object?> get props => [filterMap];
}
