import 'package:doctor_pet/utils/app_extension.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartWidget extends StatefulWidget {
  const ChartWidget({
    Key? key,
    this.length = 1,
    this.startDate,
    required this.barChartGroupData,
  }) : super(key: key);
  final List<BarChartGroupData> Function(double barsWidth, double barsSpace)
      barChartGroupData;
  final int? length;
  final DateTime? startDate;
  @override
  State<StatefulWidget> createState() => ChartWidgetState();
}

class ChartWidgetState extends State<ChartWidget> {
  List<BarChartGroupData> dataChart = [];

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 14);
    String text = (widget.startDate ?? DateTime.now().dateOnly)
        .add(Duration(days: value.toInt()))
        .formatDateTime('dd/MM');
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    if (value > meta.max) {
      return Container();
    }
    const style = TextStyle(
      fontSize: 14,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        meta.formattedValue,
        style: style,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.25,
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double barsSpace = widget.length! <= 10
                ? 32
                : constraints.maxWidth / (4 * widget.length!) * 2;
            final double barsWidth = widget.length! <= 10
                ? 64
                : constraints.maxWidth / (8 * widget.length!) * 2;
            dataChart = widget.barChartGroupData(barsSpace, barsWidth);
            return BarChart(
              BarChartData(
                alignment: BarChartAlignment.start,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) =>
                        BarTooltipItem(
                      rod.toY >= 1 ? rod.toY.toString() : '0',
                      TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        height: 1,
                      ),
                    ),
                    getTooltipColor: (group) =>
                        Theme.of(context).colorScheme.primaryContainer,
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      getTitlesWidget: bottomTitles,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: leftTitles,
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  checkToShowHorizontalLine: (value) => value % 10 == 0,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.black.withOpacity(.1),
                    strokeWidth: 1,
                  ),
                  drawVerticalLine: false,
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                groupsSpace: barsSpace,
                barGroups: dataChart,
                //  getData(barsWidth, barsSpace),
              ),
            );
          },
        ),
      ),
    );
  }
}
