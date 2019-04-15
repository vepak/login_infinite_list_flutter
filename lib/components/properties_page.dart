import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:property_connect_customer/blocs/property/property.dart';
import 'package:property_connect_customer/components/common/bottom_loader.dart';
import 'package:property_connect_customer/blocs/authentication/authentication.dart';
import 'property_widget.dart';

class PropertiesPage extends StatefulWidget {
  @override
  _PropertiesPageState createState() => _PropertiesPageState();
}

class _PropertiesPageState extends State<PropertiesPage> {
  final _scrollController = ScrollController();
  final PropertyBloc _propertyBloc = PropertyBloc(httpClient: http.Client());
  final _scrollThreshold = 200.0;


  _PropertiesPageState() {
    _scrollController.addListener(_onScroll);
    _propertyBloc.dispatch(Fetch());
  }

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
    BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              AppBar(
                automaticallyImplyLeading: false,
                title: Text('Choose'),
              ),
              ListTile(
                title: Text('Logout'),
                onTap: (){
                  Navigator.of(context).pop();
                  authenticationBloc.dispatch(LoggedOut());
                },
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Property Connect'),
        ),
        body:BlocBuilder(
          bloc: _propertyBloc,
          builder: (BuildContext context, PropertyState state) {
            if (state is PropertyUninitialized) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is PropertyError) {
              return Center(
                child: Text('failed to fetch properties'),
              );
            }
            if (state is PropertyLoaded) {
              if (state.properties.isEmpty) {
                return Center(
                  child: Text('no properties'),
                );
              }
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return index >= state.properties.length
                      ? BottomLoader()
                      : PropertyWidget(property: state.properties[index]);
                  },
                itemCount: state.hasReachedMax
                    ? state.properties.length
                    : state.properties.length + 1,
                controller: _scrollController,
              );
            }
            },
        )
    );
  }

  @override
  void dispose() {
    _propertyBloc.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _propertyBloc.dispatch(Fetch());
    }
  }
}