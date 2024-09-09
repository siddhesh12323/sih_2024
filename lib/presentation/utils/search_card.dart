import 'package:flutter/material.dart';
import 'package:sih_1/models/beach_data_model.dart';
import 'package:sih_1/presentation/utils/calculate_safety_index_and_verdict.dart';

Widget searchcard(BeachDataList beachDataList, BuildContext context) {
  List<Object> beachVerdict = getBeachVerdict(beachDataList);
  return InkWell(
    onTap: () {
      Navigator.pushNamed(context, '/beach_info_screen',
          arguments: {'beach_object': beachDataList});
    },
    child: Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: beachVerdict[2] as Color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 20,
          ),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text("${beachDataList.beachName!}, ${beachDataList.area![0]}",
                    style: TextStyle(fontSize: 18)),
                SizedBox(
                  height: 10,
                ),
                Text(beachDataList.state!, style: TextStyle(fontSize: 18)),
                Spacer(),
                Text(
                    (beachVerdict[1] as String)
                        .split(' for Recreational Activities')
                        .join(''),
                    style: TextStyle(fontSize: 18)),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Spacer(),
          Expanded(
              flex: 1,
              child: Text(beachVerdict[0].toString(),
                  style: TextStyle(fontSize: 22))),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    ),
  );
}
