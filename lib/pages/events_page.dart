import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/blocs/event.dart';
import 'package:pet_app/widgets/commons/loading_widget.dart';
// Model
import 'package:pet_app/models/event.dart';

class EventsPage extends StatefulWidget{

  createState() => _EventsPageState();  
}

class _EventsPageState extends State<EventsPage>{
  
  @override
  Widget build(BuildContext context) {
    final EventBloc _eventBloc = BlocProvider.of<EventBloc>(context);

    return BlocListener(
      bloc: _eventBloc,
      listener: (context, state) async{
        
      },
      child: BlocBuilder(
        bloc: _eventBloc,
        builder: (context, state){
          if (state is EventEmpty)
            _eventBloc.dispatch(EventLoad());

          final _child = state is EventLoading ? LoadingWidget() : 
          ListView.builder(
            itemCount: state.events.length,
            itemBuilder: (context, index) => ListTile(
              leading: Image.memory(base64Decode(state.events[index].foto)),
              title: Text(state.events[index].nome),
            ),
          );

          return Scaffold(
            appBar: AppBar(
              title: Text('Eventos'),
            ),
            body: _child,
          );
        },
      ),
    );
  }

}