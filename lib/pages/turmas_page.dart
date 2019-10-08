import 'package:flutter/material.dart';
// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/blocs/turma.dart';
// Utils
import 'package:pet_app/utils/snack_bar.dart';
import 'package:pet_app/utils/style.dart';
import 'package:pet_app/utils/slider.dart';
// Model
import 'package:pet_app/models/turma.dart';
// Foreign
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
// Pages
import 'package:pet_app/pages/inscricoes_page.dart';

class TurmasPage extends StatefulWidget{

  createState() => _TurmasPageState();
}

class _TurmasPageState extends State<TurmasPage>{

  Future<void> _onRefresh(TurmaBloc _bloc) async{
    _bloc.dispatch(TurmaLoad(
      atividade: _bloc.currentAtividade
    ));
  }

  void _selectTurma(
    TurmaModel turma,
    TurmaBloc _bloc,
    BuildContext context
  ) async {
    _bloc.dispatch(TurmaApply(
      chosenTurma: turma
    ));
    await Navigator.of(context).push(SlideRoute(
      page: InscricoesPage(),
      direction: SlideDirection.BOTTOM_TOP
    ));
  }

  @override
  Widget build(BuildContext context) {
    final TurmaBloc _turmaBloc = BlocProvider.of<TurmaBloc>(context);

    return BlocListener(
      bloc: _turmaBloc,
      listener: (context, state){
        if (state is TurmaLoadFailed)
          SimpleSnackBar.showSnackBar(
            context,
            state.error.message
          );
      
      },
      child: BlocBuilder(
        bloc: _turmaBloc,
        builder: (context, state){

          final List<TurmaModel> _turmas =
            (state is TurmaLoading || state is TurmaEmpty) ?
            [] : state.turmas;
         
          return Scaffold(
            appBar: AppBar(
              title: Text('Turmas - ${state.atividade?.nome ?? ""}'),
            ),
            body: LiquidPullToRefresh(
              onRefresh: () => _onRefresh(_turmaBloc),	
              showChildOpacityTransition: false,
              height: AppStyle.pullHeight,
              color: AppStyle.colorBritishRacingGreen,
              child: ListView.builder(
                itemCount: _turmas.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    title: Text(
                      _turmas[index].nome,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(_turmas[index].description),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () => _selectTurma(
                      _turmas[index],
                      _turmaBloc,
                      context
                    ),
                  ),
                )
              ),
            )
          );
        },
      )
    );
  }

}