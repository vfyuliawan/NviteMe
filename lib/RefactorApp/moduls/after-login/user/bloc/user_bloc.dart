import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/user/model_user_update.dart';
import 'package:nvite_me/RefactorApp/domain/service/user/user_service.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/user/model/model_user_response.dart';
import 'package:nvite_me/RefactorApp/utility/Utilities.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<GetUserDetail>((event, emit) async {
      emit(UserIsLoading());
      try {
        final getUserDetail = await UserService().getUserDetail();
        emit(
          UserIsSuccess(
            detailUser: ModelUserResponse(
                username: getUserDetail!.result.username,
                name: getUserDetail.result.name,
                email: getUserDetail.result.email,
                alamat: getUserDetail.result.alamat),
          ),
        );
      } catch (e) {
        emit(UserIsFailed(e.toString()));
      }
    });

    on<LogoutUser>((event, emit) async {
      emit(UserIsLoading());
      try {
        await UserService().userLogout().then((value) {
          if (value = true) {
            event.context.go("/login");
            Utilities().showMessage(message: "Berhasil Logout");
          } else {
            emit(UserIsFailed("Logout Gagal"));
          }
        });
      } catch (e) {
        emit(UserIsFailed(e.toString()));
      }
    });

    on<EditUser>((event, emit) async {
      try {
        final getUserDetail = await UserService().getUserDetail();
        ModelUserResponse userEditd = ModelUserResponse(
            username: getUserDetail!.result.username,
            name: getUserDetail.result.name,
            email: getUserDetail.result.email,
            alamat: getUserDetail.result.alamat);
        emit(
          UserIsEdited(userEditd),
        );
      } catch (e) {
        emit(UserIsFailed(e.toString()));
      }
    });

    on<UpdatedForm>((event, emit) async {
      emit(UserIsEdited(event.detailUser));
    });

    on<OnSubmitUpdate>((event, emit) async {
      try {
        final currentState = state as UserIsEdited;
        emit(UserIsLoading());
        ModelUserUpdateInterface props = ModelUserUpdateInterface(
            name: currentState.detailUser.name,
            password: "password",
            alamat: currentState.detailUser.alamat,
            email: currentState.detailUser.email);
        await UserService().updateUser(props).then((value) {
          if (value!.code == "00") {
            emit(UserIsSuccess(
                detailUser: ModelUserResponse(
                    username: value.result.username,
                    name: value.result.name,
                    alamat: value.result.alamat,
                    email: value.result.email)));
            Utilities().showMessage(message: "Berhasil Diedit");
          } else {
            emit(UserIsFailed(value.message));
          }
        });
      } catch (e) {
        emit(UserIsFailed(e.toString()));
        print(e.toString());
      }
    });
  }
}
