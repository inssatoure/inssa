// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_month_picker/flutter_custom_month_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart' show DateFormat, NumberFormat;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quick_resume_creator/core/colors/app_colors.dart';
import 'package:quick_resume_creator/core/constants/dimens.dart';
import 'package:quick_resume_creator/core/image/app_image.dart';
import 'package:quick_resume_creator/models/education.dart';
import 'package:quick_resume_creator/models/employment.dart';
import 'package:quick_resume_creator/models/personal_skill.dart';
import 'package:quick_resume_creator/models/professional_skill.dart';
import 'package:quick_resume_creator/models/skill.dart';
import 'package:quick_resume_creator/repository/quick_resume_creator_repository.dart';
import 'package:quick_resume_creator/routes/app_route.dart';
import 'package:quick_resume_creator/screens/edit_resume/edit_resume_bloc/edit_resume_bloc.dart';
import 'package:quick_resume_creator/screens/edit_resume/edit_resume_bloc/edit_resume_event.dart';
import 'package:quick_resume_creator/screens/edit_resume/edit_resume_bloc/edit_resume_state.dart';
import 'package:quick_resume_creator/screens/resume_template/resume_template1.dart';
import 'package:quick_resume_creator/screens/resume_template/resume_template10.dart';
import 'package:quick_resume_creator/screens/resume_template/resume_template2.dart';
import 'package:quick_resume_creator/screens/resume_template/resume_template3.dart';
import 'package:quick_resume_creator/screens/resume_template/resume_template4.dart';
import 'package:quick_resume_creator/screens/resume_template/resume_template5.dart';
import 'package:quick_resume_creator/screens/resume_template/resume_template6.dart';
import 'package:quick_resume_creator/screens/resume_template/resume_template7.dart';
import 'package:quick_resume_creator/screens/resume_template/resume_template8.dart';
import 'package:quick_resume_creator/screens/resume_template/resume_template9.dart';
import 'package:quick_resume_creator/widgets/custom_app_text/app_text.dart';
import 'package:quick_resume_creator/widgets/custom_dailog_box/custom_dailo_box.dart';
import 'package:quick_resume_creator/widgets/textfield_input_decoration/textfield_input_decoration.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:toastification/toastification.dart';

class EditResumeScreen extends StatefulWidget {
  final dynamic extra;
  final bool isstart;
  const EditResumeScreen({super.key, this.extra, required this.isstart});

  static Widget builder(BuildContext context) {
    return BlocProvider<EditResumeBloc>(
      create: (context) => EditResumeBloc()..add(const LoadEditData()),
      child: const EditResumeScreen(isstart: true),
    );
  }

  @override
  State<EditResumeScreen> createState() => _EditResumeScreenState();
}

class _EditResumeScreenState extends State<EditResumeScreen> {
  final userUid = FirebaseAuth.instance.currentUser?.uid;

  bool showLoading = false;

  bool showpogressbar = true;
  dynamic buildAnimation;

  int lastYear = DateTime.now().add(const Duration(days: 365 * 100)).year;

  final _personalFormKey = GlobalKey<FormBuilderState>();
  final _educationFormKey = GlobalKey<FormBuilderState>();
  final _employmentFormKey = GlobalKey<FormBuilderState>();
  final _professionalAndPersonalSkillFormKey = GlobalKey<FormBuilderState>();
  final _skillAndLevelFormKey = GlobalKey<FormBuilderState>();

  List<Education> customerEducationList = [];
  List<Employment> customerEmploymentList = [];
  List<ProfessionalSkill> customerProfessionalSkillList = [];
  List<PersonalSkill> customerPersonalSkillList = [];
  List<Skill> customerSkillList = [];

  String id = '';
  String resumeId = '';
  Uint8List? customerProfileImage;
  String? customerProfileImageURL;
  String customerFirstNametext = '';
  String customerLastNametext = '';
  String customerProfessiontext = '';
  String customerLocationtext = '';
  String customerWebsitetext = '';
  String customerPhoneNotext = '';
  String customerEmailIDtext = '';
  String customerProfessionalSummarytext = '';
  String customerUniversitytext = '';
  String customerDegreetext = '';
  String customerStartDatetext = '';
  String customerEndDatetext = '';
  String customerJobTitletext = '';
  String customerCompanyNametext = '';
  String customerEmploymentStartDatetext = '';
  String customerEmploymentEndDatetext = '';
  String customerEmploymentAddresstext = '';
  String customerSkilltext = '';
  String customerProfessionalSkilltext = '';
  String customerPersonalSkilltext = '';
  double customerSkillLevel = 0;
  String createdAt = '';
  String updatedAt = '';

  bool _isDisposed = false;

  bool _isDataLoaded = false;

  bool _isFirstLoad = true;

  bool isUpdateButtonHovered = false;

  void _mouseEnterUpdateButton(bool hover) {
    setState(() {
      isUpdateButtonHovered = hover;
    });
  }

  late var professionalSummaryLength = 250;
  late var contectsLength = 50;
  late var educationLength = 3;
  late var educationDegreeLength = 60;
  late var employmentLength = 5;
  late var employmentAddressLength = 50;
  late var professionalSkillLength = 5;
  late var personalSkillLength = 5;
  late var skillLength = 5;
  late var skillTextLength = 25;

  @override
  void initState() {
    if (widget.isstart) {
      context.read<EditResumeBloc>().add(InitialEditResumeDataLoadEvent(
          extra: widget.extra, isStart: widget.isstart));

      context.read<EditResumeBloc>().add(const LoadEditData());
    }

    professionalSummaryLength = id == "2" || id == "6" || id == "9" ? 300 : 250;
    educationLength =
        id == "4" || id == "5" || id == "6" || id == "8" || id == "9" ? 2 : 3;
    employmentLength = id == "2" || id == "3" || id == "9"
        ? 4
        : id == "4" || id == "5"
            ? 2
            : id == "6" || id == "7" || id == "10"
                ? 3
                : 5;
    contectsLength = id == "3"
        ? 40
        : id == "5"
            ? 46
            : id == "10"
                ? 65
                : 50;
    skillLength = id == "3" || id == "4" || id == "5" || id == "6" ? 6 : 5;
    employmentAddressLength = id == "3" ? 53 : 50;
    educationDegreeLength = id == "5" ? 55 : 60;
    skillTextLength = id == "6" ? 23 : 25;

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isDataLoaded = true;
      });
    });

    super.initState();
  }

  final QuickResumeRepository quickResumeRepository = QuickResumeRepository();

  late final TextEditingController customerFirstNameController =
      TextEditingController(text: customerFirstNametext);
  late final TextEditingController customerLastNameController =
      TextEditingController(text: customerLastNametext);
  late final TextEditingController customerProfessionController =
      TextEditingController(text: customerProfessiontext);
  late final TextEditingController customerLocationController =
      TextEditingController(text: customerLocationtext);
  late final TextEditingController customerWebsiteController =
      TextEditingController(text: customerWebsitetext);
  late final TextEditingController customerPhoneNoController =
      TextEditingController(text: customerPhoneNotext);
  late final TextEditingController customerEmailIDController =
      TextEditingController(text: customerEmailIDtext);
  late final TextEditingController customerProfessionalSummaryController =
      TextEditingController(text: customerProfessionalSummarytext);
  final TextEditingController customerUniversityController =
      TextEditingController();
  final TextEditingController customerDegreeController =
      TextEditingController();
  final TextEditingController customerEducationStartDateController =
      TextEditingController();
  final TextEditingController customerEducationEndDateController =
      TextEditingController();
  final TextEditingController customerJobTitleController =
      TextEditingController();
  final TextEditingController customerCompanyNameController =
      TextEditingController();
  final TextEditingController customerEmploymentStartDateController =
      TextEditingController();
  final TextEditingController customerEmploymentEndDateController =
      TextEditingController();
  final TextEditingController customerEmploymentAddressController =
      TextEditingController();
  final TextEditingController customerSkillController = TextEditingController();
  final TextEditingController customerProfessionalSkillController =
      TextEditingController();
  final TextEditingController customerPersonalSkillController =
      TextEditingController();

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  /// Image Picker

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        if (!_isDisposed) {
          setState(() {
            customerProfileImage = bytes;
          });
        }
      }
    } catch (e) {
      log('Error picking image: $e');
    }
  }

  ///

  /// Education

  int? editingIndex;

  bool? isEducationEdit;

  void addOrUpdateEducation() {
    if (_educationFormKey.currentState!.validate()) {
      setState(() {
        if (editingIndex == null) {
          // Adding a new education item
          if (customerEducationList.length < educationLength) {
            customerEducationList.add(Education(
              university: customerUniversityController.text.isEmpty
                  ? 'Los Angeles University'
                  : customerUniversityController.text,
              degree: customerDegreeController.text.isEmpty
                  ? 'Bachelor of Fine Arts in Graphic Design, GPA: 3.4/4.0'
                  : customerDegreeController.text,
              startDate: customerEducationStartDateController.text.isEmpty
                  ? '2005'
                  : customerEducationStartDateController.text,
              endDate: customerEducationEndDateController.text.isEmpty
                  ? '2010'
                  : customerEducationEndDateController.text,
            ));
          } else {
            toastification.show(
              type: ToastificationType.error,
              showProgressBar: showpogressbar,
              context: context,
              autoCloseDuration: const Duration(seconds: 5),
              animationBuilder: buildAnimation,
              animationDuration: const Duration(milliseconds: 300),
              title: Text(
                  'You can only add up to $educationLength education entries.'),
            );
            return;
          }
        } else {
          // Updating an existing education item
          customerEducationList[editingIndex!] = Education(
            university: customerUniversityController.text.isEmpty
                ? 'Los Angeles University'
                : customerUniversityController.text,
            degree: customerDegreeController.text.isEmpty
                ? 'Bachelor of Fine Arts in Graphic Design, GPA: 3.4/4.0'
                : customerDegreeController.text,
            startDate: customerEducationStartDateController.text.isEmpty
                ? '2005'
                : customerEducationStartDateController.text,
            endDate: customerEducationEndDateController.text.isEmpty
                ? '2010'
                : customerEducationEndDateController.text,
          );
          editingIndex = null;
          isEducationEdit = false;
        }
      });
      // Clear the text fields
      customerUniversityController.clear();
      customerDegreeController.clear();
      customerEducationStartDateController.clear();
      customerEducationEndDateController.clear();
    }
  }

  void editEducation(int index) {
    setState(() {
      customerUniversityController.text =
          customerEducationList[index].university;
      customerDegreeController.text = customerEducationList[index].degree;
      customerEducationStartDateController.text =
          customerEducationList[index].startDate;
      customerEducationEndDateController.text =
          customerEducationList[index].endDate;
      editingIndex = index;
    });
  }

  void deleteEducation(int index) {
    setState(() {
      customerEducationList.removeAt(index);
    });
  }

  DateTime? _educationStartDateSelected;

  Future<void> _educationStartDateCalendar() async {
    try {
      showMonthPicker(
        context,
        onSelected: (month, year) {
          DateTime selectedDate = DateTime(year, month);
          setState(() {
            _educationStartDateSelected = selectedDate;
            customerEducationStartDateController.text =
                DateFormat.yMMM().format(selectedDate);
          });
        },
        initialSelectedMonth: DateTime.now().month,
        initialSelectedYear: DateTime.now().year,
        firstYear: DateTime(1950).year,
        lastYear: lastYear,
        selectButtonText: 'OK',
        cancelButtonText: 'Cancel',
        highlightColor: AppColors.primaryColor,
        textColor: AppColors.text_color_black,
        contentBackgroundColor: AppColors.authBgcolor,
        dialogBackgroundColor: AppColors.lightorengecolor,
      );
    } catch (e) {
      log("Error: $e");
    }
  }

  Future<void> _educationEndDateCalendar() async {
    if (_educationStartDateSelected == null) {
      log("Error: Start date not selected");
      return;
    }

    try {
      showMonthPicker(
        context,
        onSelected: (month, year) {
          DateTime selectedDate = DateTime(year, month);
          setState(() {
            customerEducationEndDateController.text =
                DateFormat.yMMM().format(selectedDate);
          });
        },
        initialSelectedMonth: DateTime.now().month,
        initialSelectedYear: DateTime.now().year,
        firstEnabledMonth: _educationStartDateSelected!.month,
        firstYear: _educationStartDateSelected!.year,
        lastYear: lastYear,
        selectButtonText: 'OK',
        cancelButtonText: 'Cancel',
        highlightColor: AppColors.primaryColor,
        textColor: AppColors.text_color_black,
        contentBackgroundColor: AppColors.authBgcolor,
        dialogBackgroundColor: AppColors.lightorengecolor,
      );
    } catch (e) {
      log("Error: $e");
    }
  }

  ///

  /// Employment

  int? editingEmploymentIndex;

  bool? isEmploymentEdit;

  void addOrUpdateEmployment() {
    if (_employmentFormKey.currentState!.validate()) {
      setState(() {
        if (editingEmploymentIndex == null) {
          if (customerEmploymentList.length < employmentLength) {
            customerEmploymentList.add(Employment(
              jobTitle: customerJobTitleController.text.isEmpty
                  ? 'UI Designer'
                  : customerJobTitleController.text,
              companyName: customerCompanyNameController.text.isEmpty
                  ? "Market Studios"
                  : customerCompanyNameController.text,
              address: customerEmploymentAddressController.text.isEmpty
                  ? 'Successfully translated subject matter into concrete design for newsletters, promotional materials and sales collateral. Created design graphics for marketing and sales presentations, training videos and corporate websites.'
                  : customerEmploymentAddressController.text,
              startDate: customerEmploymentStartDateController.text.isEmpty
                  ? '2012'
                  : customerEmploymentStartDateController.text,
              endDate: customerEmploymentEndDateController.text.isEmpty
                  ? '2015'
                  : customerEmploymentEndDateController.text,
            ));
          } else {
            toastification.show(
              type: ToastificationType.error,
              showProgressBar: true,
              context: context,
              autoCloseDuration: const Duration(seconds: 5),
              animationDuration: const Duration(milliseconds: 300),
              title: AppText(
                text:
                    "You can only add up to $employmentLength employment entries.",
              ),
            );
          }
        } else {
          customerEmploymentList[editingEmploymentIndex!] = Employment(
            jobTitle: customerJobTitleController.text.isEmpty
                ? 'UI Designer'
                : customerJobTitleController.text,
            companyName: customerCompanyNameController.text.isEmpty
                ? "Market Studios"
                : customerCompanyNameController.text,
            address: customerEmploymentAddressController.text.isEmpty
                ? 'Successfully translated subject matter into concrete design for newsletters, promotional materials and sales collateral. Created design graphics for marketing and sales presentations, training videos and corporate websites.'
                : customerEmploymentAddressController.text,
            startDate: customerEmploymentStartDateController.text.isEmpty
                ? '2012'
                : customerEmploymentStartDateController.text,
            endDate: customerEmploymentEndDateController.text.isEmpty
                ? '2015'
                : customerEmploymentEndDateController.text,
          );
          editingEmploymentIndex = null;
          isEmploymentEdit = false;
        }
      });
      customerJobTitleController.clear();
      customerCompanyNameController.clear();
      customerEmploymentStartDateController.clear();
      customerEmploymentEndDateController.clear();
      customerEmploymentAddressController.clear();
    }
  }

  void editEmployment(int index) {
    setState(() {
      customerJobTitleController.text = customerEmploymentList[index].jobTitle;
      customerCompanyNameController.text =
          customerEmploymentList[index].companyName;
      customerEmploymentStartDateController.text =
          customerEmploymentList[index].startDate;
      customerEmploymentEndDateController.text =
          customerEmploymentList[index].endDate;
      customerEmploymentAddressController.text =
          customerEmploymentList[index].address;
      editingEmploymentIndex = index;
    });
  }

  void deleteEmployment(int index) {
    setState(() {
      customerEmploymentList.removeAt(index);
    });
  }

  DateTime? _employmentStartDateSelected;

  Future<void> _employmentStartDateCalendar() async {
    try {
      showMonthPicker(
        context,
        onSelected: (month, year) {
          DateTime selectedDate = DateTime(year, month);
          setState(() {
            _employmentStartDateSelected = selectedDate;
            customerEmploymentStartDateController.text =
                DateFormat.yMMM().format(selectedDate);
          });
        },
        initialSelectedMonth: DateTime.now().month,
        initialSelectedYear: DateTime.now().year,
        firstYear: DateTime(1950).year,
        lastYear: lastYear,
        selectButtonText: 'OK',
        cancelButtonText: 'Cancel',
        highlightColor: AppColors.primaryColor,
        textColor: AppColors.text_color_black,
        contentBackgroundColor: AppColors.authBgcolor,
        dialogBackgroundColor: AppColors.lightorengecolor,
      );
    } catch (e) {
      log("Error: $e");
    }
  }

  Future<void> _employmentEndDateCalendar() async {
    if (_employmentStartDateSelected == null) {
      log("Error: Start date not selected");
      return;
    }

    showMonthPicker(
      context,
      onSelected: (month, year) {
        DateTime selectedDate = DateTime(year, month);
        setState(() {
          customerEmploymentEndDateController.text =
              DateFormat.yMMM().format(selectedDate);
        });
      },
      initialSelectedMonth: DateTime.now().month,
      initialSelectedYear: DateTime.now().year,
      firstEnabledMonth: _employmentStartDateSelected!.month,
      firstYear: _employmentStartDateSelected!.year,
      lastYear: lastYear,
      selectButtonText: 'OK',
      cancelButtonText: 'Cancel',
      highlightColor: AppColors.primaryColor,
      textColor: AppColors.text_color_black,
      contentBackgroundColor: AppColors.authBgcolor,
      dialogBackgroundColor: AppColors.lightorengecolor,
    );
  }

  ///

  /// Professional and Personal Skills

  int? _editingIndexProfessional;
  int? _editingIndexPersonal;

  bool? isProfessionalSkillEdit;
  bool? isPersonalSkillEdit;

  void addOrUpdateProfessionalAndPersonalSkill() {
    if (_professionalAndPersonalSkillFormKey.currentState!.saveAndValidate()) {
      setState(() {
        // Handle adding or updating Professional Skill
        if (customerProfessionalSkillController.text.isNotEmpty) {
          if (_editingIndexProfessional != null) {
            customerProfessionalSkillList[_editingIndexProfessional!] =
                ProfessionalSkill(
              professionalSkill: customerProfessionalSkillController.text,
            );
            _editingIndexProfessional = null;
            isProfessionalSkillEdit = false;
          } else {
            if (customerProfessionalSkillList.length <
                professionalSkillLength) {
              customerProfessionalSkillList.add(
                ProfessionalSkill(
                  professionalSkill: customerProfessionalSkillController.text,
                ),
              );
            } else {
              toastification.show(
                type: ToastificationType.error,
                showProgressBar: true,
                context: context,
                autoCloseDuration: const Duration(seconds: 5),
                animationDuration: const Duration(milliseconds: 300),
                title: AppText(
                  text:
                      "You can only add up to $professionalSkillLength professional skill entries.",
                ),
              );
            }
          }
        }

        if (customerPersonalSkillController.text.isNotEmpty) {
          // Handle adding or updating Personal Skill
          if (_editingIndexPersonal != null) {
            customerPersonalSkillList[_editingIndexPersonal!] = PersonalSkill(
              personalSkill: customerPersonalSkillController.text,
            );
            _editingIndexPersonal = null;
            isPersonalSkillEdit = false;
          } else {
            if (customerPersonalSkillList.length < personalSkillLength) {
              customerPersonalSkillList.add(
                PersonalSkill(
                  personalSkill: customerPersonalSkillController.text,
                ),
              );
            } else {
              toastification.show(
                type: ToastificationType.error,
                showProgressBar: true,
                context: context,
                autoCloseDuration: const Duration(seconds: 5),
                animationDuration: const Duration(milliseconds: 300),
                title: AppText(
                  text:
                      "You can only add up to $personalSkillLength personal skill entries.",
                ),
              );
            }
          }
        }

        // Clear the text fields
        customerProfessionalSkillController.clear();
        customerPersonalSkillController.clear();
      });
    }
  }

  void editProfessionalAndPersonalSkill(int index) {
    setState(() {
      customerProfessionalSkillController.text =
          customerProfessionalSkillList[index].professionalSkill;
      customerPersonalSkillController.text =
          customerPersonalSkillList[index].personalSkill;

      _editingIndexProfessional = index;
      _editingIndexPersonal = index;
    });
  }

  void deleteProfessionalAndPersonalSkill(int index) {
    setState(() {
      customerProfessionalSkillList.removeAt(index);
      customerPersonalSkillList.removeAt(index);
    });
  }

  ///

  /// Skils and Level

  int? editingSkillIndex;

  bool? isSkillEdit;

  void addOrUpdateSkillAndLevel() {
    if (_skillAndLevelFormKey.currentState!.validate()) {
      setState(() {
        if (editingSkillIndex != null) {
          customerSkillList[editingSkillIndex!] = Skill(
              skill: customerSkillController.text, level: customerSkillLevel);
          editingSkillIndex = null;
          isSkillEdit = false;
        } else {
          if (customerSkillList.length < skillLength) {
            customerSkillList.add(Skill(
                skill: customerSkillController.text,
                level: customerSkillLevel));
          } else {
            toastification.show(
              type: ToastificationType.error,
              showProgressBar: true,
              context: context,
              autoCloseDuration: const Duration(seconds: 5),
              animationDuration: const Duration(milliseconds: 300),
              title: AppText(
                text: "You can only add up to $skillLength skill entries.",
              ),
            );
          }
        }

        customerSkillController.clear();
        customerSkillLevel = 0;
      });
    }
  }

  void editSkillAndLevel(int index) {
    setState(() {
      customerSkillController.text = customerSkillList[index].skill;
      customerSkillLevel = customerSkillList[index].level;

      editingSkillIndex = index;
    });
  }

  void deleteSkillAndLevel(int index) {
    setState(() {
      customerSkillList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return _isDataLoaded
        ? Scaffold(
            backgroundColor: AppColors.white_color,
            body: BlocBuilder<EditResumeBloc, EditResumeState>(
              builder: (context, state) {
                if (state is EditResumeLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is EditResumeLoaded) {
                  if (_isFirstLoad) {
                    _updateStateFromLoadedData(state);
                    _isFirstLoad = false;
                  }
                } else if (state is EditResumeError) {
                  return Text(state.message);
                }
                return ListView(
                  padding: EdgeInsets.all(
                      MediaQuery.of(context).size.width <= kScreenWidthMd
                          ? kDefaultPadding
                          : kDefaultPadding * 2),
                  children: [
                    AppText(
                      text: "Edit your personal info",
                      fontsize:
                          MediaQuery.of(context).size.width <= kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 16
                              : 48,
                      fontWeight: FontWeight.w700,
                    ),
                    buildSizedBoxH(
                        MediaQuery.of(context).size.width <= kScreenWidthMd
                            ? MediaQuery.of(context).size.width / 12
                            : kDefaultPadding * 4),
                    if (size.width > kScreenWidthXxl)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildinformation()),
                          buildSizedBoxW(kDefaultPadding * 2),
                          _buildpreview(context)
                        ],
                      ),
                    if (size.width <= kScreenWidthXxl)
                      Column(
                        children: [
                          _buildinformation(),
                          buildSizedBoxH(kDefaultPadding * 2),
                          _buildpreview(context),
                        ],
                      ),
                  ],
                );
              },
            ),
          )
        : const SizedBox.shrink();
  }

  void _updateStateFromLoadedData(EditResumeLoaded state) {
    id = state.resumeData['id'].toString();
    resumeId = state.resumeData['resumeid'].toString();
    customerFirstNametext =
        state.resumeData['customerFirstNametext'].toString();
    customerLastNametext = state.resumeData['customerLastNametext'].toString();
    customerProfileImageURL =
        state.resumeData['customerProfileImage'].toString();
    customerProfessiontext =
        state.resumeData['customerProfessiontext'].toString();
    customerLocationtext = state.resumeData['customerLocationtext'].toString();
    customerWebsitetext = state.resumeData['customerWebsitetext'].toString();
    customerPhoneNotext = state.resumeData['customerPhoneNotext'].toString();
    customerEmailIDtext = state.resumeData['customerEmailIDtext'].toString();
    customerProfessionalSummarytext =
        state.resumeData['customerProfessionalSummarytext'].toString();

    customerEducationList = state.resumeData['customerEducationList'] != null
        ? (state.resumeData['customerEducationList'] as List<dynamic>)
            .map<Education>((item) => Education.fromJson(item))
            .toList()
        : [];
    customerEmploymentList = state.resumeData['customerEmploymentList'] != null
        ? (state.resumeData['customerEmploymentList'] as List<dynamic>)
            .map<Employment>((item) => Employment.fromJson(item))
            .toList()
        : [];
    customerProfessionalSkillList = state
                .resumeData['customerProfessionalSkillList'] !=
            null
        ? (state.resumeData['customerProfessionalSkillList'] as List<dynamic>)
            .map<ProfessionalSkill>((item) => ProfessionalSkill.fromJson(item))
            .toList()
        : [];
    customerPersonalSkillList =
        state.resumeData['customerPersonalSkillList'] != null
            ? (state.resumeData['customerPersonalSkillList'] as List<dynamic>)
                .map<PersonalSkill>((item) => PersonalSkill.fromJson(item))
                .toList()
            : [];
    customerSkillList = state.resumeData['customerSkillList'] != null
        ? (state.resumeData['customerSkillList'] as List<dynamic>)
            .map<Skill>((item) => Skill.fromJson(item))
            .toList()
        : [];
    createdAt = state.resumeData['createdAt'];
    updatedAt = state.resumeData['updatedAt'];
  }

  Widget _buildpreview(BuildContext context) {
    return Column(
      children: [
        getinvoicebyid(id),
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
            ? MediaQuery.of(context).size.width / 9.6
            : kDefaultPadding * 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildUpdateButton(),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailsListCard(String title, String values) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: "$title: ",
          fontsize: 14,
          fontWeight: FontWeight.w500,
        ),
        Expanded(child: AppText(text: values, fontsize: 14)),
      ],
    );
  }

  Widget _buildinformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (id != "5" && id != "10")
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitleText("Upload Photo", false),
              buildSizedBoxH(kDefaultPadding * 2),
              _buildUploadPhoto(),
              buildSizedBoxH(kDefaultPadding * 2),
            ],
          ),
        FormBuilder(
          key: _personalFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitleText("Personal Details", false),
              buildSizedBoxH(kDefaultPadding * 2),
              _buildPersonalDetails(),
              buildSizedBoxH(kDefaultPadding * 2),
              _buildTitleText("Professional Summary", false),
              buildSizedBoxH(kDefaultPadding * 2),
              _buildProfessionalSummary(),
            ],
          ),
        ),
        buildSizedBoxH(kDefaultPadding * 2),
        _buildTitleText(
            "Education", true, addOrUpdateEducation, isEducationEdit),
        buildSizedBoxH(kDefaultPadding * 2),
        _buildEducation(),
        buildSizedBoxH(kDefaultPadding),
        _educationList(),
        buildSizedBoxH(kDefaultPadding * 2),
        _buildTitleText(
            "Employment", true, addOrUpdateEmployment, isEmploymentEdit),
        buildSizedBoxH(kDefaultPadding * 2),
        _buildEmployment(),
        buildSizedBoxH(kDefaultPadding),
        _employmentList(),
        buildSizedBoxH(kDefaultPadding * 2),
        _buildTitleText(
          "Skills",
          true,
          (id == "1" || id == "7"
              ? addOrUpdateProfessionalAndPersonalSkill
              : addOrUpdateSkillAndLevel),
          (id == "1" || id == "7"
              ? ((isProfessionalSkillEdit ?? false) ||
                  (isPersonalSkillEdit ?? false))
              : isSkillEdit),
        ),
        buildSizedBoxH(kDefaultPadding * 2),
        _buildSkill(),
        buildSizedBoxH(kDefaultPadding * 2),
        _buildProfessionalAndPersonalSkillList(),
        _buildSkillAndLevelList(),
        buildSizedBoxH(kDefaultPadding * 2),
      ],
    );
  }

  Widget _buildUpdateButton() {
    return BlocConsumer<EditResumeBloc, EditResumeState>(
      listener: (context, state) {
        if (state is UpdateResumeLoading) {
          setState(() {
            showLoading = true;
          });
        } else if (state is UpdateResumeSuccess) {
          toastification.show(
            type: ToastificationType.success,
            showProgressBar: showpogressbar,
            context: context,
            autoCloseDuration: const Duration(seconds: 5),
            animationBuilder: buildAnimation,
            animationDuration: const Duration(milliseconds: 300),
            title: const Text('Resume save Successfully'),
          );

          Router.neglect(
              context, () => GoRouter.of(context).go(RouteUri.resumelist));

          setState(() {
            showLoading = false;
          });
        } else if (state is UpdateResumeFaild) {
          setState(() {
            showLoading = false;
          });
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialog(
                message: "Create Resume Failed.",
                positiveButtonText: 'Ok',
                onpositivePressed: () {
                  Navigator.pop(context);
                },
              );
            },
          );
        }
      },
      builder: (context, state) {
        return MouseRegion(
          onEnter: (event) => _mouseEnterUpdateButton(true),
          onExit: (event) => _mouseEnterUpdateButton(false),
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: showLoading
                ? null
                : () async {
                    if (_personalFormKey.currentState!.validate()) {
                      _personalFormKey.currentState!.save();

                      if (customerProfileImage != null) {
                        try {
                          final ref = firebase_storage.FirebaseStorage.instance
                              .ref()
                              .child('profile_images')
                              .child(userUid!)
                              .child(resumeId);

                          try {
                            final existingRef = await ref.listAll();
                            for (var item in existingRef.items) {
                              await item.delete();
                            }
                          } catch (e) {
                            if (e is! firebase_storage.FirebaseException ||
                                e.code != 'object-not-found') {
                              rethrow;
                            }
                          }

                          final newImageRef = ref.child(
                              '${DateTime.now().millisecondsSinceEpoch}.jpg');

                          final uploadTask =
                              newImageRef.putData(customerProfileImage!);

                          await uploadTask.whenComplete(() async {
                            final downloadURL =
                                await newImageRef.getDownloadURL();
                            log('Image uploaded successfully: $downloadURL');
                            if (mounted) {
                              setState(() {
                                customerProfileImageURL = downloadURL;
                              });
                            }
                          });
                        } catch (e) {
                          log('Error updating profile image: $e');
                        }
                      }

                      context.read<EditResumeBloc>().add(
                            UpdateResumeRequested(
                              uid: userUid!,
                              id: id,
                              resumeid: resumeId,
                              customerProfileImageURL:
                                  customerProfileImageURL ?? '',
                              customerFirstNametext: customerFirstNametext,
                              customerLastNametext: customerLastNametext,
                              customerProfessiontext: customerProfessiontext,
                              customerLocationtext: customerLocationtext,
                              customerWebsitetext: customerWebsitetext,
                              customerPhoneNotext: customerPhoneNotext,
                              customerEmailIDtext: customerEmailIDtext,
                              customerProfessionalSummarytext:
                                  customerProfessionalSummarytext,
                              customerUniversitytext: customerUniversitytext,
                              customerDegreetext: customerDegreetext,
                              customerStartDatetext: customerStartDatetext,
                              customerEndDatetext: customerEndDatetext,
                              customerJobTitletext: customerJobTitletext,
                              customerCompanyNametext: customerCompanyNametext,
                              customerEmploymentStartDatetext:
                                  customerEmploymentStartDatetext,
                              customerEmploymentEndDatetext:
                                  customerEmploymentEndDatetext,
                              customerEmploymentAddresstext:
                                  customerEmploymentAddresstext,
                              customerSkilltext: customerSkilltext,
                              customerProfessionalSkilltext:
                                  customerProfessionalSkilltext,
                              customerPersonalSkilltext:
                                  customerPersonalSkilltext,
                              customerSkillLevel: customerSkillLevel,
                              customerEducationList: customerEducationList,
                              customerEmploymentList: customerEmploymentList,
                              customerProfessionalSkillList:
                                  customerProfessionalSkillList,
                              customerPersonalSkillList:
                                  customerPersonalSkillList,
                              customerSkillList: customerSkillList,
                              createdAt: createdAt,
                              updatedAt: DateTime.now().toString(),
                            ),
                          );

                      Future.delayed(const Duration(seconds: 2), () {
                        customerFirstNameController.clear();
                        customerLastNameController.clear();
                        customerProfessionController.clear();
                        customerLocationController.clear();
                        customerWebsiteController.clear();
                        customerPhoneNoController.clear();
                        customerEmailIDController.clear();
                        customerProfessionalSummaryController.clear();
                        customerUniversityController.clear();
                        customerDegreeController.clear();
                        customerEducationStartDateController.clear();
                        customerEducationEndDateController.clear();
                        customerJobTitleController.clear();
                        customerCompanyNameController.clear();
                        customerEmploymentStartDateController.clear();
                        customerEmploymentEndDateController.clear();
                        customerEmploymentAddressController.clear();
                        customerSkillController.clear();
                        customerProfessionalSkillController.clear();
                        customerPersonalSkillController.clear();
                        customerEducationList.clear();
                        customerEmploymentList.clear();
                        customerProfessionalSkillList.clear();
                        customerPersonalSkillList.clear();
                        customerSkillList.clear();
                        customerSkillLevel = 0;
                        customerProfileImageURL = null;
                        customerProfileImage = null;
                      });
                    }
                  },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: MediaQuery.of(context).size.width <= kScreenWidthLg
                    ? 60
                    : MediaQuery.of(context).size.width <= kScreenWidthXxl
                        ? MediaQuery.of(context).size.width / 23.33
                        : 60,
                vertical: MediaQuery.of(context).size.width <= kScreenWidthLg
                    ? 10
                    : MediaQuery.of(context).size.width <= kScreenWidthXxl
                        ? MediaQuery.of(context).size.width / 140
                        : 10,
              ),
              decoration: BoxDecoration(
                color: isUpdateButtonHovered
                    ? AppColors.white_color
                    : AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 4),
                    color: AppColors.primaryColor.withOpacity(0.25),
                    blurRadius: 20,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: showLoading
                  ? Center(
                      child: SizedBox(
                        height:
                            MediaQuery.of(context).size.width <= kScreenWidthMd
                                ? MediaQuery.of(context).size.width / 25.6
                                : 30,
                        width:
                            MediaQuery.of(context).size.width <= kScreenWidthMd
                                ? MediaQuery.of(context).size.width / 25.6
                                : 30,
                        child: CircularProgressIndicator(
                          color: isUpdateButtonHovered
                              ? AppColors.primaryColor
                              : AppColors.white_color,
                          strokeWidth: 2.5,
                        ),
                      ),
                    )
                  : AppText(
                      text: "Update Resume",
                      fontsize: MediaQuery.of(context).size.width <=
                              kScreenWidthLg
                          ? 25
                          : MediaQuery.of(context).size.width <= kScreenWidthXxl
                              ? MediaQuery.of(context).size.width / 56
                              : 25,
                      fontWeight: FontWeight.w400,
                      color: isUpdateButtonHovered
                          ? AppColors.primaryColor
                          : AppColors.white_color,
                    ),
            ),
          ),
        );
      },
    );
  }

  Widget getinvoicebyid(String status) {
    switch (status) {
      case '1':
        return ResumeTemplate1(
          customerFirstNametext: customerFirstNametext,
          customerLastNametext: customerLastNametext,
          customerProfileImage: customerProfileImage,
          customerProfileImageURL: customerProfileImageURL,
          customerProfessiontext: customerProfessiontext,
          customerLocationtext: customerLocationtext,
          customerWebsitetext: customerWebsitetext,
          customerPhoneNotext: customerPhoneNotext,
          customerEmailIDtext: customerEmailIDtext,
          customerProfessionalSummarytext: customerProfessionalSummarytext,
          customerEducationList: customerEducationList,
          customerEmploymentList: customerEmploymentList,
          customerProfessionalSkillList: customerProfessionalSkillList,
          customerPersonalSkillList: customerPersonalSkillList,
        );
      case '2':
        return ResumeTemplate2(
          customerFirstNametext: customerFirstNametext,
          customerLastNametext: customerLastNametext,
          customerProfileImage: customerProfileImage,
          customerProfileImageURL: customerProfileImageURL,
          customerProfessiontext: customerProfessiontext,
          customerLocationtext: customerLocationtext,
          customerWebsitetext: customerWebsitetext,
          customerPhoneNotext: customerPhoneNotext,
          customerEmailIDtext: customerEmailIDtext,
          customerProfessionalSummarytext: customerProfessionalSummarytext,
          customerEducationList: customerEducationList,
          customerEmploymentList: customerEmploymentList,
          customerSkillList: customerSkillList,
        );
      case '3':
        return ResumeTemplate3(
          customerFirstNametext: customerFirstNametext,
          customerLastNametext: customerLastNametext,
          customerProfileImage: customerProfileImage,
          customerProfileImageURL: customerProfileImageURL,
          customerProfessiontext: customerProfessiontext,
          customerLocationtext: customerLocationtext,
          customerWebsitetext: customerWebsitetext,
          customerPhoneNotext: customerPhoneNotext,
          customerEmailIDtext: customerEmailIDtext,
          customerProfessionalSummarytext: customerProfessionalSummarytext,
          customerEducationList: customerEducationList,
          customerEmploymentList: customerEmploymentList,
          customerSkillList: customerSkillList,
        );
      case '4':
        return ResumeTemplate4(
          customerFirstNametext: customerFirstNametext,
          customerLastNametext: customerLastNametext,
          customerProfileImage: customerProfileImage,
          customerProfileImageURL: customerProfileImageURL,
          customerProfessiontext: customerProfessiontext,
          customerLocationtext: customerLocationtext,
          customerWebsitetext: customerWebsitetext,
          customerPhoneNotext: customerPhoneNotext,
          customerEmailIDtext: customerEmailIDtext,
          customerProfessionalSummarytext: customerProfessionalSummarytext,
          customerEducationList: customerEducationList,
          customerEmploymentList: customerEmploymentList,
          customerSkillList: customerSkillList,
        );
      case '5':
        return ResumeTemplate5(
          customerFirstNametext: customerFirstNametext,
          customerLastNametext: customerLastNametext,
          customerProfileImage: customerProfileImage,
          customerProfileImageURL: customerProfileImageURL,
          customerProfessiontext: customerProfessiontext,
          customerLocationtext: customerLocationtext,
          customerWebsitetext: customerWebsitetext,
          customerPhoneNotext: customerPhoneNotext,
          customerEmailIDtext: customerEmailIDtext,
          customerProfessionalSummarytext: customerProfessionalSummarytext,
          customerEducationList: customerEducationList,
          customerEmploymentList: customerEmploymentList,
          customerSkillList: customerSkillList,
        );
      case '6':
        return ResumeTemplate6(
          customerFirstNametext: customerFirstNametext,
          customerLastNametext: customerLastNametext,
          customerProfileImage: customerProfileImage,
          customerProfileImageURL: customerProfileImageURL,
          customerProfessiontext: customerProfessiontext,
          customerLocationtext: customerLocationtext,
          customerWebsitetext: customerWebsitetext,
          customerPhoneNotext: customerPhoneNotext,
          customerEmailIDtext: customerEmailIDtext,
          customerProfessionalSummarytext: customerProfessionalSummarytext,
          customerEducationList: customerEducationList,
          customerEmploymentList: customerEmploymentList,
          customerSkillList: customerSkillList,
        );
      case '7':
        return ResumeTemplate7(
          customerFirstNametext: customerFirstNametext,
          customerLastNametext: customerLastNametext,
          customerProfileImage: customerProfileImage,
          customerProfileImageURL: customerProfileImageURL,
          customerProfessiontext: customerProfessiontext,
          customerLocationtext: customerLocationtext,
          customerWebsitetext: customerWebsitetext,
          customerPhoneNotext: customerPhoneNotext,
          customerEmailIDtext: customerEmailIDtext,
          customerProfessionalSummarytext: customerProfessionalSummarytext,
          customerEducationList: customerEducationList,
          customerEmploymentList: customerEmploymentList,
          customerProfessionalSkillList: customerProfessionalSkillList,
          customerPersonalSkillList: customerPersonalSkillList,
        );
      case '8':
        return ResumeTemplate8(
          customerFirstNametext: customerFirstNametext,
          customerLastNametext: customerLastNametext,
          customerProfileImage: customerProfileImage,
          customerProfileImageURL: customerProfileImageURL,
          customerProfessiontext: customerProfessiontext,
          customerLocationtext: customerLocationtext,
          customerWebsitetext: customerWebsitetext,
          customerPhoneNotext: customerPhoneNotext,
          customerEmailIDtext: customerEmailIDtext,
          customerProfessionalSummarytext: customerProfessionalSummarytext,
          customerEducationList: customerEducationList,
          customerEmploymentList: customerEmploymentList,
          customerSkillList: customerSkillList,
        );
      case '9':
        return ResumeTemplate9(
          customerFirstNametext: customerFirstNametext,
          customerLastNametext: customerLastNametext,
          customerProfileImage: customerProfileImage,
          customerProfileImageURL: customerProfileImageURL,
          customerProfessiontext: customerProfessiontext,
          customerLocationtext: customerLocationtext,
          customerWebsitetext: customerWebsitetext,
          customerPhoneNotext: customerPhoneNotext,
          customerEmailIDtext: customerEmailIDtext,
          customerProfessionalSummarytext: customerProfessionalSummarytext,
          customerEducationList: customerEducationList,
          customerEmploymentList: customerEmploymentList,
          customerSkillList: customerSkillList,
        );
      case '10':
        return ResumeTemplate10(
          customerFirstNametext: customerFirstNametext,
          customerLastNametext: customerLastNametext,
          customerProfileImage: customerProfileImage,
          customerProfileImageURL: customerProfileImageURL,
          customerProfessiontext: customerProfessiontext,
          customerLocationtext: customerLocationtext,
          customerWebsitetext: customerWebsitetext,
          customerPhoneNotext: customerPhoneNotext,
          customerEmailIDtext: customerEmailIDtext,
          customerProfessionalSummarytext: customerProfessionalSummarytext,
          customerEducationList: customerEducationList,
          customerEmploymentList: customerEmploymentList,
          customerSkillList: customerSkillList,
        );
      default:
        return ResumeTemplate1(
          customerFirstNametext: customerFirstNametext,
          customerLastNametext: customerLastNametext,
          customerProfileImage: customerProfileImage,
          customerProfileImageURL: customerProfileImageURL,
          customerProfessiontext: customerProfessiontext,
          customerLocationtext: customerLocationtext,
          customerWebsitetext: customerWebsitetext,
          customerPhoneNotext: customerPhoneNotext,
          customerEmailIDtext: customerEmailIDtext,
          customerProfessionalSummarytext: customerProfessionalSummarytext,
          customerEducationList: customerEducationList,
          customerEmploymentList: customerEmploymentList,
          customerProfessionalSkillList: customerProfessionalSkillList,
          customerPersonalSkillList: customerPersonalSkillList,
        );
    }
  }

  Widget _buildTitleText(String title, bool showAddMoreButton,
      [void Function()? onTap, bool? showSaveButton]) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(text: title, fontsize: 20, color: AppColors.black_color),
        if (showAddMoreButton)
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: onTap,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal:
                      MediaQuery.of(context).size.width <= kScreenWidthLg
                          ? 40
                          : MediaQuery.of(context).size.width <= kScreenWidthXxl
                              ? MediaQuery.of(context).size.width / 23.33
                              : 40,
                  vertical: MediaQuery.of(context).size.width <= kScreenWidthLg
                      ? 10
                      : MediaQuery.of(context).size.width <= kScreenWidthXxl
                          ? MediaQuery.of(context).size.width / 140
                          : 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 4),
                      color: AppColors.primaryColor.withOpacity(0.25),
                      blurRadius: 20,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: AppText(
                  text: showSaveButton == true ? "Save" : "Add More",
                  fontsize: MediaQuery.of(context).size.width <= kScreenWidthLg
                      ? 16
                      : MediaQuery.of(context).size.width <= kScreenWidthXxl
                          ? MediaQuery.of(context).size.width / 87.5
                          : 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white_color,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildUploadPhoto() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          _pickImage();
        },
        child: DottedBorder(
          color: Colors.black,
          strokeWidth: 1,
          borderType: BorderType.RRect,
          radius: const Radius.circular(kDefaultPadding),
          dashPattern: const [10, 10],
          child: Container(
            height: MediaQuery.of(context).size.width <= kScreenWidthMd
                ? MediaQuery.of(context).size.width / 5.77
                : 133,
            width: MediaQuery.of(context).size.width <= kScreenWidthMd
                ? MediaQuery.of(context).size.width
                : 310,
            decoration: BoxDecoration(
              color: AppColors.lightgray_color,
              borderRadius: BorderRadius.circular(kDefaultPadding),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("${AppImages.pngImage}img_select_image.png",
                    height: MediaQuery.of(context).size.width <= kScreenWidthMd
                        ? MediaQuery.of(context).size.width / 20.75
                        : 37,
                    width: MediaQuery.of(context).size.width <= kScreenWidthMd
                        ? MediaQuery.of(context).size.width / 20.75
                        : 37),
                buildSizedBoxH(
                    MediaQuery.of(context).size.width <= kScreenWidthMd
                        ? MediaQuery.of(context).size.width / 64
                        : 12),
                AppText(
                  text: "Select Image",
                  color: AppColors.text_color_black,
                  fontsize: MediaQuery.of(context).size.width <= kScreenWidthMd
                      ? MediaQuery.of(context).size.width / 51.2
                      : 15,
                  fontWeight: FontWeight.w500,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalDetails() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomAppTextField(
                controller: customerFirstNameController,
                labelText: 'First Name',
                inputFormatters: [LengthLimitingTextInputFormatter(16)],
                onChanged: (value) {
                  setState(() {
                    customerFirstNametext = customerFirstNameController.text;
                    if (customerFirstNameController.text.isEmpty) {
                      customerFirstNametext = "Jeremy";
                    }
                  });
                },
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: "Please enter your first name"),
                  FormBuilderValidators.match(r'^[A-Z][a-z]*$',
                      errorText:
                          'Customer first name start with capital letter'),
                ]),
              ),
            ),
            buildSizedBoxW(MediaQuery.of(context).size.width <= kScreenWidthMd
                ? MediaQuery.of(context).size.width / 16.69
                : 46),
            Expanded(
              child: CustomAppTextField(
                controller: customerLastNameController,
                inputFormatters: [LengthLimitingTextInputFormatter(16)],
                labelText: 'Last Name',
                onChanged: (value) {
                  setState(() {
                    customerLastNametext = customerLastNameController.text;
                    if (customerLastNameController.text.isEmpty) {
                      customerLastNametext = "Clifford";
                    }
                  });
                },
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: "Please enter your last name"),
                  FormBuilderValidators.match(r'^[A-Z][a-z]*$',
                      errorText:
                          'Customer last name start with capital letter'),
                ]),
              ),
            ),
          ],
        ),
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
            ? MediaQuery.of(context).size.width / 24
            : kDefaultPadding * 2),
        CustomAppTextField(
          controller: customerProfessionController,
          inputFormatters: [LengthLimitingTextInputFormatter(30)],
          labelText: 'Profession',
          onChanged: (value) {
            setState(() {
              customerProfessiontext = customerProfessionController.text;
              if (customerProfessionController.text.isEmpty) {
                customerProfessiontext = "UI/UX Designer";
              }
            });
          },
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
                errorText: "Please enter your profession"),
          ]),
        ),
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
            ? MediaQuery.of(context).size.width / 24
            : kDefaultPadding * 2),
        Row(
          children: [
            Expanded(
              child: CustomAppTextField(
                controller: customerLocationController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(contectsLength)
                ],
                labelText: 'Location',
                onChanged: (value) {
                  setState(() {
                    customerLocationtext = customerLocationController.text;
                    if (customerLocationController.text.isEmpty) {
                      customerLocationtext = "";
                    }
                  });
                },
                validator: FormBuilderValidators.compose([]),
              ),
            ),
            buildSizedBoxW(
                id == "5" || id == "7" || id == "8" || id == "9" || id == "10"
                    ? 0
                    : MediaQuery.of(context).size.width <= kScreenWidthMd
                        ? MediaQuery.of(context).size.width / 16.69
                        : 46),
            id == "5" || id == "7" || id == "8" || id == "9" || id == "10"
                ? const SizedBox.shrink()
                : Expanded(
                    child: CustomAppTextField(
                      controller: customerWebsiteController,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(contectsLength)
                      ],
                      labelText: 'Website',
                      onChanged: (value) {
                        setState(() {
                          customerWebsitetext = customerWebsiteController.text;
                          if (customerWebsiteController.text.isEmpty) {
                            customerWebsitetext = "";
                          }
                        });
                      },
                      validator: FormBuilderValidators.compose([]),
                    ),
                  ),
          ],
        ),
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
            ? MediaQuery.of(context).size.width / 24
            : kDefaultPadding * 2),
        Row(
          children: [
            Expanded(
              child: CustomAppTextField(
                controller: customerPhoneNoController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^[0-9\s+\-()]*$')),
                  LengthLimitingTextInputFormatter(15),
                ],
                labelText: 'Phone No.',
                onChanged: (value) {
                  setState(() {
                    customerPhoneNotext = customerPhoneNoController.text;
                    if (customerPhoneNoController.text.isEmpty) {
                      customerPhoneNotext = "";
                    }
                  });
                },
                validator: FormBuilderValidators.compose([]),
              ),
            ),
            buildSizedBoxW(MediaQuery.of(context).size.width <= kScreenWidthMd
                ? MediaQuery.of(context).size.width / 16.69
                : 46),
            Expanded(
              child: CustomAppTextField(
                controller: customerEmailIDController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(contectsLength)
                ],
                labelText: 'Email ID',
                onChanged: (value) {
                  setState(() {
                    customerEmailIDtext = customerEmailIDController.text;
                    if (customerEmailIDController.text.isEmpty) {
                      customerEmailIDtext = "";
                    }
                  });
                },
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.email(),
                ]),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfessionalSummary() {
    return Column(
      children: [
        CustomAppTextField(
          controller: customerProfessionalSummaryController,
          maxLines: 4,
          maxLength: 250,
          inputFormatters: [
            LengthLimitingTextInputFormatter(professionalSummaryLength)
          ],
          labelText: "",
          onChanged: (value) {
            setState(() {
              customerProfessionalSummarytext =
                  customerProfessionalSummaryController.text;
              if (customerProfessionalSummaryController.text.isEmpty) {
                customerProfessionalSummarytext =
                    'Graphic designer with +8 years of experience in branding and print design. Skilled at Adobe Creative Suite (Photoshop, Illustrator) as well as sketching and hand drawing. Supervised 23 print design projects that resulted in an increase of 32% in savings.';
              }
            });
          },
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
                errorText: "Please enter your professional summary"),
          ]),
        ),
      ],
    );
  }

  Widget _buildEducation() {
    return FormBuilder(
      key: _educationFormKey,
      child: Column(
        children: [
          CustomAppTextField(
            labelText: 'School/University',
            controller: customerUniversityController,
            inputFormatters: [LengthLimitingTextInputFormatter(26)],
            onChanged: (value) {
              setState(() {
                customerUniversitytext = customerUniversityController.text;
                if (customerUniversityController.text.isEmpty) {
                  customerUniversitytext = 'Los Angeles University';
                }
              });
            },
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText: "Please enter your school/university"),
            ]),
          ),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 24
              : kDefaultPadding * 2),
          MediaQuery.of(context).size.width <= kScreenWidthMd
              ? Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomAppTextField(
                            controller: customerEducationStartDateController,
                            labelText: 'Start Date',
                            readOnly: true,
                            onTap: _educationStartDateCalendar,
                            onChanged: (value) {
                              setState(() {
                                customerStartDatetext =
                                    customerEducationStartDateController.text;
                                if (customerEducationStartDateController
                                    .text.isEmpty) {
                                  customerStartDatetext = '2005';
                                }
                              });
                            },
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText:
                                      "Please enter your education start date"),
                            ]),
                          ),
                        ),
                        buildSizedBoxW(
                            MediaQuery.of(context).size.width <= kScreenWidthMd
                                ? MediaQuery.of(context).size.width / 16.69
                                : 46),
                        Expanded(
                          child: CustomAppTextField(
                            controller: customerEducationEndDateController,
                            labelText: 'End Date',
                            readOnly: true,
                            onTap: () {
                              if (_educationStartDateSelected == null) {
                                toastification.show(
                                  type: ToastificationType.error,
                                  showProgressBar: true,
                                  context: context,
                                  autoCloseDuration: const Duration(seconds: 5),
                                  animationDuration:
                                      const Duration(milliseconds: 300),
                                  title: const AppText(
                                      text:
                                          "Please select the education start date first."),
                                );
                              } else {
                                _educationEndDateCalendar();
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                                customerEndDatetext =
                                    customerEducationEndDateController.text;
                                if (customerEducationEndDateController
                                    .text.isEmpty) {
                                  customerEndDatetext = '2010';
                                }
                              });
                            },
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText:
                                      "Please enter your education end date"),
                            ]),
                          ),
                        ),
                      ],
                    ),
                    buildSizedBoxH(
                        MediaQuery.of(context).size.width <= kScreenWidthMd
                            ? MediaQuery.of(context).size.width / 24
                            : kDefaultPadding * 2),
                    CustomAppTextField(
                      controller: customerDegreeController,
                      labelText: 'Degree',
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(educationDegreeLength)
                      ],
                      onChanged: (value) {
                        setState(() {
                          customerDegreetext = customerDegreeController.text;
                          if (customerDegreeController.text.isEmpty) {
                            customerDegreetext =
                                'Bachelor of Fine Arts in Graphic Design, GPA: 3.4/4.0';
                          }
                        });
                      },
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "Please enter your education degree"),
                      ]),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomAppTextField(
                              controller: customerEducationStartDateController,
                              labelText: 'Start Date',
                              readOnly: true,
                              onTap: _educationStartDateCalendar,
                              onChanged: (value) {
                                setState(() {
                                  customerStartDatetext =
                                      customerEducationStartDateController.text;
                                  if (customerEducationStartDateController
                                      .text.isEmpty) {
                                    customerStartDatetext = '2005';
                                  }
                                });
                              },
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                    errorText:
                                        "Please enter your education start date"),
                              ]),
                            ),
                          ),
                          buildSizedBoxW(MediaQuery.of(context).size.width <=
                                  kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 16.69
                              : 46),
                          Expanded(
                            child: CustomAppTextField(
                              controller: customerEducationEndDateController,
                              labelText: 'End Date',
                              readOnly: true,
                              onTap: () {
                                if (_educationStartDateSelected == null) {
                                  toastification.show(
                                    type: ToastificationType.error,
                                    showProgressBar: true,
                                    context: context,
                                    autoCloseDuration:
                                        const Duration(seconds: 5),
                                    animationDuration:
                                        const Duration(milliseconds: 300),
                                    title: const AppText(
                                        text:
                                            "Please select the education start date first."),
                                  );
                                } else {
                                  _educationEndDateCalendar();
                                }
                              },
                              onChanged: (value) {
                                setState(() {
                                  customerEndDatetext =
                                      customerEducationEndDateController.text;
                                  if (customerEducationEndDateController
                                      .text.isEmpty) {
                                    customerEndDatetext = '2010';
                                  }
                                });
                              },
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                    errorText: "Please enter your end date"),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    buildSizedBoxW(
                        MediaQuery.of(context).size.width <= kScreenWidthMd
                            ? MediaQuery.of(context).size.width / 16.69
                            : 46),
                    Expanded(
                      child: CustomAppTextField(
                        controller: customerDegreeController,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(
                              educationDegreeLength)
                        ],
                        labelText: 'Degree',
                        onChanged: (value) {
                          setState(() {
                            customerDegreetext = customerDegreeController.text;
                            if (customerDegreeController.text.isEmpty) {
                              customerDegreetext =
                                  'Bachelor of Fine Arts in Graphic Design, GPA: 3.4/4.0';
                            }
                          });
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: "Please enter your education degree"),
                        ]),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _educationList() {
    return Column(
      children: List.generate(
        customerEducationList.length,
        (index) => Card(
          color: AppColors.white_color,
          elevation: 4,
          shadowColor: AppColors.black_color.withOpacity(0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.only(bottom: 10),
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: "Education ${(index + 1)}",
                      fontsize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              editEducation(index);
                              setState(() {
                                isEducationEdit = true;
                              });
                            },
                            child: Image.asset("${AppImages.ic}ic_edit.png",
                                height: 20, width: 20),
                          ),
                        ),
                        buildSizedBoxW(kDefaultPadding * 1.5),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              deleteEducation(index);
                            },
                            child: Image.asset("${AppImages.ic}ic_delete.png",
                                height: 20, width: 20),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                buildSizedBoxH(kTextPadding),
                const Divider(),
                buildSizedBoxH(kTextPadding),
                _buildDetailsListCard("Date",
                    "${customerEducationList[index].startDate} - ${customerEducationList[index].endDate}"),
                _buildDetailsListCard("School/University",
                    customerEducationList[index].university),
                _buildDetailsListCard(
                    "Degree", customerEducationList[index].degree),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmployment() {
    return FormBuilder(
      key: _employmentFormKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomAppTextField(
                  controller: customerJobTitleController,
                  labelText: 'Job Title',
                  inputFormatters: [LengthLimitingTextInputFormatter(25)],
                  onChanged: (value) {
                    setState(() {
                      customerJobTitletext = customerJobTitleController.text;
                      if (customerJobTitleController.text.isEmpty) {
                        customerJobTitletext = 'UI Designer';
                      }
                    });
                  },
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: "Please enter your job title"),
                  ]),
                ),
              ),
              buildSizedBoxW(MediaQuery.of(context).size.width <= kScreenWidthMd
                  ? MediaQuery.of(context).size.width / 16.69
                  : 46),
              Expanded(
                child: CustomAppTextField(
                  controller: customerCompanyNameController,
                  labelText: 'Company name',
                  inputFormatters: [LengthLimitingTextInputFormatter(25)],
                  onChanged: (value) {
                    setState(() {
                      customerCompanyNametext =
                          customerCompanyNameController.text;
                      if (customerCompanyNameController.text.isEmpty) {
                        customerCompanyNametext = 'Market Studios';
                      }
                    });
                  },
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: "Please enter your company name"),
                  ]),
                ),
              ),
            ],
          ),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 24
              : kDefaultPadding * 2),
          MediaQuery.of(context).size.width <= kScreenWidthMd
              ? Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomAppTextField(
                            controller: customerEmploymentStartDateController,
                            labelText: 'Start Date',
                            readOnly: true,
                            onTap: _employmentStartDateCalendar,
                            onChanged: (value) {
                              setState(() {
                                customerEmploymentStartDatetext =
                                    customerEmploymentStartDateController.text;
                                if (customerEmploymentStartDateController
                                    .text.isEmpty) {
                                  customerEmploymentStartDatetext = '2012';
                                }
                              });
                            },
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText:
                                      "Please enter your employment start date"),
                            ]),
                          ),
                        ),
                        buildSizedBoxW(
                            MediaQuery.of(context).size.width <= kScreenWidthMd
                                ? MediaQuery.of(context).size.width / 16.69
                                : 46),
                        Expanded(
                          child: CustomAppTextField(
                            controller: customerEmploymentEndDateController,
                            labelText: 'End Date',
                            readOnly: true,
                            onTap: () {
                              if (_employmentStartDateSelected == null) {
                                toastification.show(
                                  type: ToastificationType.error,
                                  showProgressBar: true,
                                  context: context,
                                  autoCloseDuration: const Duration(seconds: 5),
                                  animationDuration:
                                      const Duration(milliseconds: 300),
                                  title: const AppText(
                                      text:
                                          "Please select the employment start date first."),
                                );
                              } else {
                                _employmentEndDateCalendar();
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                                customerEmploymentEndDatetext =
                                    customerEmploymentEndDateController.text;
                                if (customerEmploymentEndDateController
                                    .text.isEmpty) {
                                  customerEmploymentEndDatetext = '2015';
                                }
                              });
                            },
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText:
                                      "Please enter your employment end date"),
                            ]),
                          ),
                        ),
                      ],
                    ),
                    buildSizedBoxH(
                        MediaQuery.of(context).size.width <= kScreenWidthMd
                            ? MediaQuery.of(context).size.width / 24
                            : kDefaultPadding * 2),
                    CustomAppTextField(
                      controller: customerEmploymentAddressController,
                      inputFormatters: [LengthLimitingTextInputFormatter(50)],
                      labelText: 'Address',
                      onChanged: (value) {
                        setState(() {
                          customerEmploymentAddresstext =
                              customerEmploymentAddressController.text;
                          if (customerEmploymentAddressController
                              .text.isEmpty) {
                            customerEmploymentAddresstext =
                                'Bachelor of Fine Arts in Graphic Design, GPA: 3.4/4.0';
                          }
                        });
                      },
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "Please enter your employment address"),
                      ]),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomAppTextField(
                              controller: customerEmploymentStartDateController,
                              labelText: 'Start Date',
                              readOnly: true,
                              onTap: _employmentStartDateCalendar,
                              onChanged: (value) {
                                setState(() {
                                  customerEmploymentStartDatetext =
                                      customerEmploymentStartDateController
                                          .text;
                                  if (customerEmploymentStartDateController
                                      .text.isEmpty) {
                                    customerEmploymentStartDatetext = '2012';
                                  }
                                });
                              },
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                    errorText:
                                        "Please enter your employment start date"),
                              ]),
                            ),
                          ),
                          buildSizedBoxW(MediaQuery.of(context).size.width <=
                                  kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 16.69
                              : 46),
                          Expanded(
                            child: CustomAppTextField(
                              controller: customerEmploymentEndDateController,
                              labelText: 'End Date',
                              readOnly: true,
                              onTap: () {
                                if (_employmentStartDateSelected == null) {
                                  toastification.show(
                                    type: ToastificationType.error,
                                    showProgressBar: true,
                                    context: context,
                                    autoCloseDuration:
                                        const Duration(seconds: 5),
                                    animationDuration:
                                        const Duration(milliseconds: 300),
                                    title: const AppText(
                                        text:
                                            "Please select the employment start date first."),
                                  );
                                } else {
                                  _employmentEndDateCalendar();
                                }
                              },
                              onChanged: (value) {
                                setState(() {
                                  customerEmploymentEndDatetext =
                                      customerEmploymentEndDateController.text;
                                  if (customerEmploymentEndDateController
                                      .text.isEmpty) {
                                    customerEmploymentEndDatetext = '2015';
                                  }
                                });
                              },
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                    errorText:
                                        "Please enter your employment end date"),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    buildSizedBoxW(
                        MediaQuery.of(context).size.width <= kScreenWidthMd
                            ? MediaQuery.of(context).size.width / 16.69
                            : 46),
                    Expanded(
                      child: CustomAppTextField(
                        controller: customerEmploymentAddressController,
                        inputFormatters: [LengthLimitingTextInputFormatter(50)],
                        labelText: 'Address',
                        onChanged: (value) {
                          setState(() {
                            customerEmploymentAddresstext =
                                customerEmploymentAddressController.text;
                            if (customerEmploymentAddressController
                                .text.isEmpty) {
                              customerEmploymentAddresstext =
                                  'Bachelor of Fine Arts in Graphic Design, GPA: 3.4/4.0';
                            }
                          });
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText:
                                  "Please enter your employment address"),
                        ]),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _employmentList() {
    return Column(
      children: List.generate(
        customerEmploymentList.length,
        (index) => Card(
          color: AppColors.white_color,
          elevation: 4,
          shadowColor: AppColors.black_color.withOpacity(0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.only(bottom: 10),
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: "Employment ${(index + 1)}",
                      fontsize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              editEmployment(index);
                              setState(() {
                                isEmploymentEdit = true;
                              });
                            },
                            child: Image.asset("${AppImages.ic}ic_edit.png",
                                height: 20, width: 20),
                          ),
                        ),
                        buildSizedBoxW(kDefaultPadding * 1.5),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              deleteEmployment(index);
                            },
                            child: Image.asset("${AppImages.ic}ic_delete.png",
                                height: 20, width: 20),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                buildSizedBoxH(kTextPadding),
                const Divider(),
                buildSizedBoxH(kTextPadding),
                _buildDetailsListCard("Date",
                    "${customerEmploymentList[index].startDate} - ${customerEmploymentList[index].endDate}"),
                _buildDetailsListCard(
                    "Job Title", customerEmploymentList[index].jobTitle),
                _buildDetailsListCard(
                    "Company name ", customerEmploymentList[index].companyName),
                _buildDetailsListCard(
                    "Address", customerEmploymentList[index].address),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSkill() {
    return Column(
      children: [
        id == "1" || id == "7"
            ? FormBuilder(
                key: _professionalAndPersonalSkillFormKey,
                child: Row(
                  children: [
                    Expanded(
                      child: CustomAppTextField(
                        controller: customerProfessionalSkillController,
                        inputFormatters: [LengthLimitingTextInputFormatter(25)],
                        labelText: 'Professional Skill',
                        onChanged: (value) {
                          setState(() {
                            customerProfessionalSkilltext =
                                customerProfessionalSkillController.text;
                            if (customerProfessionalSkillController
                                .text.isEmpty) {
                              customerProfessionalSkilltext = 'Figma';
                            }
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty &&
                              customerPersonalSkillController.text.isEmpty) {
                            return 'Please enter your professional skill';
                          }
                          return null;
                        },
                      ),
                    ),
                    buildSizedBoxW(
                        MediaQuery.of(context).size.width <= kScreenWidthMd
                            ? MediaQuery.of(context).size.width / 16.69
                            : 46),
                    Expanded(
                      child: CustomAppTextField(
                        controller: customerPersonalSkillController,
                        inputFormatters: [LengthLimitingTextInputFormatter(25)],
                        labelText: 'Personal Skill',
                        onChanged: (value) {
                          setState(() {
                            customerPersonalSkilltext =
                                customerPersonalSkillController.text;
                            if (customerPersonalSkillController.text.isEmpty) {
                              customerPersonalSkilltext = 'Figma';
                            }
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty &&
                              customerProfessionalSkillController
                                  .text.isEmpty) {
                            return 'Please enter your personal skill';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              )
            : FormBuilder(
                key: _skillAndLevelFormKey,
                child: Row(
                  children: [
                    Expanded(
                      child: CustomAppTextField(
                        controller: customerSkillController,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(skillTextLength)
                        ],
                        labelText: 'Skill',
                        onChanged: (value) {
                          setState(() {
                            customerSkilltext = customerSkillController.text;
                            if (customerSkillController.text.isEmpty) {
                              customerSkilltext = 'Figma';
                            }
                          });
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: "Please enter your skill"),
                        ]),
                      ),
                    ),
                    buildSizedBoxW(
                        MediaQuery.of(context).size.width <= kScreenWidthMd
                            ? MediaQuery.of(context).size.width / 16.69
                            : 46),
                    Expanded(child: _buildSkillLevelSlider()),
                    SizedBox(
                      width: 95,
                      child: Center(
                        child: AppText(
                            text: customerSkillLevel == 20
                                ? "Beginner"
                                : customerSkillLevel == 40
                                    ? "Moderate"
                                    : customerSkillLevel == 60
                                        ? "Good"
                                        : customerSkillLevel == 80
                                            ? "Very good"
                                            : customerSkillLevel == 100
                                                ? "Expert"
                                                : "Make a choice"),
                      ),
                    ),
                  ],
                ),
              ),
      ],
    );
  }

  SfSliderTheme _buildSkillLevelSlider() {
    return SfSliderTheme(
      data: SfSliderThemeData(tooltipBackgroundColor: AppColors.primaryColor),
      child: SfSlider(
        activeColor: AppColors.primaryColor,
        inactiveColor: AppColors.primaryColor.withOpacity(0.2),
        max: 100,
        min: 0,
        interval: 20,
        stepSize: 20,
        showDividers: true,
        value: customerSkillLevel,
        onChanged: (dynamic values) {
          setState(() {
            customerSkillLevel = values as double;
          });
        },
        enableTooltip: true,
        numberFormat: NumberFormat('#'),
      ),
    );
  }

  Widget _buildProfessionalAndPersonalSkillList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Professional Skills List
        customerProfessionalSkillList.isEmpty
            ? const SizedBox.shrink()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: "Professional Skills",
                    fontsize:
                        MediaQuery.of(context).size.width <= kScreenWidthMd
                            ? MediaQuery.of(context).size.width / 48
                            : 16,
                  ),
                  buildSizedBoxH(kDefaultPadding),
                  Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: customerProfessionalSkillList.map((skill) {
                      int index = customerProfessionalSkillList.indexOf(skill);
                      return _buildProfessionalAndPersonalSkillContainer(
                          skill.professionalSkill, index, true);
                    }).toList(),
                  ),
                ],
              ),

        ///

        buildSizedBoxH(kDefaultPadding * 2),

        /// Personal Skills
        customerPersonalSkillList.isEmpty
            ? const SizedBox.shrink()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: "Personal Skills",
                    fontsize:
                        MediaQuery.of(context).size.width <= kScreenWidthMd
                            ? MediaQuery.of(context).size.width / 48
                            : 16,
                  ),
                  buildSizedBoxH(kDefaultPadding),
                  Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: customerPersonalSkillList.map((skill) {
                      int index = customerPersonalSkillList.indexOf(skill);
                      return _buildProfessionalAndPersonalSkillContainer(
                          skill.personalSkill, index, false);
                    }).toList(),
                  ),
                ],
              )

        ///
      ],
    );
  }

  Widget _buildProfessionalAndPersonalSkillContainer(
      String skill, int index, bool isProfessional) {
    return Card(
      color: AppColors.white_color,
      elevation: 4,
      shadowColor: AppColors.black_color.withOpacity(0.6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: kDefaultPadding),
        child: Wrap(
          children: [
            AppText(
              text: skill,
              overflow: TextOverflow.ellipsis,
            ),
            buildSizedBoxW(kDefaultPadding * 2),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isProfessional) {
                          customerProfessionalSkillController.text =
                              customerProfessionalSkillList[index]
                                  .professionalSkill;
                          _editingIndexProfessional = index;
                          isProfessionalSkillEdit = true;
                        } else {
                          customerPersonalSkillController.text =
                              customerPersonalSkillList[index].personalSkill;
                          _editingIndexPersonal = index;
                          isPersonalSkillEdit = true;
                        }
                      });
                    },
                    child: Image.asset("${AppImages.ic}ic_edit.png",
                        height: 20, width: 20),
                  ),
                ),
                buildSizedBoxW(kDefaultPadding),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isProfessional) {
                          customerProfessionalSkillList.removeAt(index);
                        } else {
                          customerPersonalSkillList.removeAt(index);
                        }
                      });
                    },
                    child: Image.asset("${AppImages.ic}ic_delete.png",
                        height: 20, width: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillAndLevelList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customerSkillList.isEmpty
            ? const SizedBox.shrink()
            : Wrap(
                spacing: kDefaultPadding,
                runSpacing: kDefaultPadding,
                children: customerSkillList.map((skill) {
                  int index = customerSkillList.indexOf(skill);
                  return _buildSkillAndLevelContainer(
                      skill.skill, skill.level, index);
                }).toList(),
              ),
      ],
    );
  }

  Widget _buildSkillAndLevelContainer(String skill, double level, int index) {
    return Card(
      color: AppColors.white_color,
      elevation: 4,
      shadowColor: AppColors.black_color.withOpacity(0.6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: kDefaultPadding),
        child: Wrap(
          spacing: kDefaultPadding,
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            AppText(
              text: skill,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildSkillLevelSliderContainer(customerSkillList[index].level),
                SizedBox(
                  width: 95,
                  child: Center(
                    child: AppText(
                        text: customerSkillList[index].level == 20
                            ? "Beginner"
                            : customerSkillList[index].level == 40
                                ? "Moderate"
                                : customerSkillList[index].level == 60
                                    ? "Good"
                                    : customerSkillList[index].level == 80
                                        ? "Very good"
                                        : customerSkillList[index].level == 100
                                            ? "Expert"
                                            : "Make a choice"),
                  ),
                ),
                buildSizedBoxW(kDefaultPadding * 1.5),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MediaQuery.of(context).size.width <= kScreenWidthSm
                  ? MainAxisSize.max
                  : MainAxisSize.min,
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          customerSkillController.text =
                              customerSkillList[index].skill;
                          customerSkillLevel = customerSkillList[index].level;
                          editingSkillIndex = index;
                          isSkillEdit = true;
                        });
                      },
                      child: Image.asset("${AppImages.ic}ic_edit.png",
                          height: 20, width: 20)),
                ),
                buildSizedBoxW(kDefaultPadding * 1.5),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          customerSkillList.removeAt(index);
                        });
                      },
                      child: Image.asset("${AppImages.ic}ic_delete.png",
                          height: 20, width: 20)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SfSliderTheme _buildSkillLevelSliderContainer(double level) {
    return SfSliderTheme(
      data: SfSliderThemeData(tooltipBackgroundColor: AppColors.primaryColor),
      child: SfSlider(
        activeColor: AppColors.primaryColor,
        inactiveColor: AppColors.primaryColor.withOpacity(0.2),
        max: 100,
        min: 0,
        interval: 20,
        stepSize: 20,
        showDividers: true,
        value: level,
        onChanged: (dynamic values) {},
        enableTooltip: true,
        numberFormat: NumberFormat('#'),
      ),
    );
  }
}

class CatchImageNetwork extends StatefulWidget {
  final String networkImageURL;
  const CatchImageNetwork({super.key, required this.networkImageURL});

  @override
  State<CatchImageNetwork> createState() => _CatchImageNetworkState();
}

class _CatchImageNetworkState extends State<CatchImageNetwork> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.networkImageURL,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => Image.asset(
        "assets/images/png/img_profile.png",
        fit: BoxFit.cover,
      ),
    );
  }
}
