import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/const/icon_const.dart';
import 'package:pengo/helpers/geo/geo_helper.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/models/user_model.dart';
import 'package:provider/src/provider.dart';

class UsersOwnLocationList extends StatelessWidget {
  const UsersOwnLocationList({
    Key? key,
    required this.showSaveModal,
    required this.locations,
  }) : super(key: key);

  final void Function(double lat, double lng, String name) showSaveModal;
  final List<UserLocation> locations;

  @override
  Widget build(BuildContext context) {
    // List<UserLocation>? _userLocations =
    //     context.select<AuthModel, List<UserLocation>?>(
    //   (value) => value.user?.user.locations,
    // );

    // debugPrint(_userLocations.toString());
    return Visibility(
      visible: locations.isNotEmpty == true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "My location",
            style: PengoStyle.title2(context).copyWith(
              color: secondaryTextColor,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: locations.length,
            itemBuilder: (BuildContext context, int index) {
              final UserLocation ul = locations[index];

              return ListTile(
                onTap: () => showSaveModal(
                  ul.geolocation!.latitude,
                  ul.geolocation!.longitude,
                  ul.name,
                ),
                contentPadding: EdgeInsets.zero,
                minLeadingWidth: 22,
                leading: SvgPicture.asset(
                  LOCATION_ICON_PATH,
                  color: secondaryTextColor,
                  width: 22,
                ),
                title: Text(
                  ul.name,
                  style: PengoStyle.title2(context).copyWith(
                    height: 1.6,
                  ),
                ),
                subtitle: Column(
                  children: <Widget>[
                    Text(
                      ul.street!,
                      style: PengoStyle.smallerText(context).copyWith(
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
                trailing: Visibility(
                  visible: context.watch<GeoHelper>().isUsingDevice == false,
                  child: ul.isFav == true
                      ? Icon(
                          Icons.check,
                          color: primaryColor,
                        )
                      : CupertinoButton(
                          child: const Text("Save"),
                          onPressed: () => showSaveModal(
                            ul.geolocation!.latitude,
                            ul.geolocation!.longitude,
                            ul.name,
                          ),
                        ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
