import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/models/auth_model.dart';

class VideoMeetPage extends StatefulWidget {
  const VideoMeetPage({
    Key? key,
    required this.roomName,
    required this.subject,
    required this.user,
  }) : super(key: key);

  final String roomName;
  final String subject;
  final Auth user;

  @override
  State<VideoMeetPage> createState() => _VideoMeetPageState();
}

class _VideoMeetPageState extends State<VideoMeetPage> {
  bool? isAudioOnly = true;
  bool? isAudioMuted = true;
  bool? isVideoMuted = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    JitsiMeet.addListener(
      JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError,
      ),
    );
    _joinMeeting();
  }

  _joinMeeting() async {
    try {
      final Map<FeatureFlagEnum, bool> featureFlag = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
      }; // Limit video resolution to 360p

      if (!kIsWeb) {
        // Here is an example, disabling features for each platform
        if (Platform.isAndroid) {
          // Disable ConnectionService usage on Android to avoid issues (see README)
          featureFlag[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
        } else if (Platform.isIOS) {
          // Disable PIP on iOS as it looks weird
          featureFlag[FeatureFlagEnum.PIP_ENABLED] = false;
        }
      }

      final JitsiMeetingOptions options = JitsiMeetingOptions(
        room:
            "${widget.roomName.split(" ").join("-")}-${widget.subject.split(" ").join("_")}"
                .split(":")
                .join("_"),
      )
        ..subject = "${widget.roomName}-${widget.subject}"
        ..userDisplayName = widget.user.username
        ..userEmail = widget.user.email
        ..userAvatarURL = widget.user.avatar
        ..audioOnly = isAudioOnly
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted;

      options.featureFlags = featureFlag;

      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      debugPrint("error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: mediaQuery(context).size.width * 0.60,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Colors.white54,
            child: SizedBox(
              width: mediaQuery(context).size.width * 0.60 * 0.70,
              height: mediaQuery(context).size.width * 0.60 * 0.70,
              child: JitsiMeetConferencing(
                extraJS: [
                  // extraJs setup example
                  '<script>function echo(){console.log("echo!!!")};</script>',
                  '<script src="https://code.jquery.com/jquery-3.5.1.slim.js" integrity="sha256-DrT5NfxfbHvMHux31Lkhxg42LY6of8TaYyK50jnxRnM=" crossorigin="anonymous"></script>'
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _onAudioOnlyChanged(bool? value) {
    setState(() {
      isAudioOnly = value;
    });
  }

  _onAudioMutedChanged(bool? value) {
    setState(() {
      isAudioMuted = value;
    });
  }

  _onVideoMutedChanged(bool? value) {
    setState(() {
      isVideoMuted = value;
    });
  }

  void _onConferenceWillJoin(message) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined(message) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated(message) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
    Navigator.of(context).pop();
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    JitsiMeet.removeAllListeners();
  }
}
