import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:property_connect_customer/models/property.dart';

class PropertyWidget extends StatelessWidget {
  final Property property;

  const PropertyWidget({Key key, @required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Land at Kovur'),
            subtitle: Text('padugupadu - kovur'),
          ),
          CachedNetworkImage(
            imageUrl: 'http://homeq.in/uploads/gallery/IMG-20181019-WA0009.jpg',
            placeholder: (context, url) => new CircularProgressIndicator(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          ),
          Text('${property.id} - ${property.propertyDescription}')
        ],
      ),
    );
  }
}