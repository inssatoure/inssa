import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:quick_resume_creator/core/colors/app_colors.dart';
import 'package:quick_resume_creator/core/constants/dimens.dart';
import 'package:quick_resume_creator/core/key_holder/key_holder.dart';
import 'package:quick_resume_creator/layout/portal_master_layout/portal_master_layout.dart';
import 'package:quick_resume_creator/screens/home_screen/user_bloc/user_bloc.dart';
import 'package:quick_resume_creator/screens/home_screen/user_bloc/user_event.dart';
import 'package:quick_resume_creator/widgets/custom_app_text/app_text.dart';
import 'package:quick_resume_creator/widgets/textfield_input_decoration/textfield_input_decoration.dart';

import 'package:flutter_gemini/flutter_gemini.dart' as ai;

class CoverLetterGeneratorPage extends StatefulWidget {
  const CoverLetterGeneratorPage({super.key});

  @override
  State<CoverLetterGeneratorPage> createState() =>
      _CoverLetterGeneratorPageState();
}

class _CoverLetterGeneratorPageState extends State<CoverLetterGeneratorPage> {
  final _formKey = GlobalKey<FormState>();
  final _jobTitleController = TextEditingController();
  final _subjectController = TextEditingController();
  final _contentController = TextEditingController();
  final _contentPoints = <String>[];
  bool _loading = false;
  bool _isDisable = false;
  bool get loading => _loading;
  set loading(bool set) => setState(() => _loading = set);
  String? _finishReason;
  String? get finishReason => _finishReason;

  set finishReason(String? set) {
    if (set != _finishReason) {
      _finishReason = set;
    }
  }

  final ScrollController scrollController = ScrollController();

  String _generatedEmailPrompt = "";
  String _selectedTone = 'Select Tone';
  String _lengthType = 'Select Length';
  List<String> outputs = [];
  final gemini = ai.Gemini.instance;
  final List<Content> chats = [];
  final List<String> _tones = [
    'Select Tone',
    'Formal',
    'Professional',
    'Informal',
    'Optimistic',
    'Pessimistic',
    'Serious',
    'Humorous',
    'Sarcastic',
    'Nostalgic',
    'Joyful',
    'Angry',
    'Sad',
    'Ironic',
    'Sympathetic',
    'Objective',
    'Subjective',
    'Romantic',
    'Critical',
    'Reflective',
    'Indifferent',
    'Commanding',
    'Cautious',
    'Encouraging',
    'Respectful',
    'Disrespectful',
    'Tense',
    'Relaxed',
    'Confident',
    'Inquisitive',
    'Hopeful',
    'Defeated'
  ];

  final List<String> _lengthTypes = [
    'Select Length',
    'Short',
    'Medium',
    'Long'
  ];

  @override
  void initState() {
    super.initState();

    BlocProvider.of<UserBloc>(context).add(UserCheckRequested());
  }

  @override
  Widget build(BuildContext context) {
    return PortalMasterLayout(
      scrollController: scrollController,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
              key: KeyHolder.resumeKey,
              color: AppColors.dividercolor,
              height: 1),
          buildSizedBoxH(kDefaultPadding + kTextPadding),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: kDefaultPadding * 1.8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: "Generate Cover Letter",
                  fontsize: MediaQuery.of(context).size.width <= kScreenWidthMd
                      ? MediaQuery.of(context).size.width / 16
                      : 48,
                  fontWeight: FontWeight.w700,
                ),
                buildSizedBoxH(
                    MediaQuery.of(context).size.width <= kScreenWidthMd
                        ? MediaQuery.of(context).size.width / 12
                        : kDefaultPadding * 4),
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 900) {
                      return _buildVerticalLayout();
                    } else {
                      return _buildHorizontalLayout();
                    }
                  },
                ),
                buildSizedBoxH(kDefaultPadding),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalLayout() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildForm(),
          buildSizedBoxH(20),
          _buildGeneratedEmail(),
        ],
      ),
    );
  }

  Widget _buildHorizontalLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: _buildForm(),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: _buildGeneratedEmail(),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          CustomAppTextField(
            controller: _jobTitleController,
            labelText: 'Job Title',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a job title';
              }
              return null;
            },
          ),
          buildSizedBoxH(20.0),
          CustomAppTextField(
            controller: _subjectController,
            labelText: 'Subject',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a subject';
              }
              return null;
            },
          ),
          buildSizedBoxH(20.0),
          CustomAppTextField(
            controller: _contentController,
            labelText: 'Content Points',
          ),
          _contentPoints.isEmpty
              ? const SizedBox.shrink()
              : buildSizedBoxH(20.0),
          Row(
            children: [
              Wrap(
                spacing: 8.0,
                children: _contentPoints.map((String point) {
                  return Chip(
                    label: AppText(text: point),
                    deleteIconColor: AppColors.primaryColor,
                    clipBehavior: Clip.antiAlias,
                    onDeleted: () {
                      setState(() {
                        _contentPoints.remove(point);
                      });
                    },
                  );
                }).toList(),
              ),
            ],
          ),
          buildSizedBoxH(20.0),
          Theme(
            data: ThemeData(
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
            child: DropdownButtonFormField<String>(
              value: _selectedTone,
              decoration: buildInputDecoration(labelText: 'Select Tone'),
              dropdownColor: Theme.of(context).cardColor,
              items: _tones.map((String tone) {
                return DropdownMenuItem<String>(
                  value: tone,
                  child: AppText(text: tone),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedTone = newValue!;
                });
              },
              validator: (value) {
                if (value == null || value == 'Select Tone') {
                  return 'Please enter Tone';
                }
                return null;
              },
            ),
          ),
          buildSizedBoxH(20.0),
          Theme(
            data: ThemeData(
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
            child: DropdownButtonFormField<String>(
              dropdownColor: Theme.of(context).cardColor,
              value: _lengthType,
              decoration: buildInputDecoration(labelText: "Select Length"),
              items: _lengthTypes.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: AppText(text: type),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _lengthType = newValue!;
                });
              },
              validator: (value) {
                if (value == null || value == 'Select Length') {
                  return 'Please enter email length';
                }
                return null;
              },
            ),
          ),
          buildSizedBoxH(16.0),
          GestureDetector(
              onTap: _isDisable
                  ? null
                  : () {
                      if (_formKey.currentState!.validate()) {
                        _generatedEmailPrompt =
                            "Job Title: [${_jobTitleController.text}], Subject: [${_subjectController.text}], Content Points: [$_contentPoints], Tone: [$_selectedTone], Length: [$_lengthType] Based on these details, give me a cover letter.";
                        log(_generatedEmailPrompt);
                        chats.add(Content(
                            role: 'user',
                            parts: [Parts(text: _generatedEmailPrompt)]));
                        loading = true;
                        _isDisable = true;
                        gemini.streamChat(chats).listen((value) {
                          loading = false;
                          outputs.add(value.output.toString());
                          log(value.output.toString());
                          finishReason = value.output;
                        }, onDone: () {
                          _jobTitleController.clear();
                          _subjectController.clear();
                          _contentPoints.clear();
                          _contentController.clear();
                          _selectedTone = 'Select Tone';
                          _lengthType = 'Select Length';
                          log("All outputs: ${outputs.join(', ')}");
                          _isDisable = false;
                        });
                      }
                    },
              child: Padding(
                  padding: const EdgeInsets.only(bottom: kDefaultPadding),
                  child: Container(
                      height: 45.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: _isDisable
                              ? AppColors.primaryColor.withOpacity(0.2)
                              : AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(
                              kTextPadding + kTextPadding)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.generating_tokens,
                            color: AppColors.white_color,
                          ),
                          buildSizedBoxW(8),
                          Text(
                            'Generate Cover Letter',
                            style: TextStyle(
                                color: AppColors.white_color,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )))),
        ],
      ),
    );
  }

  Widget _buildGeneratedEmail() {
    return Align(
      child: Container(
        decoration: BoxDecoration(
            color: loading || finishReason == null
                ? Colors.transparent
                : AppColors.primaryColor.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(16.0))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (loading) const CircularProgressIndicator(),
              loading || finishReason == null
                  ? const SizedBox.shrink()
                  : Column(
                      children: [
                        AppText(text: outputs.join(', ')),
                        buildSizedBoxH(18),
                        GestureDetector(
                            onTap: _copyToClipboard,
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: kDefaultPadding),
                                child: Container(
                                    height: 45.0,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius: BorderRadius.circular(
                                            kTextPadding + kTextPadding)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.copy_outlined,
                                          color: AppColors.white_color,
                                        ),
                                        buildSizedBoxW(8),
                                        Text(
                                          'copy',
                                          style: TextStyle(
                                              color: AppColors.white_color,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )))),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: outputs.join(', ')));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard')),
    );
  }
}
