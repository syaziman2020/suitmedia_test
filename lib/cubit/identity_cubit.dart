import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/identity_model.dart';
import '../services/identity_service.dart';

part 'identity_state.dart';

class IdentityCubit extends Cubit<IdentityState> {
  IdentityCubit() : super(IdentityInitial());

  void getIdentityList(int page) async {
    try {
      emit(IdentityLoading());
      IdentityModel? identityListResult =
          await IdentityService().getIdentity(page);
      identityListResult ?? (throw Exception('Data Kosong'));
      emit(
        IdentitySuccess(identityListResult.page, identityListResult.totalPages,
            identityListResult.data),
      );
    } on DioError catch (e) {
      emit(IdentityFailed(e.message));
    }
  }

  Future refetchIdentityList(int page) async {
    try {
      IdentityModel? identityModel = await IdentityService().getIdentity(page);
      await Future.delayed(const Duration(seconds: 1));

      if (identityModel.data!.isNotEmpty) {
        List<Data>? prevData = (state as IdentitySuccess).listIdentity;

        emit(
          IdentitySuccess(
            identityModel.page,
            identityModel.totalPages,
            prevData! + identityModel.data!,
          ),
        );
      }
    } on DioError catch (e) {
      emit(IdentityFailed(e.message));
    }
  }
}
