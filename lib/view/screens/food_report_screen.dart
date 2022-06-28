import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../../model/food_report_model.dart';

class FoodReport extends StatefulWidget {
  const FoodReport({Key? key}) : super(key: key);

  @override
  State<FoodReport> createState() => _FoodReportState();
}

class _FoodReportState extends State<FoodReport> {

  int pendingCount = 0;
  double fine = 0;
  var totalFine = 0;

  FoodReportModel? foodReportModel;

  Future postFoodReport(context) async {
    try {
      var url = Uri.parse("http://canteen.benzyinfotech.com/api/v3/userdata?");
      var body = {
        "month": "6",
        "token": "e4c1a5aaf59f7204ca1e411d8bf060bd",
      };
      Response response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        var decodedBody = json.decode(response.body);
        if (kDebugMode) {
          print(response.body);
        }
        setState(() {
          foodReportModel = FoodReportModel.fromJson(decodedBody);
        });

        if (kDebugMode) {
          print(foodReportModel?.reports[0].optIns.breakfast);
        }


        ////COUNTING FINE
        for (int i = 0; i < foodReportModel!.reports.length; i++) {
          if (foodReportModel!.reports[i].optIns.breakfast == "Pending") {
            pendingCount = pendingCount + 1;
          }

          if (foodReportModel!.reports[i].optIns.lunch == "Pending") {
            pendingCount = pendingCount + 1;
          }

          if (foodReportModel!.reports[i].optIns.dinner == "Pending") {
            pendingCount = pendingCount + 1;
          }
          fine = pendingCount.toDouble() * 100;
          totalFine = fine.toInt();
        }

        //

      } else {
        if (kDebugMode) {
          print('Request failed with status: ${response.statusCode}.');
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  @override
  void initState() {
    postFoodReport(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3D155F),
        title:  Text('FOOD ORDER DETAILS', style: TextStyle(fontSize: 16.0, color: Color(0xffe5e5e5), fontWeight: FontWeight.w500),),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: foodReportModel?.reports == null
            ? const Center(child: const CupertinoActivityIndicator())
            : Container(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 24.0),
                          decoration: BoxDecoration(
                              color: const Color(0xff292826),
                              borderRadius: BorderRadius.circular(12.0)),
                          height: 100.0,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total Fine:',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffe5e5e5),),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  "Rs.$totalFine",
                                  style: const TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffe5e5e5),),
                                  textAlign: TextAlign.left,
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 35.0,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFFC1C1C1),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(6.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                    child: const Center(
                                  child: Text(
                                    'Date',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.0,
                                    color:Color(0xff292826), ),
                                  ),
                                )),
                              ),
                              Expanded(
                                child: Container(
                                    child: const Center(
                                  child: Text(
                                    'BreakFast',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.0,
                                        color: Color(0xff3D155F),),
                                  ),
                                )),
                              ),
                              Expanded(
                                child: Container(
                                    child: const Center(
                                  child: Text(
                                    'Lunch',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.0,
                                        color: Color(0xff3D155F),),
                                  ),
                                )),
                              ),
                              Expanded(
                                child: Container(
                                    child: const Center(
                                  child: Text(
                                    'Dinner',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.0,
                                        color: Color(0xff3D155F),),
                                  ),
                                )),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: foodReportModel!.reports.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                      child: Center(
                                          child: Text(foodReportModel!
                                              .reports[index].date))),
                                ),
                                Expanded(
                                  child: Container(
                                      child: Center(
                                          child: Text(foodReportModel!
                                              .reports[index]
                                              .optIns
                                              .breakfast ??"--"))),
                                ),
                                Expanded(
                                  child: Container(
                                      child: Center(
                                          child: Text(foodReportModel!
                                              .reports[index].optIns.lunch ??"--"))),
                                ),
                                Expanded(
                                  child: Container(
                                      child: Center(
                                          child: Text(foodReportModel!
                                              .reports[index].optIns.dinner ??"--"))),
                                ),
                              ],
                            ),
                          ),
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
