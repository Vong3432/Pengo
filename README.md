# Pengo

<p align="center" width="100%">
  <img src="https://res.cloudinary.com/dpjso4bmh/image/upload/v1628016130/pengo/First_s96c7t.png">
</p>
<p align="center" width="100%">
<small><i>The actual booking app.</i></small>
</p>

### Notes
This project is in Phaseout stage and no longer maintained.

### Features

- All in one multipurpose booking app.
- Easiest booking app for everyone.
- UX First Design
- GooCard Cloud Identification.
- Seamless delay device communication.
- Rewarding System that actually is about "win-win".

### Wishlist
 
- IOT GooCard Integration.
- Open-source API/SDK.

### Video demo
- https://youtu.be/EOd6GbxzcF8

### Commands

1. Generate JSON serializable files
   `flutter pub run build_runner build`

### Environment 
Flutter 3

### Getting started
1. Clone the repository
2. Clone the repository from [backend repository](https://github.com/Vong3432/Pengo-backend). Setup the backend repository. 
3. Configure environment variables in `.env` file. See `.env.example` for more details.
4. Setup Mapbox SDK ios (This is being done locally since they want to do verification).
5. Put GoogleService-Info.plist in "/ios" folder.
6. Start the backend server.
7. Start the flutter app with "flutter run".

### If previously installed this project with Flutter 2 and updated to version 3 
- Check this out: https://stackoverflow.com/a/72462085/10868150

### Setup installation problems
1.
```
Error: CocoaPods's specs repository is too out-of-date to satisfy dependencies.
To update the CocoaPods specs, run:
  pod repo update

  ...
```
- Refer: [Flutter: CocoaPods's specs repository is too out-of-date to satisfy dependencies](https://stackoverflow.com/a/71458394)

2. 
```
[!] Error installing Mapbox-iOS-SDK
```
- Refer: [Mapbox installation guide](https://docs.mapbox.com/ios/maps/guides/install/)
