import 'package:dev_community/apis/auth_api.dart';
import 'package:dev_community/models/token.dart';
import 'package:dev_community/models/user_account.dart';
import 'package:dev_community/repositories/key_value_store.dart';
import 'package:dev_community/utils/logger.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserAccountBloc extends Bloc<UserAccountEvent, UserAccountState> {
  final AuthApi authApi;
  final KeyValueStore keyValueStore;

  UserAccountBloc({required this.authApi, required this.keyValueStore})
      : super(InitUserAccountState()) {
    on<UserAccountEvent>((event, emit) async {
      if (event is AutoLoginEvent) {
        await _autoLogin(event, emit);
      } else if (event is KakaoLoginEvent) {
        await _kakaoLogin(event, emit);
      } else if (event is LogoutEvent) {
        await _logout(event, emit);
      } else if (event is SubmitAccountErrorEvent) {
        _submitError(event, emit);
      }
    });
  }

  Future<void> _autoLogin(AutoLoginEvent event, emit) async {
    try {
      Token? token = keyValueStore.getToken();

      //TODO: implement auth token not exists error
      if (token == null) return;

      UserAccount userAccount = await authApi.fetchAutoLogin(token);

      await keyValueStore.setToken(userAccount.token).then((_) {
        emit(CurrentUserAccountState(
            userAccount: userAccount, isLoggedIn: true, exception: null));
      });
    } catch (e) {
      await keyValueStore.removeToken().then((_) {
        emit(CurrentUserAccountState(
            userAccount: state.userAccount,
            isLoggedIn: state.isLoggedIn,
            exception: e as Exception));
      });

      loggerNoStack.e("Error occurred in auto login process");
    }
  }

  Future<void> _kakaoLogin(KakaoLoginEvent event, emit) async {
    try {
      UserAccount userAccount = await authApi.fetchKakaoLogin();

      await keyValueStore.setToken(userAccount.token).then((_) {
        emit(CurrentUserAccountState(
            userAccount: userAccount, isLoggedIn: true, exception: null));
      });

      loggerNoStack.i("Kakao user logged in: ${state.userAccount.uuid}");
    } catch (e) {
      emit(CurrentUserAccountState(
          userAccount: state.userAccount,
          isLoggedIn: state.isLoggedIn,
          exception: e as Exception));

      loggerNoStack.e("Error occurred in Kakao login process");
    }
  }

  Future<void> _logout(LogoutEvent event, emit) async {
    try {
      bool isLoggedOut = await authApi.fetchLogout(state.userAccount.uuid);

      if (isLoggedOut) {
        await keyValueStore.removeToken().then((_) {
          emit(InitUserAccountState());
        });

        loggerNoStack.i("User logged out");
      }
    } catch (e) {
      emit(CurrentUserAccountState(
          userAccount: state.userAccount,
          isLoggedIn: state.isLoggedIn,
          exception: e as Exception));

      loggerNoStack.e("Error occurred in logout process");
    }
  }

  void _submitError(SubmitAccountErrorEvent event, emit) {
    emit(CurrentUserAccountState(
        userAccount: state.userAccount,
        isLoggedIn: state.isLoggedIn,
        exception: null));

    loggerNoStack.i("Reset user error");
  }
}

// event
abstract class UserAccountEvent extends Equatable {}

class AutoLoginEvent extends UserAccountEvent {
  @override
  List<Object?> get props => [];
}

class KakaoLoginEvent extends UserAccountEvent {
  @override
  List<Object?> get props => [];
}

class LogoutEvent extends UserAccountEvent {
  @override
  List<Object?> get props => [];
}

class SubmitAccountErrorEvent extends UserAccountEvent {
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
