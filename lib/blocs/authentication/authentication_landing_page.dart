import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:property_connect_customer/blocs/authentication/authentication.dart';


class AuthenticationLandingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Property Connect'),
      ),
      body: Container(
        child: Center(
            child: Column(
              children: <Widget>[
                RaisedButton(
                  child: Text('Sign In'),
                  onPressed: () {
                    _authenticationBloc.dispatch(LoginRequested());
                  },
                ),
                RaisedButton(
                  child: Text('Sign Up'),
                  onPressed: () {
                    _authenticationBloc.dispatch(SignUpRequested());
                  },
                ),
                RaisedButton(
                  child: Text('Experience App'),
                  onPressed: () {
                    _authenticationBloc.dispatch(DemoRequested());
                  },
                ),
              ],
            )
        ),
      ),
    );
  }
}