part of 'screen_limit_bloc.dart';

@immutable
abstract class ScreenLimitState {}

class ScreenLimitInitial extends ScreenLimitState {}

class DeviceCountCorrect extends ScreenLimitState {}

class DeviceCountOverLimit extends ScreenLimitState {}
