import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:loan_calculator/src/model/model.dart';
import 'package:loan_calculator/src/widgets/loan_table_widget.dart';
import 'package:loan_calculator/src/widgets/monthly_repayment_widget.dart';
import 'package:loan_calculator/src/widgets/textfield_widget.dart';
import 'package:loan_calculator/src/helper/ad_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HouseCalculatorLoanView extends StatefulWidget {
  const HouseCalculatorLoanView({
    super.key,
  });

  @override
  State<HouseCalculatorLoanView> createState() =>
      _HouseCalculatorLoanViewState();
}

class _HouseCalculatorLoanViewState extends State<HouseCalculatorLoanView> {
  final dataKey = GlobalKey();

  late TextEditingController housePriceController;
  late TextEditingController downPayment;
  late TextEditingController loanPeriod;
  late TextEditingController interestRate;

  List<LoanData> plots = [];

  String totalPaymentMonthly = '';

  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    housePriceController = TextEditingController();
    downPayment = TextEditingController();
    loanPeriod = TextEditingController();
    interestRate = TextEditingController();

    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          debugPrint('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
  }

  @override
  void dispose() {
    housePriceController.dispose();
    downPayment.dispose();
    loanPeriod.dispose();
    interestRate.dispose();
    _bannerAd?.dispose();
    super.dispose();
  }

  Widget calculatorView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (_bannerAd != null)
            const SizedBox(
              height: 15,
            ),
          if (_bannerAd != null)
            SizedBox(
              width: _bannerAd?.size.width.toDouble(),
              height: _bannerAd?.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            ),
          if (_bannerAd != null)
            const SizedBox(
              height: 15,
            ),
          FormTextField(
            title: 'Property Price (MYR)',
            type: TextInputType.number,
            controller: housePriceController,
          ),
          FormTextField(
            title: 'Downpayment (%)',
            type: TextInputType.number,
            controller: downPayment,
          ),
          FormTextField(
            title: 'Loan Period (Years)',
            type: TextInputType.number,
            controller: loanPeriod,
          ),
          FormTextField(
            title: 'Interest Rate (%)',
            type: const TextInputType.numberWithOptions(decimal: true),
            controller: interestRate,
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 20, bottom: 25, left: 10, right: 10),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 7, 93, 11)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      side: BorderSide(color: Color.fromARGB(255, 7, 93, 11)),
                    ),
                  ),
                ),
                onPressed: () => {
                  _calculateLoan(
                    double.parse(housePriceController.text),
                    double.parse(downPayment.text),
                    double.parse(loanPeriod.text),
                    double.parse(interestRate.text),
                  ),
                },
                child: Text(
                  "Calculate".toUpperCase(),
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
          ),
          if (totalPaymentMonthly != '')
            MonthlyRepaymentWidget(
              dataKey: dataKey,
              title: 'MONTHLY REPAYMENT',
              totalPaymentMonthly: totalPaymentMonthly,
            ),
          if (plots.isNotEmpty) LoanTableWidget(plots: plots),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _dismissKeyBoard(context);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
        child: calculatorView(),
      ),
    );
  }

  void _dismissKeyBoard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void _calculateLoan(
      double housePrice, double dPayment, double lPeriod, double iRate) {
    num downPayment = dPayment * housePrice / 100;
    num amount = housePrice - downPayment;
    num interestRate = iRate / 1200;
    num loanPeriod = lPeriod * 12;
    num payment = 0;

    if (interestRate > 0) {
      var i = 1 + interestRate;
      var r = pow(i, loanPeriod);

      payment = (amount * (interestRate * r) / (r - 1));
    } else {
      payment = (amount / loanPeriod);
    }

    num oldinterest = 0;
    num oldprincipal = 0;
    num balance = amount;

    List<LoanData> plotsTemp = [];

    for (var i = 0; i < lPeriod; i++) {
      num interest = 0;
      num principal = 0;
      String indexYear = '';

      for (var j = 0; j < 12; j++) {
        interest = interestRate * balance;
        principal = payment - interest;

        balance -= principal;
        oldinterest += interest;
        oldprincipal += principal;
      }

      if (i == 0) {
        indexYear = '1st';
      } else if (i == 1) {
        indexYear = '2nd';
      } else if (i == 20) {
        indexYear = '21st';
      } else if (i == 21) {
        indexYear = '22nd';
      } else if (i == 30) {
        indexYear = '31st';
      } else if (i == 31) {
        indexYear = '32nd';
      } else {
        var x = i + 1;
        indexYear = '${x}th';
      }

      LoanData data = LoanData(
          years: indexYear,
          principal: oldprincipal.toStringAsFixed(2),
          interest: oldinterest.toStringAsFixed(2),
          balance: balance.abs().toStringAsFixed(2));
      plotsTemp.add(data);
    }

    setState(() {
      plots = plotsTemp;
      totalPaymentMonthly = payment.toStringAsFixed(2);
    });

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (dataKey.currentContext != null) {
        Scrollable.ensureVisible(
          dataKey.currentContext!,
          duration: const Duration(milliseconds: 200),
          curve: Curves.ease,
        );
      }
    });
  }
}
