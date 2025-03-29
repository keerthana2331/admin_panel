import 'package:flutter/material.dart';

import '../component/appbar_action_item.dart';
import '../component/bar_chart.dart';
import '../component/header.dart';
import '../component/history_table.dart';
import '../component/info_card.dart';
import '../component/payment_details_list.dart';
import '../component/side_menu.dart';
import '../config/responsive.dart';
import '../config/size_config.dart';
import '../style/colors.dart';
import '../style/style.dart';


class Dashboard extends StatelessWidget {
  Dashboard({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _drawerKey,
      drawer: SizedBox(width: 250, child: SideMenu(key: GlobalKey())),
      appBar: !Responsive.isDesktop(context)
          ? AppBar(
              elevation: 0,
              backgroundColor: AppColors.white,
              leading: IconButton(
                onPressed: () {
                  _drawerKey.currentState?.openDrawer();
                },
                icon: Icon(Icons.menu, color: AppColors.black),
              ),
              actions: [AppBarActionItems(key: GlobalKey())],
            )
          : null,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(flex: 1, child: SideMenu(key: GlobalKey())),
            Expanded(
              flex: 10,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Header(),
                    SizedBox(height: SizeConfig.blockSizeVertical! * 4),
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        InfoCard(
                          icon: 'assets/credit-card.svg',
                          label: 'Transfer via \nCard number',
                          amount: '\$1200',
                        ),
                        InfoCard(
                          icon: 'assets/transfer.svg',
                          label: 'Transfer via \nOnline Banks',
                          amount: '\$150',
                        ),
                        InfoCard(
                          icon: 'assets/bank.svg',
                          label: 'Transfer \nSame Bank',
                          amount: '\$1500',
                        ),
                        InfoCard(
                          icon: 'assets/invoice.svg',
                          label: 'Transfer to \nOther Bank',
                          amount: '\$1500',
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical! * 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PrimaryText(
                              text: 'Balance',
                              size: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondary,
                            ),
                            PrimaryText(
                              text: '\$1500',
                              size: 30,
                              fontWeight: FontWeight.w800,
                            ),
                          ],
                        ),
                        PrimaryText(
                          text: 'Past 30 DAYS',
                          size: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondary,
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical! * 3),
                    SizedBox(
                      height: 180,
                      child: BarChartComponent(), // Fixed typo in class name
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical! * 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PrimaryText(
                          text: 'History',
                          size: 30,
                          fontWeight: FontWeight.w800,
                        ),
                        PrimaryText(
                          text: 'Transaction of last 6 months',
                          size: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondary,
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical! * 3),
                    HistoryTable(),
                    if (!Responsive.isDesktop(context)) PaymentDetailList(key: GlobalKey()),
                  ],
                ),
              ),
            ),
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 4,
                child: Container(
                  width: double.infinity,
                  height: SizeConfig.screenHeight,
                  color: AppColors.secondaryBg,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    child: Column(
                      children: [
                        AppBarActionItems(key: GlobalKey()),
                        PaymentDetailList(key: GlobalKey()),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
