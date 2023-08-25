import 'package:bloc/bloc.dart';
import 'package:dev_community/models/party_article_model.dart';
import 'package:equatable/equatable.dart';

class PartyArticleBloc extends Bloc<PartyArticleEvent, PartyArticleState> {
  PartyArticleBloc() : super(InitPartyArticleState());
}

// event
abstract class PartyArticleEvent extends Equatable {}

// state
abstract class PartyArticleState extends Equatable {
  final List<PartyArticleModel> partyArticleModel;

  const PartyArticleState({required this.partyArticleModel});
}

class InitPartyArticleState extends PartyArticleState {
  InitPartyArticleState()
      : super(partyArticleModel: [
          PartyArticleModel(
              id: "1",
              createdDt: DateTime.now(),
              poster: "갈무리",
              title: "[APP] 영화영상 구인구직 플랫폼 \"안드로이드 개발자\" 모집합니다.",
              description: "안녕하세요, 첫번째 게시물입니다.",
              techSkill: ["Kotlin"],
              position: {
                "Android": {"current": 0, "max": 2},
              },
              process: "온라인",
              location: "서울특별시",
              type: "프로젝트",
              deadline: DateTime(2023, 10, 1),
              startDate: DateTime(2023, 10, 8),
              estimatedPeriod: "2개월"),
          PartyArticleModel(
              id: "2",
              createdDt: DateTime.now(),
              poster: "다리우스",
              title: "같이 사이드 프로젝트 하면서 역량 쌓으실 프론트 한분 구합니다!",
              description: "안녕하세요, 두번째 게시물입니다.",
              techSkill: ["React", "NestJS", "AWS", "Docker"],
              position: {
                "프론트엔드": {"current": 0, "max": 1},
              },
              process: "온/오프라인",
              location: "전라북도",
              type: "프로젝트",
              deadline: DateTime(2023, 9, 23),
              startDate: DateTime(2023, 10, 1),
              estimatedPeriod: "6개월"),
          PartyArticleModel(
              id: "3",
              createdDt: DateTime.now(),
              poster: "최동규",
              title: "창업팀 개발자 모집합니다!",
              description: "안녕하세요, 세번째 게시물입니다.",
              techSkill: ["Typescript", "React", "Next.js"],
              position: {
                "프론트엔드": {"current": 0, "max": 2},
                "백엔드": {"current": 0, "max": 3},
              },
              process: "오프라인",
              location: "부산광역시",
              type: "프로젝트",
              deadline: DateTime(2023, 8, 30),
              startDate: DateTime(2023, 9, 1),
              estimatedPeriod: "3개월"),
          PartyArticleModel(
              id: "4",
              createdDt: DateTime.now(),
              poster: "핑이",
              title: "수원 아주대 인근 모각코 하실분",
              description: "안녕하세요, 네번째 게시물입니다.",
              techSkill: ["Javascript", "Java"],
              position: {
                "프론트엔드": {"current": 0, "max": 2},
                "백엔드": {"current": 0, "max": 2},
              },
              process: "오프라인",
              location: "경기도",
              type: "스터디",
              deadline: DateTime(2023, 12, 23),
              startDate: DateTime(2024, 1, 1),
              estimatedPeriod: "1개월"),
        ]);

  @override
  List<Object?> get props => [partyArticleModel];
}
