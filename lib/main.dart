import 'package:flutter/material.dart';
import 'package:pet_app/blocs/auth.dart';
import 'package:pet_app/blocs/event.dart';
// Pages
import 'package:pet_app/pages/login_page.dart';
// Bloc 
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final authBloc = AuthBloc()..dispatch(AuthAppStarted());
  final eventBloc = EventBloc(authBloc: authBloc);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          builder: (context) => authBloc,
        ),
        BlocProvider<EventBloc>(
          builder: (context) => eventBloc,
        )
      ],
      child: App()
    )
  );
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PET-Informática',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}