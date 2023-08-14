import 'package:bloc/bloc.dart';
import 'package:dev_community/utils/helpers/helper.dart';
import 'package:equatable/equatable.dart';

class ProjectSearchOptionBloc extends Bloc<DefaultProjectSearchOptionEvent,
    DefaultProjectSearchOptionState> {
  ProjectSearchOptionBloc() : super(InitProjectSearchOptionState()) {
    on<DefaultProjectSearchOptionEvent>((event, emit) {
      if (event is InitProjectSearchOptionEvent) {
        _initProjectSearchOptionEventHandler(event, emit);
      } else if (event is SetProjectTechSkillOptionEvent) {
        _setProjectTechSkillOptionEventHandler(event, emit);
      } else if (event is SetProjectPositionOptionEvent) {
        _setProjectPositionOptionEventHandler(event, emit);
      } else if (event is SetProjectProcessOptionEvent) {
        _setProjectProcessOptionEventHandler(event, emit);
      } else if (event is SetProjectDeadlineOptionEvent) {
        _setProjectDeadlineOptionEventHandler(event, emit);
      }
    });
  }

  void _initProjectSearchOptionEventHandler(
      InitProjectSearchOptionEvent event, emit) {
    emit(InitProjectSearchOptionState());
  }

  void _setProjectTechSkillOptionEventHandler(
      SetProjectTechSkillOptionEvent event, emit) {
    List<String> copiedList =
        Helper().toggleListElement<String>(state.techSkill, event.data);

    emit(CurrentProjectSearchOptionState(
        techSkill: copiedList,
        position: state.position,
        process: state.process,
        deadline: state.deadline));
  }

  void _setProjectPositionOptionEventHandler(
      SetProjectPositionOptionEvent event, emit) {
    List<String> copiedList =
        Helper().toggleListElement<String>(state.position, event.data);

    emit(CurrentProjectSearchOptionState(
        techSkill: state.techSkill,
        position: copiedList,
        process: state.process,
        deadline: state.deadline));
  }

  void _setProjectProcessOptionEventHandler(
      SetProjectProcessOptionEvent event, emit) {
    List<String> copiedList =
        Helper().toggleListElement<String>(state.process, event.data);

    emit(CurrentProjectSearchOptionState(
        techSkill: state.techSkill,
        position: state.position,
        process: copiedList,
        deadline: state.deadline));
  }

  void _setProjectDeadlineOptionEventHandler(
      SetProjectDeadlineOptionEvent event, emit) {
    List<String> copiedList =
        Helper().toggleListElement<String>(state.deadline, event.data);

    emit(CurrentProjectSearchOptionState(
        techSkill: state.techSkill,
        position: state.position,
        process: state.process,
        deadline: copiedList));
  }
}

// event
abstract class DefaultProjectSearchOptionEvent extends Equatable {}

class InitProjectSearchOptionEvent extends DefaultProjectSearchOptionEvent {
  InitProjectSearchOptionEvent();
  @override
  List<Object?> get props => [];
}

class SetProjectTechSkillOptionEvent extends DefaultProjectSearchOptionEvent {
  final String data;

  SetProjectTechSkillOptionEvent({required this.data});

  @override
  List<Object?> get props => [data];
}

class SetProjectPositionOptionEvent extends DefaultProjectSearchOptionEvent {
  final String data;

  SetProjectPositionOptionEvent({required this.data});

  @override
  List<Object?> get props => [data];
}

class SetProjectProcessOptionEvent extends DefaultProjectSearchOptionEvent {
  final String data;

  SetProjectProcessOptionEvent({required this.data});

  @override
  List<Object?> get props => [data];
}

class SetProjectDeadlineOptionEvent extends DefaultProjectSearchOptionEvent {
  final String data;

  SetProjectDeadlineOptionEvent({required this.data});

  @override
  List<Object?> get props => [data];
}

// state
abstract class DefaultProjectSearchOptionState extends Equatable {
  final List<String> techSkill;
  final List<String> position;
  final List<String> process;
  final List<String> deadline;

  const DefaultProjectSearchOptionState(
      {required this.techSkill,
      required this.position,
      required this.process,
      required this.deadline});
}

class InitProjectSearchOptionState extends DefaultProjectSearchOptionState {
  InitProjectSearchOptionState()
      : super(techSkill: [], position: [], process: [], deadline: []);

  @override
  List<Object?> get props => [techSkill, position, process, deadline];
}

class CurrentProjectSearchOptionState extends DefaultProjectSearchOptionState {
  const CurrentProjectSearchOptionState(
      {required super.techSkill,
      required super.position,
      required super.process,
      required super.deadline});

  @override
  List<Object?> get props => [techSkill, position, process, deadline];
}
