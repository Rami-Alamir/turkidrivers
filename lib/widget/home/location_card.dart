import 'package:almaraa_drivers/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:almaraa_drivers/utilities/app_localizations.dart';
import 'package:almaraa_drivers/widget/shared/main_container.dart';

class LocationCard extends StatelessWidget {
  final String location;

  const LocationCard({
    required this.location,
  });
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: location.isNotEmpty,
      child: MainContainer(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.tr('current_location'),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(fontSize: 14),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      width: SizeConfig.screenWidth! - 120,
                      child: Text(
                        location,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: 14,
                            height: 1.4,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    'assets/images/map.png',
                    width: 40,
                    height: 40,
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
