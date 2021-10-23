import 'package:expense_app/models/models.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeekPieChart extends StatefulWidget {
  final List<Transaction> _transactions;
  const WeekPieChart({Key key, List<Transaction> transactions})
      : _transactions = transactions,
        super(key: key);

  @override
  _WeekPieChartState createState() => _WeekPieChartState();
}

class _WeekPieChartState extends State<WeekPieChart> {
  List<double> _spendings = List.generate(7, (index) => 0);

  void _generateWeeklyReport() {
    if (_spendings.isNotEmpty) {
      _spendings.clear();
      _spendings = List.generate(7, (index) => 0);
    }
    for (Transaction transaction in widget._transactions) {
      _spendings[transaction.date.weekday - 1] += transaction.amount;
    }
  }

  @override
  Widget build(BuildContext context) {
    _generateWeeklyReport();
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 7,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      color: Theme.of(context).accentColor,
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
                          color: Colors.redAccent,
                          value: _spendings[0],
                          radius: 75.0,
                        ),
                        PieChartSectionData(
                          showTitle: false,
                          color: Colors.deepPurple,
                          value: _spendings[1],
                          radius: 75.0,
                        ),
                        PieChartSectionData(
                          showTitle: false,
                          color: Colors.grey,
                          value: _spendings[2],
                          radius: 75.0,
                        ),
                        PieChartSectionData(
                          showTitle: false,
                          color: Colors.green,
                          value: _spendings[3],
                          radius: 75.0,
                        ),
                        PieChartSectionData(
                          showTitle: false,
                          color: Colors.brown,
                          value: _spendings[4],
                          radius: 75.0,
                        ),
                        PieChartSectionData(
                          showTitle: false,
                          color: Colors.blue,
                          value: _spendings[5],
                          radius: 75.0,
                        ),
                        PieChartSectionData(
                          showTitle: false,
                          color: Colors.black,
                          value: _spendings[6],
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
                    SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: Colors.black,
                      text: 'Sun',
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
  final Color _color;
  final String _text;
  final double _size;
  final Color _textColor;

  const Indicator({
    Key key,
    @required Color color,
    @required String text,
    double size = 16,
    Color textColor = const Color(0xff505050),
  })  : _color = color,
        _text = text,
        _size = size,
        _textColor = textColor,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: _size,
          height: _size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          _text,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: _textColor),
        )
      ],
    );
  }
}
