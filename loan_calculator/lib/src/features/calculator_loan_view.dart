import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:loan_calculator/src/features/car_calculator_loan_view.dart';
import 'package:loan_calculator/src/features/house_calculator_loan_widget.dart';
import 'package:loan_calculator/src/helper/app_lifecycle_reactor.dart';
import 'package:loan_calculator/src/helper/app_open_ad_manager.dart';

class CalculatorLoanView extends StatefulWidget {
  static const routeName = '/';

  const CalculatorLoanView({super.key});

  @override
  State<CalculatorLoanView> createState() => _CalculatorLoanViewState();
}

class _CalculatorLoanViewState extends State<CalculatorLoanView> {
  late AppLifecycleReactor _appLifecycleReactor;

  @override
  void initState() {
    super.initState();
    AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
    _appLifecycleReactor =
        AppLifecycleReactor(appOpenAdManager: appOpenAdManager);
    _appLifecycleReactor.listenToAppStateChanges();

    _initGoogleMobileAds();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<InitializationStatus> _initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }

  TabBar get _tabBar => const TabBar(
        labelColor: Color.fromARGB(255, 7, 93, 11),
        indicatorColor: Color.fromARGB(255, 7, 93, 11),
        tabs: [
          Tab(icon: Icon(Icons.directions_car)),
          Tab(icon: Icon(Icons.maps_home_work)),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Loan Calculator'),
            bottom: PreferredSize(
              preferredSize: _tabBar.preferredSize,
              child: Material(
                child: Theme(
                  data: ThemeData().copyWith(
                      splashColor: const Color.fromARGB(255, 7, 93, 11)),
                  child: _tabBar,
                ),
              ),
            ),
          ),
          body: const TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              CarCalculatorLoanView(),
              HouseCalculatorLoanView(),
            ],
          ),
        ),
      ),
    );
  }
}
