import 'package:equatable/equatable.dart';

abstract class PropertyEvent extends Equatable {}

class Fetch extends PropertyEvent {
  @override
  String toString() => 'Fetch';
}