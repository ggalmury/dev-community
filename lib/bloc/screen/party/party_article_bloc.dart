import 'package:bloc/bloc.dart';
import 'package:dev_community/apis/party_api.dart';
import 'package:dev_community/models/party_article.dart';
import 'package:dev_community/utils/logger.dart';
import 'package:equatable/equatable.dart';

class PartyArticleBloc extends Bloc<PartyArticleEvent, PartyArticleState> {
  final PartyApi partyApi;

  PartyArticleBloc({required this.partyApi}) : super(InitPartyArticleState()) {
    on<PartyArticleEvent>((event, emit) async {
      if (event is FetchPartyArticleEvent) {
        await _fetchArticle(event, emit);
      } else if (event is SubmitPartyArticleEvent) {
        _submitError(event, emit);
      }
    });
  }

  Future<void> _fetchArticle(FetchPartyArticleEvent event, emit) async {
    try {
      List<PartyArticle> result = await partyApi.getArticle();

      emit(
          CurrentPartyArticleState(partyArticleModel: result, exception: null));
    } catch (e) {
      emit(CurrentPartyArticleState(
          partyArticleModel: state.partyArticleModel,
          exception: e as Exception));

      loggerNoStack.e("Error occurred in fetching party articles");
    }
  }

  void _submitError(SubmitPartyArticleEvent event, emit) {
    emit(CurrentPartyArticleState(
        partyArticleModel: state.partyArticleModel, exception: null));

    loggerNoStack.i("Reset party article error");
  }
}

// event
abstract class PartyArticleEvent extends Equatable {}

class FetchPartyArticleEvent extends PartyArticleEvent {
  @override
  List<Object?> get props => [];
}

class SubmitPartyArticleEvent extends PartyArticleEvent {
  @override
  List<Object?> get props => [];
}

// state
abstract class PartyArticleState extends Equatable {
  final List<PartyArticle> partyArticleModel;
  final Exception? exception;

  const PartyArticleState(
      {required this.partyArticleModel, required this.exception});
}

class InitPartyArticleState extends PartyArticleState {
  InitPartyArticleState() : super(partyArticleModel: [], exception: null);

  @override
  List<Object?> get props => [partyArticleModel, exception];
}

class CurrentPartyArticleState extends PartyArticleState {
  const CurrentPartyArticleState(
      {required super.partyArticleModel, required super.exception});

  @override
  List<Object?> get props => [partyArticleModel, exception];
}
