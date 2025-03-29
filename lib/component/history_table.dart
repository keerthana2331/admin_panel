// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/responsive.dart';
import '../config/size_config.dart';
import '../data/data.dart';
import '../provider/header_provider.dart';

class HistoryTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var colors = themeProvider.currentGradient;

    return AnimatedContainer(
      duration: Duration(seconds: 1),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colors.last.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: -5,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection:
            Responsive.isDesktop(context) ? Axis.vertical : Axis.horizontal,
        child: SizedBox(
          width:
              Responsive.isDesktop(context)
                  ? double.infinity
                  : SizeConfig.screenWidth,
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: {
              0: FixedColumnWidth(60),
              1: FlexColumnWidth(),
              2: FlexColumnWidth(),
              3: FlexColumnWidth(),
              4: FlexColumnWidth(),
            },
            children: [
              _buildTableHeader(),
              ...List.generate(
                transactionHistory.length,
                (index) => _buildTableRow(index, colors),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TableRow _buildTableHeader() {
    return TableRow(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.3), width: 2),
        ),
      ),
      children: [
        SizedBox.shrink(),
        _headerText("Label"),
        _headerText("Time"),
        _headerText("Amount"),
        _headerText("Status"),
      ],
    );
  }

  TableRow _buildTableRow(int index, List<Color> colors) {
    return TableRow(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: CircleAvatar(
            radius: 18,
            backgroundImage: AssetImage("assets/woman.png"),
          ),
        ),
        _tableCell(transactionHistory[index]["label"] ?? ''),
        _tableCell(transactionHistory[index]["time"] ?? ''),
        _tableCell(transactionHistory[index]["amount"] ?? ''),
        _statusCell(transactionHistory[index]["status"] ?? ''),
      ],
    );
  }

  Widget _headerText(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _tableCell(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Text(
        text,
        style: TextStyle(fontSize: 16, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _statusCell(String status) {
    Color statusColor =
        status.toLowerCase() == "success"
            ? Colors.greenAccent
            : Colors.redAccent;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: statusColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: statusColor),
        ),
        child: Text(
          status,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: statusColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
