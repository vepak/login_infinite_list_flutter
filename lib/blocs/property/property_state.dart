import 'package:equatable/equatable.dart';

import 'package:property_connect_customer/models/property.dart';

abstract class PropertyState extends Equatable {
  PropertyState([List props = const []]) : super(props);
}

class PropertyUninitialized extends PropertyState {
  @override
  String toString() => 'PropertyUninitialized';
}

class PropertyError extends PropertyState {
  @override
  String toString() => 'PropertyError';
}

class PropertyLoaded extends PropertyState {
  final List<Property> properties;
  final bool hasReachedMax;

  PropertyLoaded({
    this.properties,
    this.hasReachedMax,
  }) : super([properties, hasReachedMax]);

  PropertyLoaded copyWith({
    List<Property> properties,
    bool hasReachedMax,
  }) {
    return PropertyLoaded(
      properties: properties ?? this.properties,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() =>
      'PropertyLoaded { properties: ${properties.length}, hasReachedMax: $hasReachedMax }';
}