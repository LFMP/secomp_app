import 'dart:convert';
import 'package:flutter/material.dart';
// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/blocs/evento.dart';
import 'package:pet_app/utils/snack_bar.dart';
// Utils
import 'package:pet_app/utils/style.dart';
// Model
import 'package:pet_app/models/evento.dart';
// Foreign
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class EventsPage extends StatefulWidget{

  createState() => _EventsPageState();  
}

class _EventsPageState extends State<EventsPage>{
  // final _refreshController = RefreshController(initialRefresh: false);

  Future<void> _onRefresh(EventoBloc _bloc) async{
    _bloc.dispatch(EventoLoad());    
  }

  
  @override
  Widget build(BuildContext context) {
    final EventoBloc _EventoBloc = BlocProvider.of<EventoBloc>(context);

    return BlocListener(
      bloc: _EventoBloc,
      listener: (context, state){
        if (state is EventoLoadFailed)
          SimpleSnackBar.showSnackBar(
            context,
            state.error.message
          );
      },
      child: BlocBuilder(
        bloc: _EventoBloc,
        builder: (context, state){
          if (state is EventoEmpty)
            _EventoBloc.dispatch(EventoLoad());

          final _events = state is EventoLoading ? [] : state.events;
          
          return Scaffold(
            appBar: AppBar(
              title: Text('Eventos'),
            ),
            body: LiquidPullToRefresh(
              onRefresh: () => _onRefresh(_EventoBloc),	
              showChildOpacityTransition: false,
              height: AppStyle.pullHeight,
              color: AppStyle.colorBritishRacingGreen,
              child: ListView.builder(
                itemCount: _events.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    leading: Image.memory(base64Decode(_events[index].foto.toString().substring(23))),
                    title: Text(
                      _events[index].nome,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      _events[index].description
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