import 'package:flutter/material.dart';
import 'package:sih_1/models/beach_data_model.dart';
import 'package:sih_1/presentation/utils/beach_info_listtile.dart';
import 'package:sih_1/presentation/utils/calculate_safety_index_and_verdict.dart';

class BeachInfoScreen extends StatefulWidget {
  final BeachDataList? beachDataList;
  const BeachInfoScreen({super.key, required this.beachDataList});

  @override
  State<BeachInfoScreen> createState() => _BeachInfoScreenState();
}

class _BeachInfoScreenState extends State<BeachInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.beachDataList != null
        ? Scaffold(
            appBar: AppBar(
              title: Text(widget.beachDataList!.beachName!),
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Image.network(
                      widget.beachDataList!.image!,
                      width: MediaQuery.sizeOf(context).width,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      getBeachVerdict(widget.beachDataList!)[1].toString(),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "${widget.beachDataList!.area![0]}, ${widget.beachDataList!.state}",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    beachInfoListTile("Safety Score",
                        getBeachVerdict(widget.beachDataList!)[0].toString()),
                    beachInfoListTile("Water Quality",
                        widget.beachDataList!.waterQuality!.waterQualityValue!),
                    beachInfoListTile("Wind Speed",
                        "${widget.beachDataList!.windSpeed!.windSpeedValue!} ${widget.beachDataList!.windSpeed!.windSpeedUnit}"),
                    beachInfoListTile(
                        "Wind Direction",
                        widget
                            .beachDataList!.windDirection!.windDirectionValue!),
                    beachInfoListTile("Wave height",
                        "${widget.beachDataList!.waveHeight!.waveHeightValue!} ${widget.beachDataList!.waveHeight!.waveHeightUnit}"),
                    beachInfoListTile("Water Temperature",
                        "${widget.beachDataList!.waterTemperature!.waterTemperatureValue!}°C"),
                    beachInfoListTile("Rip Current Risk",
                        "${widget.beachDataList!.ripCurrentRisk!.ripCurrentRiskValue}"),
                    beachInfoListTile(
                        "Beach Slope",
                        widget.beachDataList!.beachSlope!.beachSlopeValue!
                            .toString()),
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text("Beach Info"),
            ),
            body: Center(
              child: Text("No data available"),
            ),
          );
  }
}
