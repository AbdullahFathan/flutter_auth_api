import 'package:bloc/bloc.dart';
import 'package:login_api/repository/auth_repository.dart';
import 'package:login_api/repository/cache_repository.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<IsHasLogin>(
      (event, emit) async {
        try {
          var response = await Cache.getData('token_user');
          if (response != null) {
            emit(Authenticated());
          } else {
            emit(Unauthenticated());
          }
        } catch (eror) {
          emit(AuthenticatedEror());
        }
      },
    );

    on<Login>((event, emit) async {
      emit(AuthLoading());
      try {
        var response =
            await AuthRepository().loginServices(event.email, event.password);
        response ? emit(AuthSuccess()) : emit(AuthEror("Cannot Login"));
        print("Login response has send [auth_bloc.dart]");
      } catch (eror) {
        emit(AuthEror(eror.toString()));
        print("Login has failed [auth_bloc.dart]");
      }
    });
  }
}
