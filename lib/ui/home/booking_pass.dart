import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pengo/bloc/records/booking_record_bloc.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/const/icon_const.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/helpers/api/api_helper.dart';
import 'package:pengo/helpers/socket/socket_helper.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/models/booking_record_model.dart';
import 'package:pengo/providers/booking_pass_provider.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import 'package:socket_io_client/src/socket.dart';

class BookingPassView extends StatefulWidget {
  const BookingPassView({Key? key}) : super(key: key);

  @override
  _BookingPassViewState createState() => _BookingPassViewState();
}

class _BookingPassViewState extends State<BookingPassView> {
  final SocketHelper _socketHelper = SocketHelper();
  final ApiHelper _api = ApiHelper();

  final BookingPassModel _recordListener = BookingPassModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _recordListener.addListener(_recordChangeListener);
    _loadRecords();
  }

  void _recordChangeListener() {
    final BookingRecord? record = _recordListener.getRecord();
    if (record == null) return;
    _socketHelper.init();
    _listen();
  }

  void _listen() async {
    final BookingRecord? record = _recordListener.getRecord();

    debugPrint("Record id: ${record?.id}");
    if (record == null) return;

    final Map<String, String> fd = {
      "record_id": record.id.toString(),
      "pin": '343234',
    };

    await _api.post('verify-pass',
        data: fd, options: Options(contentType: 'multipart/form-data'));

    final Socket instance = _socketHelper.getSocket;
    instance.on("rest-join", (data) {
      instance.emit("join-pass", data);
    });

    instance.on("joined room", (data) {
      debugPrint('joined');
    });

    instance.on("verifying", (data) {
      debugPrint('verifying');
    });

    instance.on("verified success", (data) {
      if (data['shouldUpdateCredit'] as bool == true) {
        // TODO: Add credit poins
        _api.put('/pengoo/booking-records/${record.id}', data: fd);
        _api.post('/pengoo/credit-points', data: {
          "record_id": record.id,
        });
      }
      _showToast(successColor, (data["msg"] ?? "Verified").toString());
    });

    instance.on("verified failed", (data) {
      debugPrint('failed');
      _showToast(successColor, (data["msg"] ?? "Verified failed").toString());
    });

    instance.on("unauthorized", (data) {
      debugPrint('unauthorized');
      _showToast(successColor, "unauthorized");
    });
  }

  void _showToast(Color color, String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _loadRecords() {
    BlocProvider.of<BookingRecordBloc>(context).add(FetchRecordsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SocketHelper(),
      child: Material(
        child: Container(
          padding: const EdgeInsets.all(18),
          height: mediaQuery(context).size.height * 0.7,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                AnimatedBuilder(
                    animation: _recordListener,
                    builder: (context, child) {
                      return _recordListener.getRecord() == null
                          ? _buildSelectPassView(context)
                          : _buildGetScanView(context);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGetScanView(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                _recordListener.clearRecord();
                // _socketHelper.dispose();
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            Text(
              "Get Scan",
              style: PengoStyle.title(context),
            ),
            const Spacer(),
          ],
        ),
        if (context.watch<SocketHelper>().getSocket.id == null)
          Container()
        else
          QrImage(
            data: jsonEncode({
              "record": _recordListener.getRecord()!.toJson(),
              "to": _socketHelper.socket.id
            }),
            size: 200.0,
          ),
        Text(context.watch<SocketHelper>().getSocket.id ?? 'null'),
      ],
    );
  }

  Column _buildSelectPassView(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            Text(
              "Booking pass",
              style: PengoStyle.title(context),
            ),
            const Spacer(),
          ],
        ),
        BlocBuilder(
          builder: (BuildContext context, BookingRecordState state) {
            if (state is BookingRecordsLoading) {
              return const SkeletonText(height: 15);
            }
            if (state is BookingRecordsLoaded) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Draggable(
                    data: state.records[0],
                    feedback: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.lock_open_outlined)),
                    childWhenDragging: Container(
                      height: 200,
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: greyBgColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: greyBgColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text("${state.records[0].bookDate?.startDate}"),
                    ),
                  ),
                  const SizedBox(
                    height: SECTION_GAP_HEIGHT,
                  ),
                  DragTarget<BookingRecord>(
                    onAccept: (BookingRecord record) {
                      _recordListener.record = record;
                    },
                    builder: (
                      BuildContext context,
                      List<dynamic> accepted,
                      List<dynamic> rejected,
                    ) {
                      return Container(
                        width: double.infinity,
                        height: 190,
                        decoration: BoxDecoration(
                          color: primaryLightColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _recordListener.getRecord() == null
                            ? SvgPicture.asset(
                                HOLDING_PATH,
                                width: 100,
                                fit: BoxFit.scaleDown,
                              )
                            : Text(
                                _recordListener
                                    .getRecord()!
                                    .bookDate
                                    .toString(),
                              ),
                      );
                    },
                  ),
                  Text(
                    "Drag here to use",
                    style: PengoStyle.text(context),
                  ),
                ],
              );
            }
            if (state is BookingRecordsNotLoaded) return const Text("err");
            return Container();
          },
          bloc: BlocProvider.of<BookingRecordBloc>(context),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose

    //double confirm to dispose
    // _socketHelper.dispose();

    super.dispose();
  }
}
