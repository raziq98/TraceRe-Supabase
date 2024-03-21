import 'package:flutter/material.dart';

import '../../components/animated_list.dart';
import '../../model/work_type.dart';
import '../../service/worktype_service.dart';
import '../../utilities/theme.dart';

class SetWorkType extends StatefulWidget {
  const SetWorkType({super.key});

  @override
  State<SetWorkType> createState() => _SetWorkTypeState();
}

class _SetWorkTypeState extends State<SetWorkType> {
  final GlobalKey<AnimatedListState> listenkey = GlobalKey();
  List<WorkType>? _tempList = [];

  @override
  void initState() {
    super.initState();
    getHolidayList();
  }

  Future<void> getHolidayList() async {
    final data = await WorkTypeService().retrieveList();
    setState(() {
      _tempList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Set Work Type',
          style: ThemeConstant.blackTextBold18,
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: height - 100,
          width: width,
          child: _tempList!.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : AnimatedList(
                  key: listenkey,
                  initialItemCount: _tempList!.length,
                  itemBuilder: (BuildContext context, int index,
                      Animation<double> animation) {
                    return SizeTransition(
                      sizeFactor: animation,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8,vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: ThemeConstant.trcPink,
                          border: Border.all(
                            color: ThemeConstant.trcLightPurple,
                          ),
                        ),
                        child: ListTile(
                          title: _tempList![index].name != null
                              ? Text(
                                  _tempList![index].name!,
                                  style: ThemeConstant.blackTextBold16,
                                )
                              : null,
                          subtitle: _tempList![index].description != null
                              ? Text(
                                  _tempList![index].description!,
                                  style: ThemeConstant.blackTextBold16,
                                )
                              : null,
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
