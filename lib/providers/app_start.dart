import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:property_connect_customer/utils/user_repository.dart';

import 'package:property_connect_customer/blocs/authentication/authentication.dart';

import 'package:property_connect_customer/components/common/bottom_loader.dart';
import 'package:property_connect_customer/components/properties_page.dart';
import 'package:property_connect_customer/components/splash_page.dart';
import 'package:property_connect_customer/blocs/login/login.dart';

class AppStart extends StatefulWidget {
  final UserRepository userRepository;

  AppStart({Key key, @required this.userRepository}) : super(key: key);

  @override
  State<AppStart> createState() => _AppStartState();
}

class _AppStartState extends State<AppStart> {
  AuthenticationBloc _authenticationBloc;
  UserRepository get _userRepository => widget.userRepository;

  @override
  void initState() {
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
    _authenticationBloc.dispatch(AppStarted());
    super.initState();
  }

  @override
  void dispose() {
    _authenticationBloc.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
        bloc: _authenticationBloc,
        child: MaterialApp(
        home:BlocListener(
        bloc: _authenticationBloc,
        listener: (BuildContext context, AuthenticationState state) {
          if (state is AuthenticationLogin) {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                LoginPage(userRepository: _userRepository)));
          }
        },
        child:BlocBuilder<AuthenticationEvent, AuthenticationState>(
            bloc: _authenticationBloc,
            builder: (BuildContext context, AuthenticationState state) {
              if (state is AuthenticationUninitialized) {
                return SplashPage();
              }
              if (state is AuthenticationAuthenticated) {
                return PropertiesPage();
              }
              if (state is AuthenticationUnauthenticated) {
                return AuthenticationLandingPage();
              }
              if (state is AuthenticationLoading) {
                return BottomLoader();
              }
              if (state is AuthenticationSignup) {
                return AuthenticationLandingPage();
              }
              if (state is AuthenticationDemo) {
                return PropertiesPage();
              }
            }
        ))
    ));
  }
}
