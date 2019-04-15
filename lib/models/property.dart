import 'package:equatable/equatable.dart';
class Property extends Equatable {
  final int id;
  final String propertyID;
  final String propertyName;
  final String propertyDescription;
  final String propertyLatestPhoto;
  final String propertyPlace;
  final double propertyLat;
  final double propertyLon;
  final double propertyAltitude;
  final lastUpdate;

  Property({this.id, this.propertyID, this.propertyName, this.propertyDescription, this.propertyLatestPhoto, this.propertyPlace, this.propertyLat, this.propertyLon, this.propertyAltitude, this.lastUpdate})
  : super([id, propertyID, propertyName, propertyDescription, propertyLatestPhoto, propertyPlace, propertyLat, propertyLon, propertyAltitude, lastUpdate]);

  @override
  String toString() => 'Property { id: $id }';
}