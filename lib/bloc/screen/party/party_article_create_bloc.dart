import 'package:dev_community/main.dart';
import 'package:dev_community/models/party_article_create_model.dart';
import 'package:dev_community/utils/constant.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PartyArticleCreateBloc
    extends Bloc<PartyArticleCreateEvent, PartyArticleCreateState> {
  PartyArticleCreateBloc() : super(InitPartyArticleCreateState()) {
    on<PartyArticleCreateEvent>((event, emit) {
      if (event is SetPartyArticleCreateTypeEvent) {
        _setType(event, emit);
      } else if (event is SetPartyArticleCreateProcessEvent) {
        _setProcess(event, emit);
      } else if (event is SetPartyArticleCreateLocationEvent) {
        _setLocation(event, emit);
      } else if (event is SubmitPartyArticleCreateEvent) {
        _submit(event, emit);
      }
    });
  }

  void _setType(SetPartyArticleCreateTypeEvent event, emit) {
    PartyArticleCreateModel newState =
        state.partyArticleCreateModel.copyWith(type: event.type);

    emit(CurrentPartyArticleCreateState(partyArticleCreateModel: newState));
  }

  void _setProcess(SetPartyArticleCreateProcessEvent event, emit) {
    PartyArticleCreateModel newState =
        state.partyArticleCreateModel.copyWith(process: event.process);
    ;

    emit(CurrentPartyArticleCreateState(partyArticleCreateModel: newState));
  }

  void _setLocation(SetPartyArticleCreateLocationEvent event, emit) {
    PartyArticleCreateModel newState =
        state.partyArticleCreateModel.copyWith(location: event.location);

    emit(CurrentPartyArticleCreateState(partyArticleCreateModel: newState));
  }

  void _submit(SubmitPartyArticleCreateEvent event, emit) {
    PartyArticleCreateModel newState =
        state.partyArticleCreateModel.copyWith(title: event.title);

    emit(CurrentPartyArticleCreateState(partyArticleCreateModel: newState));

    loggerNoStack.i(state.partyArticleCreateModel.toJson());
  }
}

// event
abstract class PartyArticleCreateEvent extends Equatable {}

class SetPartyArticleCreateTypeEvent extends PartyArticleCreateEvent {
  final String type;

  SetPartyArticleCreateTypeEvent({required this.type});

  @override
  List<Object?> get props => [type];
}

class SetPartyArticleCreateProcessEvent extends PartyArticleCreateEvent {
  final String process;

  SetPartyArticleCreateProcessEvent({required this.process});

  @override
  List<Object?> get props => [process];
}

class SetPartyArticleCreateLocationEvent extends PartyArticleCreateEvent {
  final String location;

  SetPartyArticleCreateLocationEvent({required this.location});

  @override
  List<Object?> get props => [location];
}

class SubmitPartyArticleCreateEvent extends PartyArticleCreateEvent {
  final String title;

  SubmitPartyArticleCreateEvent({required this.title});

  @override
  List<Object?> get props => [title];
}

// state
abstract class PartyArticleCreateState extends Equatable {
  final PartyArticleCreateModel partyArticleCreateModel;

  const PartyArticleCreateState({required this.partyArticleCreateModel});
}

class InitPartyArticleCreateState extends PartyArticleCreateState {
  InitPartyArticleCreateState()
      : super(
            partyArticleCreateModel:
                PartyArticleCreateModel(poster: "핑이", type: type[0]));

  @override
  List<Object?> get props => [partyArticleCreateModel];
}

class CurrentPartyArticleCreateState extends PartyArticleCreateState {
  const CurrentPartyArticleCreateState(
      {required super.partyArticleCreateModel});

  @override
  List<Object?> get props => [partyArticleCreateModel];
}
