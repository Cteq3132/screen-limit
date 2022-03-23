import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screen_limit/app/app.dart';
import 'package:screen_limit/screen_limit/bloc/screen_limit_bloc.dart';

class ScreenLimitListener extends StatelessWidget {
  const ScreenLimitListener({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ScreenLimitBloc, ScreenLimitState>(
      listener: (context, state) {
        if (state is DeviceCountOverLimit) {
          context.read<AppBloc>().add(AppLogoutRequested());
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Ooops, too many simultaneous screens'),
              ),
            );
        }
      },
      child: child,
    );
  }
}
