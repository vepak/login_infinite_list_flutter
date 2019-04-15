import 'dart:async';
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:property_connect_customer/blocs/property/property.dart';
import 'package:property_connect_customer/models/property.dart';

class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  final http.Client httpClient;
  final int fetchLimit = 20;

  PropertyBloc({@required this.httpClient});

  @override
  Stream<PropertyEvent> transform(Stream<PropertyEvent> events) {
    return (events as Observable<PropertyEvent>)
        .debounce(Duration(milliseconds: 500));
  }

  @override
  get initialState => PropertyUninitialized();



  bool _hasReachedMax(PropertyState state) =>
      state is PropertyLoaded && state.hasReachedMax;

  Future<List<Property>> _fetchPosts(int startIndex, int limit) async {
    final response = await httpClient.get(
        'https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit');
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((rawPost) {
        return Property(
          id: rawPost['id'],
          propertyID: 'NA',
          propertyLat: 22.22,
          propertyLon: 33.33,
          propertyAltitude: 22.22,
          propertyLatestPhoto: 'no photo',
          propertyPlace: 'no place',
          lastUpdate: 'no update',
          propertyName: rawPost['title'],
          propertyDescription: rawPost['body'],
        );
      }).toList();
    } else {
      throw Exception('error fetching properties');
    }
  }


  @override
  Stream<PropertyState> mapEventToState(PropertyEvent event) async* {
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is PropertyUninitialized) {
          final properties = await _fetchPosts(0, fetchLimit);
          yield PropertyLoaded(properties: properties, hasReachedMax: false);
        }
        if (currentState is PropertyLoaded) {
          final properties =
          await _fetchPosts((currentState as PropertyLoaded).properties.length, fetchLimit);
          yield properties.isEmpty
              ? (currentState as PropertyLoaded).copyWith(hasReachedMax: true)
              : PropertyLoaded(
            properties: (currentState as PropertyLoaded).properties + properties,
            hasReachedMax: false,
          );
        }
      } catch (_) {
        yield PropertyError();
      }
    }
  }
}