import 'dart:convert';
import 'package:flutter/material.dart';
// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/blocs/atividade.dart';
// Utils
import 'package:pet_app/utils/snack_bar.dart';
import 'package:pet_app/utils/style.dart';
// Model
import 'package:pet_app/models/evento.dart';
// Foreign
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class AtividadesPage extends StatefulWidget{

  createState() => _AtividadesPageState();
}

class _AtividadesPageState extends State<AtividadesPage>{

  Future<void> _onRefresh(AtividadeBloc _bloc) async{
    _bloc.dispatch(AtividadeLoad(
      evento: _bloc.currentEvento
    ));
  }

  
  @override
  Widget build(BuildContext context) {
    final AtividadeBloc _atividadeBloc = BlocProvider.of<AtividadeBloc>(context);

    return BlocListener(
      bloc: _atividadeBloc,
      listener: (context, state){
        if (state is AtividadeLoadFailed)
          SimpleSnackBar.showSnackBar(
            context,
            state.error.message
          );
      
      },
      child: BlocBuilder(
        bloc: _atividadeBloc,
        builder: (context, state){

          final _atividades =
            (state is AtividadeLoading || state is AtividadeEmpty) ?
            [] : state.atividades;
          
          return Scaffold(
            appBar: AppBar(
              title: Text('Atividades - ${state.evento?.nome ?? ""}'),
            ),
            body: LiquidPullToRefresh(
              onRefresh: () => _onRefresh(_atividadeBloc),	
              showChildOpacityTransition: false,
              height: AppStyle.pullHeight,
              color: AppStyle.colorBritishRacingGreen,
              child: ListView.builder(
                itemCount: _atividades.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    title: Text(
                      _atividades[index].nome,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      _atividades[index].descricao
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () => print('ok'),
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