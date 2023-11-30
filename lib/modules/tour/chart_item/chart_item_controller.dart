import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class ChartItemController extends GetxController {
  @override
  void onInit() {
    setSpotsMonth10();
    super.onInit();
  }

  Rx<String> selectedValue = 'Week'.obs;
  RxBool isCheckWeek = true.obs;
  RxBool isCheckMonth = false.obs;

  final maxLeft = Rxn<double>(0);

  final spotsWeek = Rxn<List<FlSpot>>([]);
  final spotsWeek10 = Rxn<List<FlSpot>>([]);
  final spotsWeek100 = Rxn<List<FlSpot>>([]);
  final spotsWeek1000 = Rxn<List<FlSpot>>([]);

  final spotsMonth = Rxn<List<FlSpot>>([]);
  final spotsMonth10 = Rxn<List<FlSpot>>([]);
  final spotsMonth100 = Rxn<List<FlSpot>>([]);
  final spotsMonth1000 = Rxn<List<FlSpot>>([]);

  final isCheckMonth10 = RxBool(true);
  final isCheckMonth100 = RxBool(false);
  final isCheckMonth1000 = RxBool(false);

  final titleChartLine = RxString('Chart of the booking each week');
  final getListTourEachDayInWeek = Rxn<Map<double, double>>({});
  final getListTourEachDayInMonth = Rxn<Map<double, double>>({});

  void getQuantityTourInWeek(String idTour) async {
    getListTourEachDayInWeek.value = await getBookingsPerDayLastWeek(idTour);
  }

  void getQuantityTourInMonth(String idTour) async {
    getListTourEachDayInMonth.value = await getBookingsPerMonth(idTour);
  }

  // tour booking most in the week
  Future<Map<double, double>> getBookingsPerDayLastWeek(String idTour) async {
    try {
      DateTime currentDate = DateTime.now();
      DateTime weekStart =
          currentDate.subtract(Duration(days: currentDate.weekday - 1));
      DateTime weekEnd = weekStart.add(const Duration(days: 6));
      QuerySnapshot<Map<String, dynamic>> historySnap =
          await FirebaseFirestore.instance
              .collection('historyModel')
              .where(
                'idTour',
                isEqualTo: idTour,
              )
              .where(
                'bookingDate',
                isGreaterThanOrEqualTo: Timestamp.fromDate(weekStart),
              )
              .where(
                'bookingDate',
                isLessThanOrEqualTo: Timestamp.fromDate(weekEnd),
              )
              .get();

      Map<double, double> bookingsPerDay = {};
      for (int i = 1; i <= 7; i++) {
        bookingsPerDay[i.toDouble()] = 0;
      }

      if (historySnap != []) {
        for (var doc in historySnap.docs) {
          DateTime bookingDate = (doc['bookingDate'] as Timestamp).toDate();
          double dayOfWeek = bookingDate.weekday.toDouble();
          bookingsPerDay[dayOfWeek] = (bookingsPerDay[dayOfWeek] ?? 0) + 1;
        }
      }

      List<MapEntry<double, double>> sortedEntries = bookingsPerDay.entries
          .toList()
        ..sort((a, b) => a.key.compareTo(b.key));

      bookingsPerDay = Map.fromEntries(sortedEntries);

      if (bookingsPerDay.isNotEmpty) {
        spotsWeek10.value = [];
        spotsWeek100.value = [];
        spotsWeek1000.value = [];
        for (var entry in sortedEntries) {
          spotsWeek10.value?.add(FlSpot(entry.key, entry.value));
          spotsWeek100.value?.add(FlSpot(entry.key, entry.value / 10));
          spotsWeek1000.value?.add(FlSpot(entry.key, entry.value / 100));
        }
      }

      return bookingsPerDay;
    } catch (e) {
      print("warning error failsa: $e");
      return {};
    }
  }

  Future<Map<double, double>> getBookingsPerMonth(String idTour) async {
    try {
      QuerySnapshot<Map<String, dynamic>> historySnap = await FirebaseFirestore
          .instance
          .collection('historyModel')
          .where('idTour', isEqualTo: idTour)
          .get();

      Map<double, double> bookingsPerMonth = {};

      for (var doc in historySnap.docs) {
        DateTime bookingDate = (doc['bookingDate'] as Timestamp).toDate();
        double monthKey = bookingDate.month.toDouble();
        bookingsPerMonth[monthKey] = (bookingsPerMonth[monthKey] ?? 0) + 1;
      }

      List<MapEntry<double, double>> sortedEntries = bookingsPerMonth.entries
          .toList()
        ..sort((a, b) => a.key.compareTo(b.key));

      bookingsPerMonth = Map.fromEntries(sortedEntries);

      if (bookingsPerMonth.isNotEmpty) {
        spotsMonth10.value = [];
        spotsMonth100.value = [];
        spotsMonth1000.value = [];
        for (var entry in sortedEntries) {
          spotsMonth10.value?.add(FlSpot(entry.key, entry.value));
          spotsMonth100.value?.add(FlSpot(entry.key, entry.value / 10));
          spotsMonth1000.value?.add(FlSpot(entry.key, entry.value / 100));
        }
      }

      if (bookingsPerMonth.isNotEmpty) {
        List<MapEntry<double, double>> sortedEntries = bookingsPerMonth.entries
            .toList()
          ..sort((a, b) => b.value.compareTo(a.value));

        double maxLeftValue =
            sortedEntries.isNotEmpty ? sortedEntries.first.value : 0.0;
        maxLeft.value = maxLeftValue;
      }

      return bookingsPerMonth;
    } catch (e) {
      return {};
    }
  }

  void setSpotsMonth10() {
    spotsMonth.value = spotsMonth10.value;
    spotsWeek.value = spotsWeek10.value;
    isCheckMonth10.value = true;
    isCheckMonth100.value = false;
    isCheckMonth1000.value = false;
  }

  void setSpotsMonth100() {
    spotsMonth.value = spotsMonth100.value;
    spotsWeek.value = spotsWeek100.value;
    isCheckMonth10.value = false;
    isCheckMonth100.value = true;
    isCheckMonth1000.value = false;
  }

  void setSpotsMonth1000() {
    spotsMonth.value = spotsMonth1000.value;
    spotsWeek.value = spotsWeek1000.value;
    isCheckMonth10.value = false;
    isCheckMonth100.value = false;
    isCheckMonth1000.value = true;
  }
}
