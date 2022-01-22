import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:flutter/material.dart';

class SeasonCard extends StatelessWidget {
  final Season season;

  const SeasonCard(this.season);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        side: BorderSide()
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          season.posterPath != null ? CachedNetworkImage(
              imageUrl: '$BASE_IMAGE_URL${season.posterPath}',
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(),
              ),

              errorWidget: (context, url, error) => Icon(Icons.error),
          ) : Container(
              width: 120,
              height: 200,
              child: Center(child: Text('No image')),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              color: kGrey70,
              padding: EdgeInsets.all(8.0),
              child: Builder(
                builder: (context) {
                  String repr;
                  if ('${season.seasonNumber}'.length == 1) {
                    repr = '0${season.seasonNumber}';
                  } else {
                    repr = '${season.seasonNumber}';
                  }
                  return Text(
                    repr,
                    textAlign: TextAlign.end,
                    style: kHeading6,
                  );
                }
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              color: kGrey30,
              padding: EdgeInsets.all(8.0),
              child: Text(
                  season.name,
                  overflow: TextOverflow.ellipsis,
              )
            ),
          )
        ],
      ),
    );
  }
}