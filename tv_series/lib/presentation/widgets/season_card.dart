import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/appcolor.dart' show AppColors;
import 'package:flutter/material.dart';

import '../../domain/entities/season.dart';

class SeasonCard extends StatelessWidget {
  final Season season;

  const SeasonCard(this.season, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          side: BorderSide()),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          season.posterPath != null
              ? CachedNetworkImage(
                  imageUrl:
                      'https://image.tmdb.org/t/p/w500${season.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              : const SizedBox(
                  width: 120,
                  height: 200,
                  child: Center(child: Text('No image')),
                ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              color: AppColors.kGrey70,
              padding: const EdgeInsets.all(8.0),
              child: Builder(builder: (context) {
                String repr;
                if ('${season.seasonNumber}'.length == 1) {
                  repr = '0${season.seasonNumber}';
                } else {
                  repr = '${season.seasonNumber}';
                }
                return Text(
                  repr,
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.headline6,
                );
              }),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
                color: AppColors.kGrey30,
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  season.name,
                  overflow: TextOverflow.ellipsis,
                )),
          )
        ],
      ),
    );
  }
}
