import 'package:finance_tracker_app/barGraph/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarGraph extends StatelessWidget {
  final double? maxY;
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thuAmount;
  final double friAmount;
  final double satAmount;
  const MyBarGraph({
    super.key,
    required this.maxY,
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thuAmount,
    required this.friAmount,
    required this.satAmount,
  });

  @override
  Widget build(BuildContext context) {
    // initialize the bar data :
    BarData myBarData = BarData(
      monAmount: monAmount,
      tueAmount: tueAmount,
      wedAmount: wedAmount,
      thuAmount: thuAmount,
      friAmount: friAmount,
      satAmount: satAmount,
      sunAmount: sunAmount,
    );

    myBarData.initializeBarData();
    return BarChart(BarChartData(
      titlesData: FlTitlesData(
        show : true,
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles : false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),

        bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true ,getTitlesWidget: getBottomTitles)),
      ),
      gridData: FlGridData(show : false),
      borderData: FlBorderData(show : false),
      maxY: maxY, 
      minY: 0,
      barGroups: myBarData.barData.map((data) => 
      BarChartGroupData(
        x: data.x,
        barRods : [
          BarChartRodData(
            toY: data.y,
            color : Colors.grey[800],
            width : 20,
            borderRadius: BorderRadius.circular(4),
            backDrawRodData: BackgroundBarChartRodData(
              show : true,
              toY : maxY,
              color : Colors.grey[200],
            )
          ),
        ],
        ),
      ).toList(),
      )
    );
  }
}

Widget getBottomTitles(double value , TitleMeta meta) {
  const style = TextStyle(color : Colors.grey , fontWeight : FontWeight.bold , fontSize : 13);
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = Text("S", style : style);
      break;
    case 1:
      text = Text("M", style : style);
      break;
    case 2:
      text = Text("T", style : style);
      break;
    case 3:
      text = Text("W", style : style);
      break;
    case 4:
      text = Text("T", style : style);
      break;
    case 5:
      text = Text("F", style : style);
      break;
    case 6:
      text = Text("S", style : style);
      break;
    default:
      text = Text("", style : style);
      break;
  }
  return SideTitleWidget(meta : meta, child: text);

}
