import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/setting_model.dart';
import 'package:flutter_application_1/screen/settings/set_holiday.dart';
import 'package:flutter_application_1/service/employee.dart';

import '../../service/setting_service.dart';
import '../../utilities/theme.dart';
import 'company/company_profile.dart';
import 'set_worktype.dart';
import 'update_employee.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  //TODO get previous setting otherwise show default
  //TODO post for any changes
  bool _is8hr = true;
  bool _isRemoveData = false;
  bool _setMaxOffDay = false;
  bool _isLoading = true;
  final _formkey = GlobalKey<FormState>();
  TextEditingController _customWorkHr = TextEditingController();
  TextEditingController _setMaxOffdaytext = TextEditingController();
  TextEditingController _customRemovalDataday = TextEditingController();
  int? settingId;
  final List<bool> _placeHolderBool = [false, false, false];
  final List<String?> _placeHolderStr = ['', ''];
  int? _branchId, _currentBranch;

  @override
  void initState() {
    super.initState();
    _retrieveUsersData();
    _retrieveSetting();
  }

  @override
  void dispose() {
    _customWorkHr.dispose();
    super.dispose();
  }

  Future<void> _retrieveUsersData() async {
    final temp = await EmployeeService().retrieveEmployeeItem(1);
    setState(() {
      _currentBranch = temp!.branchId;
    });
  }

  Future<void> _retrieveSetting() async {
    int? tempCompId, tempBranchId;
    if (_currentBranch != null) tempBranchId = _currentBranch;
    final temp =
        await SettingService().retrieveSetting(tempCompId, tempBranchId);
    setState(() {
      _is8hr = _placeHolderBool[0] = temp.is8hr ?? false;
      _isRemoveData = _placeHolderBool[1] = temp.is90dayDataRemoval ?? false;
      _setMaxOffDay = _placeHolderBool[2] = temp.hasSetMaxOffday ?? false;
      _customWorkHr = _is8hr==false
          ? TextEditingController(text: temp.customWorkHour.toString())
          : TextEditingController();
      _setMaxOffdaytext = _setMaxOffDay==true
          ? TextEditingController(text: temp.maxOffdayNum.toString())
          : TextEditingController();
      _customRemovalDataday = _isRemoveData==false
          ? TextEditingController(text: temp.customDataRemovalDay.toString())
          : TextEditingController();
      _placeHolderStr[0] = !_is8hr ? temp.customWorkHour.toString() : '';
      _placeHolderStr[1] = !_setMaxOffDay ? temp.maxOffdayNum.toString() : '';
      _branchId = temp.branchId;
      if (_branchId == _currentBranch) {
        settingId = temp.id;
      }
      _isLoading = false;
    });
  }

  Future<void> _updateEmployerSetting() async {
    if (_formkey.currentState!.validate()) {
      SettingModels temp = SettingModels(
        customWorkHour: _customWorkHr.text.isNotEmpty
            ? int.parse(_customWorkHr.text)
            : null,
        hasSetMaxOffday: _setMaxOffDay,
        branchId: _currentBranch,
        companyId: 1,
        is8hr: _is8hr,
        maxOffdayNum: _setMaxOffdaytext.text.isNotEmpty
            ? int.parse(_setMaxOffdaytext.text)
            : null,
        customDataRemovalDay: _customRemovalDataday.text.isNotEmpty
            ? int.parse(_customRemovalDataday.text)
            : null,
        is90dayDataRemoval: _isRemoveData,
      );
      if (settingId != null) {
        await SettingService().updateSetting(settingId!, temp.toJson());
      } else {
        await SettingService().createSetting(temp.toJson());
      }
      await _retrieveSetting();
    }
  }

  void navigateToNext(int index) {
    List<Widget> temp = [
      const SetHoliday(),
      const CompanyProfile(),
      const UpdateEmployee(),
      const SetWorkType(),
    ];
    try {
      if (temp[index] == Container()) {
      } else {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 400),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final curvedAnimation = CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut, // Add your desired curve here
              );
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(curvedAnimation),
                child: child,
              );
            },
            pageBuilder: (context, animation, secondaryAnimation) =>
                temp[index],
          ),
        );
      }
    } catch (e) {
      // TODO
      debugPrint('error here');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height - 100;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: ThemeConstant.blackTextBold18,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: SizedBox(
            height: height,
            width: width,
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(10),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      ListTile(
                        title: Text(
                          'Set Holiday',
                          style: ThemeConstant.blackTextBold16,
                        ),
                        onTap: () {
                          navigateToNext(0);
                        },
                      ),
                      ListTile(
                        title: Text(
                          'Update Company Profile',
                          style: ThemeConstant.blackTextBold16,
                        ),
                        onTap: () {
                          navigateToNext(1);
                        },
                      ),
                      ListTile(
                        title: Text(
                          'Update Employee list',
                          style: ThemeConstant.blackTextBold16,
                        ),
                        onTap: () {
                          navigateToNext(2);
                        },
                      ),
                      ListTile(
                        title: Text(
                          'Update Work Type',
                          style: ThemeConstant.blackTextBold16,
                        ),
                        onTap: () {
                          navigateToNext(3);
                        },
                      ),
                      ListTile(
                        title: Text(
                          'Remove data from database within 90 days',
                          style: ThemeConstant.blackTextBold16,
                        ),
                        trailing: Switch(
                          value: _isRemoveData,
                          onChanged: ((value) {
                            setState(() {
                              _isRemoveData = value;
                            });
                          }),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Set maximum day of Off-Day',
                          style: ThemeConstant.blackTextBold16,
                        ),
                        trailing: Switch(
                          value: _setMaxOffDay,
                          onChanged: ((value) {
                            setState(() {
                              _setMaxOffDay = value;
                            });
                          }),
                        ),
                        onTap: () {
                          setState(() {
                            _setMaxOffDay = !_setMaxOffDay;
                          });
                        },
                      ),
                      _setMaxOffDay
                          ? Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ThemeConstant.trcPink,
                                  ),
                                  child: TextFormField(
                                    controller: _setMaxOffdaytext,
                                    decoration: InputDecoration(
                                      hintStyle: ThemeConstant.blackText14,
                                      hintText: 'Enter maximum Off-Day',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      ListTile(
                        title: Text(
                          'Use Default work hour (8 Hour)',
                          style: ThemeConstant.blackTextBold16,
                        ),
                        trailing: Switch(
                          value: _is8hr,
                          onChanged: ((value) {
                            setState(() {
                              _is8hr = value;
                            });
                          }),
                        ),
                        onTap: () {
                          setState(() {
                            _is8hr = !_is8hr;
                          });
                        },
                      ),
                      _is8hr
                          ? const SizedBox()
                          : Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ThemeConstant.trcPink,
                                  ),
                                  child: TextFormField(
                                    controller: _customWorkHr,
                                    decoration: InputDecoration(
                                      hintStyle: ThemeConstant.blackText14,
                                      hintText: 'Enter desired work hour',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
          ),
        ),
      ),
      bottomNavigationBar: ((_customWorkHr.text.isNotEmpty &&
                  _customWorkHr.text != _placeHolderStr[0]) ||
              _is8hr != _placeHolderBool[0] ||
              _isRemoveData != _placeHolderBool[1] ||
              _setMaxOffDay != _placeHolderBool[2] ||
              (_setMaxOffdaytext.text.isNotEmpty &&
                      _setMaxOffdaytext.text != _placeHolderStr[1]) &&
                  !_isLoading)
          ? AnimatedContainer(
              duration: const Duration(milliseconds: 5800),
              curve: Curves.fastOutSlowIn,
              width: width,
              height: 90,
              child: Center(
                child: SizedBox(
                  width: 250,
                  height: 60,
                  child: Card(
                    elevation: 25,
                    child: OutlinedButton(
                      onPressed: () {
                        _updateEmployerSetting();
                      },
                      child: Center(
                        child: Text(
                          'Update',
                          style: ThemeConstant.blackTextBold18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}
