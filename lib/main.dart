import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:property_connect_customer/blocs/simple_bloc_delegate.dart';
import 'package:property_connect_customer/providers/app_start.dart';
import 'package:property_connect_customer/utils/user_repository.dart';

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(AppStart(userRepository: UserRepository()));
}