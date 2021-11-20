import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pengo/bloc/feedbacks/feedback_repo.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/toast/toast_helper.dart';
import 'package:pengo/models/booking_record_model.dart';
import 'package:pengo/ui/widgets/button/custom_button.dart';
import 'package:pengo/ui/widgets/input/custom_textfield.dart';
import 'package:pengo/ui/widgets/layout/sliver_appbar.dart';
import 'package:pengo/ui/widgets/layout/sliver_body.dart';

class RecordReviewPage extends StatefulWidget {
  const RecordReviewPage({Key? key, required this.record}) : super(key: key);

  final BookingRecord record;

  @override
  Record_ReviewStatePage createState() => Record_ReviewStatePage();
}

class Record_ReviewStatePage extends State<RecordReviewPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  bool isPosting = false;

  final _titleValidator = MultiValidator([
    RequiredValidator(errorText: 'This field cannot be empty'),
    // MaxLengthValidator(10, errorText: 'Your phone is incorrect format')
  ]);

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _titleController = TextEditingController();
    _descriptionController = TextEditingController(
        text:
            "I am so pleased with this product. We can't understand how we've been living without booking.");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Form(
        key: _formKey,
        child: Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              CustomSliverAppBar(
                centerTitle: true,
                shadowColor: secondaryTextColor,
                floating: true,
                elavation: 4,
                title: Text(
                  "Review record",
                  style: PengoStyle.title2(context),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          style: PengoStyle.body(context),
                          children: <TextSpan>[
                            const TextSpan(
                              text:
                                  "Describe overall experience in this booking",
                            ),
                            TextSpan(
                              text: "*",
                              style: PengoStyle.body(context).copyWith(
                                color: dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomTextField(
                        controller: _titleController,
                        validator: _titleValidator,
                        hintText: 'eg: Good service',
                      ),
                      RichText(
                        text: TextSpan(
                          style: PengoStyle.body(context),
                          children: <TextSpan>[
                            const TextSpan(
                              text:
                                  "What do you think about this booking experience?",
                            ),
                            TextSpan(
                              text: "*",
                              style: PengoStyle.body(context).copyWith(
                                color: dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomTextField(
                        controller: _descriptionController,
                        inputType: TextInputType.multiline,
                        onChanged: (String? text) {
                          setState(() {});
                        },
                        maxLines: 5,
                        hintText: 'At least 50 words',
                        height: 120,
                        sideNote: Text(
                          " ${_descriptionController.text.length}/50 words",
                        ),
                      ),
                      const Spacer(),
                      CustomButton(
                        isLoading: isPosting,
                        onPressed: _submit,
                        text: const Text("Post review"),
                      ),
                      const SizedBox(
                        height: SECTION_GAP_HEIGHT * 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isPosting = true;
      });
      FeedbackRepo()
          .postReview(
        _titleController.text,
        "pass",
        _descriptionController.text,
        widget.record.id,
      )
          .then((_) {
        Navigator.pop(context);
        showToast(
          msg: "Post successfully",
          backgroundColor: successColor,
        );
      }).catchError((e) {
        showToast(msg: e.toString());
        setState(() {
          isPosting = false;
        });
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }
}
