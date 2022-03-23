part of 'screen_limit_bloc.dart';

@immutable
abstract class ScreenLimitEvent {}

class CheckDeviceCount extends ScreenLimitEvent {}

class DecreaseDeviceCount extends ScreenLimitEvent {}
