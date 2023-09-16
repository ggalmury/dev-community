import 'package:dev_community/apis/auth_api.dart';
import 'package:dev_community/models/user_account.dart';
import 'package:dev_community/utils/logger.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserAccountBloc extends Bloc<UserAccountEvent, UserAccountState> {
  final AuthApi authApi;

  UserAccountBloc({required this.authApi}) : super(InitUserAccountState()) {
    on<UserAccountEvent>((event, emit) async {
      if (event is KakaoLoginEvent) {
        await _kakaoLogin(event, emit);
      } else if (event is LogoutEvent) {
        _logout(event, emit);
      } else if (event is SubmitAccountErrorEvent) {
        _submitError(event, emit);
      }
    });
  }

  Future<void> _kakaoLogin(KakaoLoginEvent event, emit) async {
    try {
      UserAccount userAccount = await authApi.fetchKakaoLogin();

      emit(CurrentUserAccountState(
          userAccount: userAccount, isLoggedIn: true, exception: null));

      loggerNoStack.i("Kakao account saved in bloc");
    } catch (e) {
      emit(CurrentUserAccountState(
          userAccount: state.userAccount,
          isLoggedIn: state.isLoggedIn,
          exception: e as Exception));
    }
  }

  void _logout(LogoutEvent event, emit) {
    emit(InitUserAccountState());
  }

  void _submitError(SubmitAccountErrorEvent event, emit) {
    emit(CurrentUserAccountState(
        userAccount: state.userAccount,
        isLoggedIn: state.isLoggedIn,
        exception: null));
  }
}

// event
abstract class UserAccountEvent extends Equatable {}

class KakaoLoginEvent extends UserAccountEvent {
  KakaoLoginEvent();

  @override
  List<Object?> get props => [];
}

class LogoutEvent extends UserAccountEvent {
  LogoutEvent();

  @override
  List<Object?> get props => [];
}

class SubmitAccountErrorEvent extends UserAccountEvent {
  SubmitAccountErrorEvent();

  @override
  List<Object?> get props => [];
}

// state
abstract class UserAccountState extends Equatable {
  final UserAccount userAccount;
  final bool isLoggedIn;
  final Exception? exception;

  const UserAccountState(
      {required this.userAccount,
      required this.isLoggedIn,
      required this.exception});
}

class InitUserAccountState extends UserAccountState {
  InitUserAccountState()
      : super(
            userAccount: UserAccount.init(),
            isLoggedIn: false,
            exception: null);

  @override
  List<Object?> get props => [userAccount, isLoggedIn, exception];
}

class CurrentUserAccountState extends UserAccountState {
  const CurrentUserAccountState(
      {required super.userAccount,
      required super.isLoggedIn,
      required super.exception});

  @override
  List<Object?> get props => [userAccount, isLoggedIn, exception];
}
