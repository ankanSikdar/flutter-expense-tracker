import 'package:expense_app/models/transaction.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeekPieChart extends StatefulWidget {
  final List<Transaction> transactions;
  const WeekPieChart({Key key, @required this.transactions}) : super(key: key);

  @override
  _WeekPieChartState createState() => _WeekPieChartState();
}

class _WeekPieChartState extends State<WeekPieChart> {
  List<double> spendings = List.generate(7, (index) => 0);

  void generateWeeklyReport() {
    if (spendings.isNotEmpty) {
      spendings.clear();
      spendings = List.generate(7, (index) => 0);
    }
    for (Transaction transaction in widget.transactions) {
      spendings[transaction.date.weekday - 1] += transaction.amount;
    }
  }

  @override
  Widget build(BuildContext context) {
    generateWeeklyReport();
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 7,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      color: Colors.amber,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  'Weekly Expenses',
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Pie Chart',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 3.0,
                      centerSpaceRadius: 00.0,
                      startDegreeOffset: 130.0,
                      borderData:
                          FlBorderData(border: Border.all(), show: false),
                      sections: [
                        PieChartSectionData(
                          showTitle: false,
                          color: Colors.black,
                          value: spendings[0],
                          radius: 75.0,
                        ),
                        PieChartSectionData(
                          showTitle: false,
                          color: Colors.redAccent,
                          value: spendings[1],
                          radius: 75.0,
                        ),
                        PieChartSectionData(
                          showTitle: false,
                          color: Colors.deepPurple,
                          value: spendings[2],
                          radius: 75.0,
                        ),
                        PieChartSectionData(
                          showTitle: false,
                          color: Colors.grey,
                          value: spendings[3],
                          radius: 75.0,
                        ),
                        PieChartSectionData(
                          showTitle: false,
                          color: Colors.green,
                          value: spendings[4],
                          radius: 75.0,
                        ),
                        PieChartSectionData(
                          showTitle: false,
                          color: Colors.brown,
                          value: spendings[5],
                          radius: 75.0,
                        ),
                        PieChartSectionData(
                          showTitle: false,
                          color: Colors.blue,
                          value: spendings[6],
                          radius: 75.0,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: const <Widget>[
                    Indicator(
                      color: Colors.black,
                      text: 'Sun',
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: Colors.redAccent,
                      text: 'Mon',
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: Colors.deepPurple,
                      text: 'Tue',
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: Colors.grey,
                      text: 'Wed',
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: Colors.green,
                      text: 'Thu',
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: Colors.brown,
                      text: 'Fri',
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: Colors.blue,
                      text: 'Sat',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final Color textColor;

  const Indicator({
    Key key,
    @required this.color,
    @required this.text,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: textColor),
        )
      ],
    );
  }
}
