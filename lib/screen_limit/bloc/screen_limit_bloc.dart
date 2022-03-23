// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'screen_limit_event.dart';
part 'screen_limit_state.dart';

class ScreenLimitBloc extends Bloc<ScreenLimitEvent, ScreenLimitState> {
  ScreenLimitBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(ScreenLimitInitial()) {
    on<CheckDeviceCount>(_onCheckDeviceCount);
    on<DecreaseDeviceCount>(_onDecreaseDeviceCount);
    listenToUserChanges();
  }
  final AuthenticationRepository _authenticationRepository;

  late StreamSubscription userSubscription;
  late DatabaseReference ref;
  bool deviceCountExceeded = false;

  void listenToUserChanges() {
    userSubscription = _authenticationRepository.user.listen((user) {
      if (user == User.empty) {
        add(DecreaseDeviceCount());
      } else {
        add(CheckDeviceCount());
      }
    });
  }

  @override
  Future<void> close() {
    userSubscription.cancel();
    return super.close();
  }

  Future<void> _onCheckDeviceCount(
    CheckDeviceCount event,
    Emitter<ScreenLimitState> emit,
  ) async {
    if (state is ScreenLimitInitial) {
      final userId = _authenticationRepository.currentUser.id;
      ref = FirebaseDatabase.instance.ref('logged_in_users/$userId/');

      deviceCountExceeded = false;

      await ref
          .set(ServerValue.increment(1))
          .onError<FirebaseException>((error, _) async {
        if (error.code == 'permission-denied') {
          deviceCountExceeded = true;
          return _onDeviceCountExceeded(emit, ref);
        }
      });

      if (!deviceCountExceeded) {
        await ref.onDisconnect().set(ServerValue.increment(-1));
        emit(DeviceCountCorrect());
      }
    }
  }

  Future<void> _onDecreaseDeviceCount(
    DecreaseDeviceCount event,
    Emitter<ScreenLimitState> emit,
  ) async {
    if (state is DeviceCountCorrect) {
      await ref.set(ServerValue.increment(-1));
      await ref.onDisconnect().cancel();
      emit(ScreenLimitInitial());
    }
  }

  Future<void> _onDeviceCountExceeded(
    Emitter<ScreenLimitState> emit,
    DatabaseReference ref,
  ) async {
    emit(DeviceCountOverLimit());
    emit(ScreenLimitInitial());
  }
}
