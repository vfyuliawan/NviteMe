import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/user/model_user_update.dart';
import 'package:nvite_me/RefactorApp/domain/service/user/user_service.dart';
import 'package:nvite_me/RefactorApp/domain/service/version/version_service.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/user/model/model_user_response.dart';
import 'package:nvite_me/RefactorApp/moduls/after-login/user/model/model_version.dart';
import 'package:nvite_me/RefactorApp/utility/Utilities.dart';
import 'package:nvite_me/constans.dart';
import 'package:nvite_me/utils/utils.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  // final ImagePicker _picker = ImagePicker();

  UserBloc() : super(UserInitial()) {
    on<GetUserDetail>((event, emit) async {
      emit(UserIsLoading());
      try {
        await UserService().getUserDetail().then((value) async {
          if (value != null) {
            print(value.result.role + "fasdfasdfa");
            final getVErsion = await VersionService().getVersionActive();
            if (getVErsion!.result.currentVersion == Constans.version) {
              emit(
                UserIsSuccess(
                  detailUser: ModelUserResponse(
                      username: value.result.username,
                      name: value.result.name,
                      email: value.result.email,
                      alamat: value.result.alamat,
                      role: value.result.role,
                      photo: value.result.photo),
                ),
              );
            } else {
              emit(UserIsVersionUpdate(
                  version: ModelVersion(
                      versionId: getVErsion.result.versionId,
                      versionActive: getVErsion.result.currentVersion)));
              emit(
                UserIsSuccess(
                  detailUser: ModelUserResponse(
                      username: value.result.username,
                      name: value.result.name,
                      email: value.result.email,
                      alamat: value.result.alamat,
                      photo: value.result.photo,
                      role: value.result.role),
                ),
              );
            }
          } else {
            event.context.go("/login");
            Utilities().showMessage(message: value!.messageError);
          }
        });
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
            Utility().deletePreference(key: Constans.bearerToken);
          } else {
            emit(UserIsFailed("Logout Gagal"));
          }
        });
      } catch (e) {
        emit(UserIsFailed(e.toString()));
      }
    });

    on<EditUser>((event, emit) async {
      emit(UserIsLoading());
      try {
        await UserService().getUserDetail().then((value) {
          if (value != null) {
            ModelUserResponse userEditd = ModelUserResponse(
                username: value.result.username,
                name: value.result.name,
                email: value.result.email,
                alamat: value.result.alamat,
                photo: value.result.photo);
            emit(
              UserIsEdited(userEditd),
            );
          } else {
            event.context.go("/login");
            Utilities().showMessage(message: value!.messageError);
          }
        });
      } catch (e) {
        emit(UserIsFailed(e.toString()));
      }
    });

    on<UpdatedForm>((event, emit) async {
      emit(UserIsEdited(event.detailUser));
    });

    on<OnEditCencel>((event, emit) {
      emit(UserIsSuccess(detailUser: event.detailUser));
    });

    on<OnSubmitUpdate>((event, emit) async {
      try {
        final currentState = state as UserIsEdited;
        emit(UserIsLoading());
        var isSubmit = currentState.detailUser.email.length > 3 &&
            currentState.detailUser.name.length > 3 &&
            currentState.detailUser.alamat.length > 3;
        if (isSubmit) {
          ModelUserUpdateInterface props = ModelUserUpdateInterface(
              name: currentState.detailUser.name,
              password: "password",
              alamat: currentState.detailUser.alamat,
              email: currentState.detailUser.email,
              photo: currentState.detailUser.photo);
          await UserService().updateUser(props).then((value) {
            if (value!.code == "00") {
              emit(UserIsSuccess(
                  detailUser: ModelUserResponse(
                      username: value.result.username,
                      name: value.result.name,
                      alamat: value.result.alamat,
                      email: value.result.email,
                      photo: value.result.photo)));
              Utilities().showMessage(message: "Berhasil Diedit");
            } else {
              emit(UserIsFailed(value.message));
            }
          });
        } else {
          Utilities().showMessage(message: "to Sort");
          emit(UserIsEdited(currentState.detailUser));
        }
      } catch (e) {
        emit(UserIsFailed(e.toString()));
        print(e.toString());
      }
    });

    on<OnPickImage>((event, emit) async {
      final currentState = state as UserIsEdited;
      await Utilities().pickedImage().then((value) {
        if (value != null) {
          emit(UserIsEdited(currentState.detailUser.copyWith(photo: value)));
        }
      });
    });
  }
}
