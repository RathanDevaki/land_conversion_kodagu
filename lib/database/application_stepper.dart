import 'dart:developer';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import 'package:flutter_switch/flutter_switch.dart';
import 'package:land_conversion_kodagu/testing/temp/custom_iconbutton.dart';
import 'package:land_conversion_kodagu/testing/temp/upl_node.dart';
import 'package:provider/provider.dart';

import '../models/application_model.dart';
import '../providers/application_provider.dart';
import '../testing/temp/custom_dropdown.dart';
import '../utilities/constants.dart';

class StepperDemo extends StatefulWidget {
  @override
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<StepperDemo> {
  ProjectProvider projectProvider = ProjectProvider();
  List<PlatformFile>? _paths;
  late List<int> bytes;
  //late Uint8List uint = Uint8List(100000);

  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;
  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _spouse = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _surveynumber = TextEditingController();
  final TextEditingController _tot_acre = TextEditingController();
  final TextEditingController _tot_cent = TextEditingController();
  final TextEditingController _tot_fcent = TextEditingController();
  final TextEditingController _con_acre = TextEditingController();
  final TextEditingController _con_cent = TextEditingController();
  final TextEditingController _con_fcent = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  List<TextEditingController> _controllersList = [];

//Const variables
  List<String> talukEn = ['Virajpet', 'Somwarpet', 'Madikeri'];
  List<String> hobli__ = [
    'Balele',
    'Virajpet',
    'Kanoor',
    'Murnadu',
    'Bhethri',
    'Kushalanagar'
  ];
  List<String> village__ = ['Karike', 'Bhagamandla', 'Balugodu', 'Shettigeri'];

  List<String> main_objective_ka = ['ವಸತಿ', 'ವಾಣಿಜ್ಯ', 'ಕೈಗಾರಿಕೆ', 'ಗಣಿಗಾರಿಕೆ'];
  List<String> main_objective_en = [
    'Housing',
    'Commercial',
    'Industries',
    'Mining'
  ];
  bool _showDialog = false;
  bool _showDialog1 = false;

  String? selectedSub;
  String? selectedMain;

  var uint2, uint2_;

  String? selectedTaluk;
  String? selectedHobli;
  String? selectedVillage;

  List<String> housing = ['ವೈಯಕ್ತಿಕ', 'ಲೆಔಟ್', 'ಅಪಾರ್ಟ್ಮೆಂಟ್', 'ಇತರೆ'];
  List<String> commercial = ['Resort', 'Hotel'];
  List<String> industries = ['Cement Factory', 'Granite', 'Others'];

//style
  static const _textStyle = TextStyle(
    color: Color.fromARGB(255, 44, 48, 51),
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    shadows: [
      Shadow(
        color: Color.fromARGB(115, 0, 0, 0),
        blurRadius: 4.0,
        offset: Offset(0.0, 2.0),
      ),
    ],
  );

  @override
  void initState() {
    super.initState();
    _controllersList = [
      _fullname,
      _spouse,
      _address,
      _mobile,
      _surveynumber,
    ];
  }

  @override
  void dispose() {
    _fullname.dispose();
    _spouse.dispose();
    _address.dispose();
    _mobile.dispose();
    _surveynumber.dispose();
    super.dispose();
  }

  void _printValues() {
    for (final controller in _controllersList) {
      print(controller.text);
    }
  }

  Widget _buildText(String text) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText,
      String? Function(String?) validator,
      {InputDecoration? decoration, var maxLines}) {
    return TextFormField(
      controller: controller,
      decoration: decoration ??
          InputDecoration(
            labelText: hintText,
            labelStyle: const TextStyle(fontSize: 14),
            fillColor: Colors.amber,
          ),
      validator: validator,
      maxLines: maxLines ?? 1,
    );
  }

  Widget controlsBuilder(context, details) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        ElevatedButton.icon(
          icon: const Icon(Icons.arrow_back),
          label: const Text('Previous'),
          onPressed: () {
            cancel();
            // code to add item
          },
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.arrow_forward),
          label: (_currentStep == 2) ? Text('Finish') : Text('Next'),
          onPressed: () {
            continued();
            // code to add item
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 1.0;
    ApplicationProvider applicationProvider =
        Provider.of<ApplicationProvider>(context);

    void _showMyDialog(int sel) {
      setState(() {
        if (sel == 1) {
          _showDialog = true;
        } else if (sel == 2) {
          _showDialog1 = true;
        }
      });
    }

    void _hideMyDialog(int sel) {
      setState(() {
        if (sel == 1) {
          _showDialog = false;
          projectProvider.sizeflag = 0;
        } else if (sel == 2) {
          _showDialog1 = false;
          projectProvider.sizeflag1 = 0;
        }
      });
    }

    return Scaffold(
      body: Column(
        children: [
          FittedBox(
            child: Row(
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  width: 120,
                  height: 120,
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  'Application for NOC for land conversion ',
                  style: headingTextStyle,
                ),
                SizedBox(
                  width: width * 0.04,
                ),
                FlutterSwitch(
                  width: 110.0,
                  height: 35.0,
                  valueFontSize: 20.0,

                  ///toggleSize: 45.0,
                  value: status,
                  activeColor: primaryColor,
                  borderRadius: 4.0,
                  padding: 4.0,
                  activeText: 'ಕನ್ನಡ',
                  inactiveText: 'English',
                  showOnOff: true,
                  onToggle: (val) {
                    setState(() {
                      status = val;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 900),
                child: Stepper(
                  type: stepperType,
                  physics: const ScrollPhysics(),
                  currentStep: _currentStep,
                  onStepTapped: (step) => tapped(step),
                  onStepContinue: continued,
                  onStepCancel: cancel,
                  controlsBuilder: controlsBuilder,
                  steps: <Step>[
                    Step(
                      title: const Text('Basic Info'),
                      content: Padding(
                        padding: defaultPadding,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const Text('Basic Information',
                                  style: _textStyle),
                              const Divider(
                                color: Colors.black54,
                                thickness: 1,
                              ),
                              _buildTextField(_fullname, 'Your Full name',
                                  (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter name';
                                }
                                return null;
                              }),
                              const SizedBox(height: 16.0),
                              _buildTextField(
                                _spouse,
                                'Father/Spouse name',
                                (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter spouse/father name';
                                  }
                                  return null;
                                },
                                maxLines: 1,
                              ),
                              const SizedBox(height: 16.0),
                              _buildTextField(
                                _address,
                                'Complete Address',
                                (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter Address';
                                  }
                                  return null;
                                },
                                maxLines: 2,
                              ),
                              const SizedBox(height: 16.0),
                              _buildTextField(
                                _mobile,
                                'Mobile Number',
                                (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter Mobile Number';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16.0),
                              CustomDropdown(
                                items: talukEn,
                                hint: 'Select Taluk',
                                onChanged: (value) {
                                  setState(() {
                                    selectedTaluk = value;
                                  });
                                  print('Selected taluk 2: $value');
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please Select Taluk';
                                  }
                                  return null;
                                },
                                value: selectedTaluk,
                              ),
                              const SizedBox(height: 16.0),
                              CustomDropdown(
                                value: selectedHobli,
                                items: hobli__,
                                hint: 'Select Hobli',
                                onChanged: (value) {
                                  setState(() {
                                    selectedHobli = value;
                                  });
                                  print('Selected hobli : $value');
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please Select Hobli';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16.0),
                              CustomDropdown(
                                items: village__,
                                hint: 'Select village',
                                onChanged: (value) {
                                  setState(() {
                                    selectedVillage = value;
                                  });
                                  print('Selected hobli : $value');
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please Select village';
                                  }
                                  return null;
                                },
                                value: selectedVillage,
                              ),
                              const SizedBox(height: 16.0),
                            ],
                          ),
                        ),
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 0
                          ? StepState.complete
                          : StepState.disabled,
                    ),

                    ///     - - - - - - - - - -= - - - ----Step Property
                    Step(
                      title: const Text('Property Details'),
                      content: Form(
                        key: _formKey2,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Text('Property Information',
                                style: _textStyle),
                            divider_grey,
                            const SizedBox(
                              height: 8,
                            ),
                            _buildText('Survey Number :'),
                            _buildTextField(_surveynumber, 'Ex:1/*/12',
                                (value) {
                              if (value!.isEmpty) {
                                return 'Please enter survey number';
                              }
                              return null;
                            }),
                            const SizedBox(
                              height: 8.0,
                            ),
                            _buildText('Total Land Area :'),
                            Row(
                              children: [
                                Expanded(
                                    child: _buildTextField(_tot_acre, 'Acre',
                                        (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter details';
                                  }
                                })),
                                const SizedBox(width: 8),
                                Expanded(
                                    child: _buildTextField(_tot_cent, 'Cent',
                                        (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter details';
                                  }
                                })),
                                const SizedBox(width: 8),
                                Expanded(
                                    child: _buildTextField(_tot_fcent, 'F-Cent',
                                        (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter details';
                                  }
                                })),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            _buildText('Area sought for Land Conversion :'),
                            Row(
                              children: [
                                Expanded(
                                    child: _buildTextField(_con_acre, 'Acre',
                                        (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter details';
                                  }
                                })),
                                const SizedBox(width: 8),
                                Expanded(
                                    child: _buildTextField(_con_cent, 'Cent',
                                        (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter details';
                                  }
                                })),
                                SizedBox(width: 8),
                                Expanded(
                                  child: _buildTextField(
                                    _con_fcent,
                                    'F-Cent',
                                    (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter details';
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(),
                            const Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: Text('Purpose of Land Conversion',
                                  style: _textStyle),
                            ),
                            divider_grey,
                            const SizedBox(height: 16.0),
                            CustomDropdown(
                              value: selectedMain,
                              hint: 'Select Main Objective',
                              onChanged: (value) {
                                setState(() {
                                  selectedMain = value;
                                  selectedSub = null;
                                  applicationProvider.addMain('-0-0-');

                                  log('Provider=> ${applicationProvider.selectedMain}');
                                });
                              },
                              items: main_objective_en,
                              validator: (value) {
                                if (value == null) {
                                  return 'Please Select Main Objective';
                                }
                                return null;
                              },
                            ),

                            //Sub objective
                            if (selectedMain != null)
                              CustomDropdown(
                                value: selectedSub,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedSub = value;
                                  });
                                },
                                items: (selectedMain == 'Housing')
                                    ? housing
                                    : (selectedMain == 'Commercial')
                                        ? commercial
                                        : (selectedMain == 'Industries')
                                            ? industries
                                            : [],
                                hint: 'ಉಪ ಉದ್ಧೇಶ ಆಯ್ಕೆ ಮಾಡಿ',
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please Select Hobli';
                                  }
                                  return null;
                                },
                              ),
                            const SizedBox(height: 16.0),
                          ],
                        ),
                      ),
                      isActive: _currentStep >= 1,
                      state: _currentStep >= 1
                          ? StepState.complete
                          : StepState.disabled,
                    ),

//Step 3 Media Upload ----- - - - - - - - - - - - - - - - -
                    Step(
                      title: const Text('Documents'),
                      content: Column(
                        children: <Widget>[
                          const Text('Upload Required Documents',
                              style: _textStyle),
                          divider_grey,
                          Stack(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      pickFiles(1);
                                      // do something when the button is pressed
                                    },
                                    icon: Icon(Icons.upload),
                                    label: Text('Upload RTC'),
                                    style: ElevatedButton.styleFrom(
                                      side: const BorderSide(
                                          width: 1,
                                          color: Colors
                                              .grey), // optional: add a border
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            16.0), // optional: add rounded corners
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0,
                                          vertical:
                                              16.0), // optional: adjust padding
                                    ),
                                  ),
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      (projectProvider.sizeflag == 1 &&
                                              projectProvider.uintflag == 1)
                                          ? Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Consumer<ProjectProvider>(
                                                  builder: (context,
                                                      projectProvider1, _) {
                                                uint2 = projectProvider.uint;

                                                return Container(
                                                  height: 80.00,
                                                  width: 160.00,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      8.00,
                                                    ),
                                                    image: DecorationImage(
                                                        image:
                                                            MemoryImage(uint2)),
                                                  ),
                                                );
                                              }),
                                            )
                                          : Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Container(
                                                height: 80.00,
                                                width: 160.00,
                                                // ignore: sort_child_properties_last
                                                child: const Center(
                                                    child: Text(
                                                  'No Image Choosen.!',
                                                  style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                )),
                                                decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 189, 189, 189),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    8.00,
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ],
                                  )
                                ],
                              ),
                              //Alert
                              (_showDialog)
                                  ? AlertDialog(
                                      title: const Text('Warning..!'),
                                      content: const Text(
                                        'Image size is larger than 500KB.!',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => _hideMyDialog(1),
                                          child: Text('OK'),
                                        ),
                                      ],
                                    )
                                  : Container(),
                            ],
                          ),
                          divider_grey,

//---------Akar Bandh
                          Stack(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      pickFiles(2);
                                      // do something when the button is pressed
                                    },
                                    icon: Icon(Icons.upload),
                                    label: Text('Upload Akar Bandh'),
                                    style: ElevatedButton.styleFrom(
                                      side: const BorderSide(
                                          width: 1,
                                          color: Colors
                                              .grey), // optional: add a border
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            16.0), // optional: add rounded corners
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0,
                                          vertical:
                                              16.0), // optional: adjust padding
                                    ),
                                  ),
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      (projectProvider.sizeflag1 == 1 &&
                                              projectProvider.uintflag1 == 1)
                                          ? Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Consumer<ProjectProvider>(
                                                  builder: (context,
                                                      projectProvider1, _) {
                                                uint2_ = projectProvider.uint1;

                                                return Container(
                                                  height: 80.00,
                                                  width: 160.00,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      8.00,
                                                    ),
                                                    image: DecorationImage(
                                                        image: MemoryImage(
                                                            uint2_)),
                                                  ),
                                                );
                                              }),
                                            )
                                          : Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Container(
                                                height: 80.00,
                                                width: 160.00,
                                                // ignore: sort_child_properties_last
                                                child: const Center(
                                                    child: Text(
                                                  'No Image Choosen.!',
                                                  style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                )),
                                                decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 189, 189, 189),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    8.00,
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ],
                                  )
                                ],
                              ),
                              //Alert
                              (_showDialog1)
                                  ? AlertDialog(
                                      title: const Text('Warning..!'),
                                      content: const Text(
                                        'Image size is larger than 500KB.!',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => _hideMyDialog(2),
                                          child: Text('OK'),
                                        ),
                                      ],
                                    )
                                  : Container(),
                            ],
                          ),
                        ],
                      ),
                      isActive: _currentStep >= 2,
                      state: _currentStep >= 2
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.list),
      //   onPressed: switchStepsType,
      // ),
    );
  }

  Widget buildTextField(String hintText) {
    TextEditingController controller = TextEditingController();
    return TextField(
      controller: controller,
      onChanged: (v) {
        log(v);
      },
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }

  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step) {
    setState(() {
      log(step.toString());
      _currentStep = step;
    });
  }

  continued() {
    if (_currentStep == 0) {
      //if (_formKey.currentState!.validate()) {
      _currentStep < 2 ? setState(() => _currentStep += 1) : null;
      _printValues();
      //}
    } else if (_currentStep == 1) {
      // if (_formKey2.currentState!.validate()) {
      _currentStep < 2 ? setState(() => _currentStep += 1) : null;
      // log(_fullname.text);
      //log('{$_fullname.text ,$_spouse.text , $_address.text $_mobile.text, $_surveynumber.text, $selectedTaluk.text ,$selectedHobli.text,vil= $selectedVillage.text sur= $_surveynumber.text,tot= $_tot_acre.text $_tot_cent.text ,$_tot_fcent.text}');

      // }
    } else if (_currentStep == 2) {
      if (projectProvider.uintflag == 1) {
        log(projectProvider.uint1.toString());
        if (projectProvider.uint1[0] == 0) {
          print(projectProvider.uint1);
        }
        ApplicationProvider provider = ApplicationProvider();
//--- Temp Variables
        String fullname,
            spouse,
            address,
            mobile,
            taluk,
            hobli,
            village,
            surveyNumber,
            tot_cent,
            tot_fcent,
            tot_acre,
            con_acre,
            con_cent,
            con_fcent,
            mainObj,
            subObj;
//---Assignment from Controller.
        fullname = _fullname.text;
        spouse = _spouse.text;
        address = _address.text;
        mobile = _mobile.text;
        taluk = selectedTaluk.toString();
        hobli = selectedHobli.toString();
        village = selectedVillage.toString();
        tot_acre = _tot_acre.text;
        tot_cent = _tot_cent.text;
        tot_fcent = _tot_fcent.text;
        con_acre = _con_acre.text;
        con_cent = _con_cent.text;
        con_fcent = _con_fcent.text;

        mainObj = selectedMain.toString();
        subObj = selectedSub.toString();

        ApplicationModel _apm = ApplicationModel(
          fullname: fullname,
          spouse: spouse,
          address: address,
          mobile: mobile,
          selectedTaluk: selectedTaluk.toString(),
          selectedHobli: selectedHobli.toString(),
          selectedVilage: selectedVillage.toString(),
          surveyNumber: _surveynumber.toString(),
          tot_acre: tot_acre,
          tot_cent: tot_cent,
          tot_fcent: tot_fcent,
          con_acre: con_acre,
          con_cent: con_cent,
          con_fcent: con_fcent,
          main_obj: mainObj,
          sub_obj: subObj,
          rtc: uint2,
          akarBandh: uint2_,
        );

        provider.addApplication(_apm);
      }
    }
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  pickFiles(int selection) async {
    // * Pick a File
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowCompression: true,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: ['jpeg', 'png', 'jpg']);

    if (result != null) {
      // * cast it to bytes
      bytes = result.files.single.bytes!.cast();
      //setState(() {});

      // * Get its name, will use it later.
      var name = result.files.single.name;
      int fileSizeInBytes = bytes.length;
      double fileSizeInKB = fileSizeInBytes / 1024;

      // Check if the file size is less than 500KB

      setState(() {
        if (fileSizeInKB <= 500) {
          // log(fileSizeInKB.toString());

          //projectProvider.sizeflag = 1;

          if (selection == 1) {
            uint2 = Uint8List.fromList(bytes);
            projectProvider.sizeflag = 1;
            projectProvider.setUint(uint2, 1, 1);
          }
          if (selection == 2) {
            uint2 = Uint8List.fromList(bytes);
            projectProvider.sizeflag1 = 1;
            projectProvider.setUint1(uint2, 1, 1);
          }
        } else {
          //projectProvider.sizeflag = 0;
          if (selection == 1) {
            _showDialog = true;
            projectProvider.sizeflag = 2;
          } else if (selection == 2) {
            _showDialog1 = true;
            projectProvider.sizeflag1 = 2;
          }
        }
      });
      projectProvider.uploadImage(bytes, name, 1);
    }
  }
}

class ProjectProvider extends ChangeNotifier {
  // * constructor
  ProjectProvider() : _dio = Dio();
  int demo = 1;
  int uintflag = 0;
  int uintflag1 = 0;

//0->Nothing , 1-> OK , 2-> Exception
  int sizeflag = 0;
  int sizeflag1 = 0;

  int respFlag = 0;
  int respFlag1 = 0;

  late Response _response;
  late final Dio _dio;
  late Uint8List uint = Uint8List.fromList([0]);
  late Uint8List uint1 = Uint8List.fromList([0]);
  // * rest api
  final _baseUrl = "http://192.168.1.101:3000";

  setUint(Uint8List ulist, int uintFlag, int sizeFlag) {
    uint = ulist;
    sizeflag = sizeFlag;
    uintflag = uintFlag;
    notifyListeners();
    log(uintflag.toString());
    log('called $uint');
  }

  setUint1(Uint8List ulist, int uintFlag, int sizeFlag) {
    uint1 = ulist;
    sizeflag1 = sizeFlag;
    uintflag1 = uintFlag;
    notifyListeners();
    log(uintflag1.toString());
    log('called $uint1');
  }

  Uint8List get getUint => uint;
  Uint8List get getUint1 => uint1;

  uploadImage(List<int> bytes, String name, int selection) async {
    String extension = name.split(".").last;

    var formData = FormData.fromMap({
      "file": MultipartFile.fromBytes(
        bytes,
        filename: name,
        contentType: MediaType("File", extension),
      ),
    });

    try {
      if (sizeflag == 1 || sizeflag1 == 1) {
        _response = await _dio.post("$_baseUrl/upload", data: formData);
        notifyListeners();
      }
      if (_response.statusCode == 200) {
        (selection == 1) ? respFlag = 1 : respFlag1 = 1;
        notifyListeners();
      } else {
        (selection == 1) ? respFlag = 0 : respFlag1 = 0;

        notifyListeners();
      }
    } catch (error) {
      // Handle error response here
      if (error is DioError) {
        // Handle DioError
        if (error.response != null) {
          // Handle DioError with response
          print(error.response!.data);
          print(error.response!.headers);
        } else {
          // Handle DioError without response
          print(error.message);
        }
      } else {
        // Handle other errors
        print(error.toString());
      }
    }
  }
}
