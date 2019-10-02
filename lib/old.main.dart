import 'package:flutter/material.dart';
// Pages
import 'package:pet_app/pages/login_page.dart';
// Utils
import 'package:pet_app/utils/style.dart';
// Bloc 
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/blocs/auth.dart';
import 'package:pet_app/blocs/evento.dart';
import 'package:pet_app/blocs/atividade.dart';
import 'package:pet_app/blocs/turma.dart';

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
  final turmaBloc = TurmaBloc(authBloc: authBloc);
  final atividadeBloc = AtividadeBloc(
    authBloc: authBloc,
    turmaBloc: turmaBloc
  );
  final eventoBloc = EventoBloc(
    authBloc: authBloc,
    atividadeBloc: atividadeBloc
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          builder: (context) => authBloc,
        ),
        BlocProvider<EventoBloc>(
          builder: (context) => eventoBloc,
        ),
        BlocProvider<AtividadeBloc>(
          builder: (context) => atividadeBloc,
        ),
        BlocProvider<TurmaBloc>(
          builder: (context) => turmaBloc,
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
      title: 'SECOMP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppStyle.colorBritishRacingGreen
      ),
      home: LoginPage(),
    );
  }
}