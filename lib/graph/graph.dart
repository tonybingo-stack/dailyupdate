import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/chartdata.dart';
// ignore: library_prefixes
import '../assets/constants.dart' as Constants;

class MyGraph extends StatefulWidget {
  const MyGraph(
      {Key? key,
      required this.followChartData,
      required this.notFollowChartData})
      : super(key: key);
  final List<ChartData> followChartData;
  final List<ChartData> notFollowChartData;

  @override
  // ignore: library_private_types_in_public_api
  _MyGraphState createState() => _MyGraphState();
}

class _MyGraphState extends State<MyGraph> {
  @override
  Widget build(BuildContext context) {
    final List<ChartData> followChartData = widget.followChartData;
    final List<ChartData> notFollowChartData = widget.notFollowChartData;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Constants.GRAPH_TITLE_BORDER_COLOR,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        gradient: const LinearGradient(
          colors: [
            Constants.GRAPH_TITLE_GRADIENT_TOP_COLOR,
            Constants.GRAPH_TITLE_GRADIENT_BOTTOM_COLOR
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      height: MediaQuery.of(context).size.width * 0.8,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
          child: SfCartesianChart(
              title: ChartTitle(text: 'Last 7 days Records'),
              primaryXAxis: CategoryAxis(
                  title: AxisTitle(
                      text: 'No. of days',
                      textStyle: const TextStyle(
                          color: Colors.deepOrange,
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w300))),
              primaryYAxis: NumericAxis(
                  title: AxisTitle(
                      text: 'No. of ans',
                      textStyle: const TextStyle(
                          color: Colors.deepOrange,
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w300))),
              // legend: Legend(isVisible: true),
              // tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries>[
                SplineSeries<ChartData, int>(
                    dataSource: followChartData,
                    color: Colors.green,
                    width: 3,
                    // Type of spline
                    splineType: SplineType.cardinal,
                    cardinalSplineTension: 0.9,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y),
                SplineSeries<ChartData, int>(
                    dataSource: notFollowChartData,
                    color: const Color(0xFFFF3333),
                    width: 3,
                    // Type of spline
                    splineType: SplineType.cardinal,
                    cardinalSplineTension: 0.9,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y),
              ])),
    );
  }
}
