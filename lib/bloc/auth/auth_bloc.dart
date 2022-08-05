import 'package:bloc/bloc.dart';
import 'package:login_api/models/register.dart';
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
          var response = await Cache.getData('user_token');

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

        // if response == true, so loginServices has succes
        response ? emit(AuthSuccess()) : emit(AuthEror("Cannot Login"));

        print("Login response has send [auth_bloc.dart]");
      } catch (eror) {
        emit(AuthEror(eror.toString()));
        print("Login has failed [auth_bloc.dart]");
      }
    });

    on<Logout>(
      (event, emit) async {
        emit(AuthenticatedLoading());
        await AuthRepository().logoutServices();
        emit(Unauthenticated());
      },
    );

    on<Register>(
      (event, emit) async {
        emit(AuthLoading());
        try {
          var response = await AuthRepository()
              .registerServices(event.email, event.password);
          if (response != null) {
            emit(RegisterSuccess(response));
          } else {
            emit(AuthEror("cannot resgitser"));
          }
          print("Register response has send [auth_bloc.dart]");
        } catch (eror) {
          emit(AuthEror(eror.toString()));
          print("Register has failed [auth_bloc.dart] = ${eror.toString()}");
        }
      },
    );
  }
}
