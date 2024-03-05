import 'dart:async';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/input.dart';

import '../../dashboard/sub_dashboard.dart';
import '../../model/mockdata/mockUser.dart';
import '../../model/user.dart';
import '../../service/employee.dart';
import '../../utilities/theme.dart';

class UpdateEmployee extends StatefulWidget {
  const UpdateEmployee({Key? key}) : super(key: key);

  @override
  State<UpdateEmployee> createState() => _UpdateEmployeeState();
}

class _UpdateEmployeeState extends State<UpdateEmployee> {
  List<Users?> _tempList = [];
  final TextEditingController _roleIdController = TextEditingController();
  final TextEditingController _branchIdController = TextEditingController();
  final TextEditingController _departmentIdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _userCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getEmployeeList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> getEmployeeList() async {
    final data = await EmployeeService().retrieveEmployeeList();
    setState(() {
      _tempList = data;
    });
  }

  //int getIndexNumber(String type,String keyword){
  //  if(type=='Person'){
  //    _tempList= MockUsers.users.where((person) => person.name == keyword).toList();
  //  }else if(type=='Branch Code'){
  //    _tempList= MockUsers.users.where((person) => person.branchCode == keyword).toList();
  //  }else if(type=='Department ID'){
  //    _tempList= MockUsers.users.where((person) => person.departmentId.toString() == keyword).toList();
  //  }
  //  return 1;
  //}

  void setFilter(String type, String keyword) {
    List<Users> holder = [];
    holder = MockUsers.users.where((person) => person.name == keyword).toList();
    if (holder.isEmpty) {
      holder = MockUsers.users
          .where((person) => person.branchCode == keyword)
          .toList();
    }
    if (holder.isEmpty) {
      holder = MockUsers.users
          .where((person) => person.departmentId.toString() == keyword)
          .toList();
    }

    if (holder.isNotEmpty) {
      setState(() {
        _tempList = holder;
      });
    }
  }

  Future<void> _deleteUser(Users user) async {
    await EmployeeService().deleteEmployee(user.id!);
  }

  void _viewUser(Users user) {
    navigateToNext(user);
  }

  void navigateToNext(Users user) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
        pageBuilder: (context, animation, secondaryAnimation) => SubDashboard(
          userId: user.id,
        ),
      ),
    );
  }

  Future<void> _saveData(Users? user, bool isNew) async {
    //! ALL PASSED value check
    //TODO submit photo also
    //update
    _roleIdController.text;
    _branchIdController.text;
    _departmentIdController.text;
    //new
    _emailController.text;
    _nameController.text;
    _phoneController.text;
    _userCodeController.text;
    Map<String, Object?> data;

    if (isNew && user == null) {
      data = {
        "name": _nameController.text,
        "phone": _phoneController.text,
        "code": _userCodeController.text,
        "email": _emailController.text,
      };
      await EmployeeService().insertNewEmployee(data);
      setState(() {
        getEmployeeList();
      });
    } else {
      data = {
        "role_id": int.parse(_roleIdController.text),
        "branch_id": int.parse(_branchIdController.text),
        "department_id": int.parse(_departmentIdController.text)
      };
      await EmployeeService().updatEmployee(user!.id!, data);
    }
  }

  Future<void> _updateEmployee(BuildContext context, Users? user) async {
    bool isUpdate = user != null;
    await showModalBottomSheet(
        context: context,
        elevation: 2,
        //shape: const LinearBorder(),
        builder: (BuildContext context) {
          return SizedBox(
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    isUpdate
                        ? "Update the employee : ${user.id!}"
                        : "Add new employee",
                    style: ThemeConstant.blackTextBold18,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (isUpdate) ...[
                    txtFormField(
                      isEdit: true,
                      isEditable: true,
                      controller: _roleIdController,
                      texthint: 'Role Id',
                      text: user.roleId.toString(),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    txtFormField(
                      isEdit: true,
                      isEditable: true,
                      controller: _branchIdController,
                      texthint: 'Branch Code',
                      text: user.branchCode.toString(),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    txtFormField(
                      isEdit: true,
                      isEditable: true,
                      controller: _departmentIdController,
                      texthint: 'Department Id',
                      text: user.departmentId.toString(),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ] else ...[
                    txtFormField(
                      isEdit: true,
                      isEditable: true,
                      controller: _nameController,
                      texthint: 'Employee Name',
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    txtFormField(
                      isEdit: true,
                      isEditable: true,
                      controller: _phoneController,
                      texthint: 'Employee Phone',
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    txtFormField(
                      isEdit: true,
                      isEditable: true,
                      controller: _userCodeController,
                      texthint: 'Employee Code',
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    txtFormField(
                      isEdit: true,
                      isEditable: true,
                      controller: _emailController,
                      texthint: 'Employee Email',
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                  SizedBox(
                    height: isUpdate ? 26 : 13,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          isUpdate
                              ? CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.confirm,
                                  title:
                                      "Please inform the employee for any changes made",
                                  onConfirmBtnTap: () {
                                    _saveData(user, !isUpdate);
                                    Navigator.pop(context);
                                  },
                                  onCancelBtnTap: () => Navigator.pop(context),
                                )
                              : {
                                  _saveData(null, !isUpdate),
                                  Navigator.pop(context),
                                };
                        },
                        child: Container(
                          width: 210,
                          height: 60,
                          decoration: BoxDecoration(
                            color: ThemeConstant.trcGreen,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                              child: Text(
                            isUpdate ? 'Update Employee' : 'Add Employee',
                            style: ThemeConstant.blackTextBold18,
                          )),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          );
        },
        isScrollControlled: true);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height - 60;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Employee List',
          style: ThemeConstant.blackTextBold18,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: height,
          width: width,
          child: Column(
            children: [
              ListTile(
                tileColor: ThemeConstant.trcLightPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                leading: const Icon(
                  Icons.search_outlined,
                  color: ThemeConstant.trcPink,
                ),
                title: TextFormField(
                  decoration: InputDecoration(
                    hintStyle: ThemeConstant.whiteText18,
                    hintText: 'Enter name or branch code or department id',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onChanged: (value) {
                    setFilter('Person', value);
                  },
                ),
              ),
              SizedBox(
                height: height - 100,
                width: width,
                child: _tempList.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: 15,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return _buildExpansionTile(context, index);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add new employee',
        onPressed: () {
          _updateEmployee(context, null);
        },
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(
            color: ThemeConstant.trcBlack,
            width: 1,
          ),
        ),
        backgroundColor: ThemeConstant.trcGreen,
        child: const Icon(
          Icons.add_outlined,
          color: ThemeConstant.trcBlack,
        ),
      ),
    );
  }

  Widget _buildExpansionTile(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        collapsedBackgroundColor: ThemeConstant.trcPink,
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        trailing: IconButton(
            onPressed: () {
              _updateEmployee(context, _tempList[index]);
            },
            icon: const Icon(
              Icons.edit,
              color: ThemeConstant.trcBlack,
            )),
        backgroundColor: ThemeConstant.trcGreen,
        title: Row(
          children: [
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage('assets/images/picture-png.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _tempList[index]!.name ?? '',
                  style: ThemeConstant.blackTextBold18,
                ),
                Text(
                  _tempList[index]!.userCode ?? '',
                  style: ThemeConstant.blackText14,
                ),
                Text(
                  _tempList[index]!.departmentId.toString(),
                  style: ThemeConstant.blackText14,
                ),
              ],
            ),
          ],
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                width: 25,
              ),
              TextButton(
                onPressed: () {
                  CoolAlert.show(
                    context: context,
                    type: CoolAlertType.confirm,
                    title: "Are you sure , you want to delete this user ?",
                    onConfirmBtnTap: () {
                      _deleteUser(_tempList[index]!);
                      Navigator.pop(context);
                    },
                    onCancelBtnTap: () => Navigator.pop(context),
                  );
                },
                child: Text(
                  'Delete User',
                  style: ThemeConstant.redText18,
                ),
              ),
              TextButton(
                onPressed: () {
                  _viewUser(_tempList[index]!);
                },
                child: Text(
                  'View User',
                  style: ThemeConstant.blueText18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
