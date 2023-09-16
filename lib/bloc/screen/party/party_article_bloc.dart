import 'package:bloc/bloc.dart';
import 'package:dev_community/apis/party_api.dart';
import 'package:dev_community/models/party_article.dart';
import 'package:equatable/equatable.dart';

class PartyArticleBloc extends Bloc<PartyArticleEvent, PartyArticleState> {
  final PartyApi partyApi;

  PartyArticleBloc({required this.partyApi}) : super(InitPartyArticleState()) {
    on<PartyArticleEvent>((event, emit) async {
      if (event is FetchPartyArticleEvent) await _fetchArticle(event, emit);
    });
  }

  Future<void> _fetchArticle(FetchPartyArticleEvent event, emit) async {
    try {
      List<PartyArticle> result = await partyApi.getArticle();

      emit(CurrentPartyArticleState(partyArticleModel: result));
    } catch (e) {
      // 데이터 조회 실패 예외처리
    }
  }
}

// event
abstract class PartyArticleEvent extends Equatable {}

class FetchPartyArticleEvent extends PartyArticleEvent {
  FetchPartyArticleEvent();

  @override
  List<Object?> get props => [];
}

// state
abstract class PartyArticleState extends Equatable {
  final List<PartyArticle> partyArticleModel;

  const PartyArticleState({required this.partyArticleModel});
}

class InitPartyArticleState extends PartyArticleState {
  InitPartyArticleState() : super(partyArticleModel: []);

  @override
  List<Object?> get props => [partyArticleModel];
}

class CurrentPartyArticleState extends PartyArticleState {
  const CurrentPartyArticleState({required super.partyArticleModel});

  @override
  List<Object?> get props => [partyArticleModel];
}
