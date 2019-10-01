import 'dart:convert';
import 'package:flutter/material.dart';
// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/blocs/event.dart';
// Utils
import 'package:pet_app/utils/style.dart';
// Model
import 'package:pet_app/models/event.dart';
// Foreign
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class EventsPage extends StatefulWidget{

  createState() => _EventsPageState();  
}

class _EventsPageState extends State<EventsPage>{
  // final _refreshController = RefreshController(initialRefresh: false);

  Future<void> _onRefresh(EventBloc _bloc) async{
    _bloc.dispatch(EventLoad());    
  }

  
  @override
  Widget build(BuildContext context) {
    final EventBloc _eventBloc = BlocProvider.of<EventBloc>(context);

    return BlocBuilder(
      bloc: _eventBloc,
      builder: (context, state){
        if (state is EventEmpty)
          _eventBloc.dispatch(EventLoad());

        final _events = state is EventLoading ? [] : state.events;
        
        return Scaffold(
          appBar: AppBar(
            title: Text('Eventos'),
          ),
          body: LiquidPullToRefresh(
            onRefresh: () => _onRefresh(_eventBloc),	
            showChildOpacityTransition: false,
            height: AppStyle.pullHeight,
            color: AppStyle.colorBritishRacingGreen,
            child: ListView.builder(
              itemCount: _events.length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  leading: Image.memory(base64Decode(_events[index].foto)),
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
    );
  }

}