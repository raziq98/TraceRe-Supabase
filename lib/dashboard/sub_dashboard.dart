import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/employee.dart';

import '../model/user.dart';

class SubDashboard extends StatefulWidget {
  const SubDashboard({Key? key, this.userId}) : super(key: key);
  final int? userId;

  @override
  State<SubDashboard> createState() => _SubDashboardState();
}

class _SubDashboardState extends State<SubDashboard> {
  Users? _currentUser;
  Users me = Users(
    id: 41,
    name: 'Hanabi Brown',
    userCode: 'EB004',
    address: '234 Maple Lane',
    postalCode: 98765,
    country: 'Australia',
    photo: 'profile4.jpg',
    phone: '******',
    email: 'emily@example.com',
    password: 'pass987',
    roleId: 1,
    branchCode: 'BR004',
    departmentId: 1,
    isAvailable: true,
    isOffDay: true,
  );
  @override
  void initState() {
    super.initState();
    _currentUser = me;
    fetchEmployeeItem();
  }

  Future<void> fetchEmployeeItem() async {
    final data = await EmployeeService().retrieveEmployeeItem(widget.userId!);
    setState(() {
      _currentUser = data!;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        height: height,
        width: width,
        child: _currentUser == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_currentUser!.name??''),
                    Text(_currentUser!.address??''),
                    Text(_currentUser!.postalCode.toString()),
                    Text(_currentUser!.country??''),
                    Text(_currentUser!.dateOfBirth??''),
                    Text(_currentUser!.branchId.toString()),
                    Text(_currentUser!.departmentId.toString()),
                    Text(_currentUser!.roleId.toString()),
                  ],
                ),
              ),
      ),
    );
  }
}
