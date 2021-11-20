import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pengo/bloc/records/booking_record_bloc.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/config/shadow.dart';
import 'package:pengo/const/icon_const.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/helpers/api/api_helper.dart';
import 'package:pengo/helpers/socket/socket_helper.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/models/booking_record_model.dart';
import 'package:pengo/providers/booking_pass_provider.dart';
import 'package:pengo/ui/goocard/widgets/goocard_request_modal.dart';
import 'package:pengo/ui/home/widgets/penger_item.dart';
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
  BookingRecord? _selectedRecord;

  final BookingRecordBloc _bloc = BookingRecordBloc();

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
    final String? pin = _recordListener.getPin();

    debugPrint("Record id: ${record?.id}");
    if (record == null) return;

    final Map<String, String> fd = {
      "record_id": record.id.toString(),
      "pin": pin.toString(),
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
      debugPrint("ShouldUpdateCredit: ${data['shouldUpdateCredit']}");
      if (data['shouldUpdateCredit'] as bool == true) {
        // TODO: Add credit poins
        _api.put('/pengoo/booking-records/${record.id}', data: fd);
        _api.post('/pengoo/credit-points', data: {
          "record_id": record.id,
        });
      }
      _showToast(successColor, (data["msg"] ?? "Verified").toString());

      Navigator.pop(context, "pop");
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
    _bloc.add(
      const FetchRecordsEvent(isUsed: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookingRecordBloc>(
      create: (BuildContext context) => _bloc,
      child: ChangeNotifierProvider(
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
        BlocConsumer(
          listener: (BuildContext context, BookingRecordState state) {
            if (state is BookingRecordsLoaded) {
              if (state.records.isNotEmpty) {
                setState(() {
                  _selectedRecord = state.records[0];
                });
              }
            }
          },
          builder: (BuildContext context, BookingRecordState state) {
            if (state is BookingRecordsLoading) {
              return const SkeletonText(height: 15);
            }
            if (state is BookingRecordsLoaded) {
              if (state.records.isEmpty) {
                return const Center(child: Text("No records found"));
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Draggable(
                    data: _selectedRecord,
                    feedback: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        boxShadow: normalShadow(Theme.of(context)),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: PengerItem(
                        name: _selectedRecord!.item!.title,
                        logo: _selectedRecord!.item!.poster,
                        location: _selectedRecord!.item!.location,
                      ),
                    ),
                    childWhenDragging: Container(
                      height: 200,
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: greyBgColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Pass(
                      onPassSelected: (BookingRecord record) {
                        debugPrint("pressed ${record.id}");
                        setState(() {
                          _selectedRecord = record;
                        });
                      },
                      recordList: state.records,
                      record: _selectedRecord,
                    ),
                  ),
                  const SizedBox(
                    height: SECTION_GAP_HEIGHT,
                  ),
                  DragTarget<BookingRecord>(
                    onAccept: (BookingRecord record) {
                      showCupertinoModalBottomSheet(
                        bounce: false,
                        context: context,
                        builder: (BuildContext context) {
                          return Material(
                            child: GoocardRequestModal(
                              onVerifySuccess: (String pin) {
                                _recordListener.pin = pin;
                                _recordListener.record = record;
                                Navigator.pop(context);
                              },
                              onVerifyFailed: () => debugPrint("Not booking"),
                            ),
                          );
                        },
                      );
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
    _socketHelper.getSocket.disconnect();

    super.dispose();
  }
}

class Pass extends StatelessWidget {
  const Pass({
    Key? key,
    this.record,
    required this.recordList,
    required this.onPassSelected,
  }) : super(key: key);

  final BookingRecord? record;
  final List<BookingRecord> recordList;
  final ValueSetter<BookingRecord> onPassSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: whiteColor,
        boxShadow: lightShadow(Theme.of(context)),
        borderRadius: BorderRadius.circular(18),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recordList.length,
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
              itemBuilder: (BuildContext context, int index) {
                final BookingRecord curr = recordList[index];
                final bool selected = record?.id == curr.id;

                final String formattedStartDate = curr.bookDate?.startDate !=
                        null
                    ? DateFormat('yyyy-MM-dd').format(curr.bookDate!.startDate!)
                    : "";
                final String formattedEndDate = curr.bookDate?.endDate != null
                    ? DateFormat('yyyy-MM-dd').format(curr.bookDate!.endDate!)
                    : "";
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PengerItem(
                        onTap: () {
                          onPassSelected(curr);
                        },
                        name: curr.item!.title,
                        logo: curr.item!.poster,
                        location: curr.item!.location,
                        trailing: selected
                            ? Icon(
                                Icons.check,
                                color: primaryColor,
                              )
                            : const SizedBox(),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.timelapse,
                            color: secondaryTextColor,
                            size: 21,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "$formattedStartDate to $formattedEndDate",
                            style: PengoStyle.captionNormal(context),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          SvgPicture.asset(
                            LOCATION_ICON_PATH,
                            color: secondaryTextColor,
                            width: 21,
                            height: 21,
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: mediaQuery(context).size.width * 0.6,
                            child: Text(
                              curr.item?.geolocation?.name ?? "",
                              style: PengoStyle.captionNormal(context),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
