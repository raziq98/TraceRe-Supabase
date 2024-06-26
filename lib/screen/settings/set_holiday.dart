// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/holiday_service.dart';
import 'package:flutter_application_1/widget/input.dart';

import '../../components/animated_list.dart';
import '../../model/holiday.dart';
import '../../model/user.dart';
import '../../utilities/theme.dart';

class SetHoliday extends StatefulWidget {
  const SetHoliday({super.key});

  @override
  State<SetHoliday> createState() => _SetHolidayState();
}

class _SetHolidayState extends State<SetHoliday> {
  List<Holiday?>? _tempList = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _startFromController = TextEditingController();
  final TextEditingController _endAtController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();
  final GlobalKey<AnimatedListState> listenkey = GlobalKey();

  @override
  void initState() {
    // TODO: implement Holiday update & insert
    super.initState();
    getHolidayList();
    //listenkey.currentState!.insertAllItems(0, _tempList!.length);
  }

  Future<void> getHolidayList() async {
    final data = await HolidayService().retrieveHolidayList();
    setState(() {
      _tempList = data;
    });
  }

  void remove(int index) async {
    final removedItem = _tempList![index];
    _tempList!.removeAt(index);
    await HolidayService().deleteHoliday(removedItem!.id!);
    listenkey.currentState!.removeItem(
        index,
        (context, animation) =>
            AnimatedItemList(item: removedItem, animations: animation),
        duration: const Duration(milliseconds: 500));
  }

  void _add() async {
    String startFromText = _startFromController.text;
    DateTime? parsedStartDate;
    DateTime? parsedEndAtDate;
    try {
      parsedStartDate = DateTime.parse(startFromText);
    } catch (e) {
      print('Error parsing date: $e');
    }

    String endAtText = _endAtController.text;
    try {
      parsedEndAtDate = DateTime.parse(endAtText);
      if(_daysController.text.isNotEmpty){
        parsedEndAtDate = parsedEndAtDate.add(Duration(days: int.parse(_daysController.text)));
      }
    } catch (e) {
      print('Error parsing date: $e');
    }
    var temp = Holiday(
        name: _nameController.text,
        startFrom: startFromText,
        endAt: parsedEndAtDate.toString(),
        dayAmount: int.parse(_daysController.text),description: '');
    _tempList!.add(temp);
    await HolidayService().insertNewHoliday(temp.toJson());
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Set Holiday',
          style: ThemeConstant.blackTextBold18,
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: height - 100,
          width: width,
          child: _tempList!.isEmpty? const Center(child: CircularProgressIndicator(),):AnimatedList(
            key: listenkey,
            initialItemCount: _tempList!.length,
            itemBuilder:
                (BuildContext context, int index, Animation<double> animation) {
              return AnimatedItemList(
                item: _tempList![index]!,
                animations: animation,
                onTap: () => remove(index),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ThemeConstant.trcGreen,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        onPressed: () => _addHoliday(context),
        child: const Icon(
          Icons.add,
          color: ThemeConstant.trcLightPurple,
          size: 50,
        ),
      ),
    );
  }

  Future<void> _addHoliday(BuildContext context) async {
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
                    "Add new holiday",
                    style: ThemeConstant.blackTextBold18,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  txtFormField(
                    isEdit: true,
                    isEditable: true,
                    controller: _nameController,
                    texthint: 'Holiday Name',
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  txtFormField(
                    isEdit: true,
                    isEditable: true,
                    controller: _startFromController,
                    texthint: 'Holiday start from',
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  txtFormField(
                    isEdit: true,
                    isEditable: true,
                    controller: _endAtController,
                    texthint: 'Holiday end at',
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  txtFormField(
                    isEdit: true,
                    isEditable: true,
                    controller: _daysController,
                    texthint: 'Number of days',
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          _add();
                          Navigator.pop(context);
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
                            'Add Holiday',
                            style: ThemeConstant.blackTextBold18,
                          )),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          );
        },
        isScrollControlled: true);
  }

  SizedBox branchDetailField(String text, String texthint, bool? isEdit,
      TextEditingController? controller, bool isEditable) {
    controller!.text = text;
    return SizedBox(
      height: 60,
      child: TextFormField(
        controller: controller,
        style: ThemeConstant.blackTextBold18,
        enabled: isEdit == true
            ? isEditable
                ? true
                : false
            : false,
        autofocus: true,
        decoration: InputDecoration(
          label: Text(
            texthint,
            style: ThemeConstant.blackTextBold18,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: ThemeConstant.trcGreen, width: 3),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: ThemeConstant.trcBlue, width: 3),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        readOnly: isEdit == false ? true : false,
      ),
    );
  }
}
