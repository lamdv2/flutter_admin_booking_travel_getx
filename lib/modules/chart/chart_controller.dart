import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class ChartController extends GetxController {
  final getListTop5TourBookingMost = Rxn<Map<TourModel, double>>({});
  final getListTourEachDayInWeek = Rxn<Map<double, double>>({});
  final getListTourEachDayInMonth = Rxn<Map<double, double>>({});

  final spotsWeek = Rxn<List<FlSpot>>([]);
  final spotsWeek10 = Rxn<List<FlSpot>>([]);
  final spotsWeek100 = Rxn<List<FlSpot>>([]);
  final spotsWeek1000 = Rxn<List<FlSpot>>([]);

  final spotsMonth = Rxn<List<FlSpot>>([]);
  final spotsMonth10 = Rxn<List<FlSpot>>([]);
  final spotsMonth100 = Rxn<List<FlSpot>>([]);
  final spotsMonth1000 = Rxn<List<FlSpot>>([]);
  final maxLeft = Rxn<double>(0);
  final isCheckBooking = RxBool(true);
  final isCheckDone = RxBool(false);
  final isCheckCancel = RxBool(false);

  final isCheckMonth10 = RxBool(true);
  final isCheckMonth100 = RxBool(false);
  final isCheckMonth1000 = RxBool(false);

  final titleChartLine = RxString('Chart of the booking each week');
  final titleChartTop = RxString('Chart of top 5 the most booked tours');

  Rx<String> selectedValue = 'Week'.obs;
  RxBool isCheckWeek = true.obs;
  RxBool isCheckMonth = false.obs;

  @override
  void onInit() {
    getTop5TourData();
    setSpotsMonth10();
    getQuantityTourInWeek();
    getBookingsPerMonth();
    titleChartLine.value = "";
    super.onInit();
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

  void setCheckBooking() {
    isCheckBooking.value = true;
    isCheckDone.value = false;
    isCheckCancel.value = false;
    getTop5TourData();
    titleChartTop.value = "Chart of top 5 the most booked tours";
  }

  void setCheckDone() {
    isCheckBooking.value = false;
    isCheckDone.value = true;
    isCheckCancel.value = false;
    getTop5TourDataDone();
    titleChartTop.value =
        "Chart of the top 5 tours with the most successful bookings";
  }

  void setCheckCancel() {
    isCheckBooking.value = false;
    isCheckDone.value = false;
    isCheckCancel.value = true;
    getTop5TourDataCancel();
    titleChartTop.value =
        "Chart of the top 5 tours with the most cancellations";
  }

  void getTop5TourData() async {
    getListTop5TourBookingMost.value = await getTop5ToursWithPercentage();
  }

  void getTop5TourDataDone() async {
    getListTop5TourBookingMost.value =
        await getTop5ToursWithPercentageStatus("done");
  }

  void getTop5TourDataCancel() async {
    getListTop5TourBookingMost.value =
        await getTop5ToursWithPercentageStatus("canceled");
  }

  void getQuantityTourInWeek() async {
    getListTourEachDayInWeek.value = await getBookingsPerDayLastWeek();
  }

  void getQuantityTourInMonth() async {
    getListTourEachDayInMonth.value = await getBookingsPerMonth();
  }

  // get top 5 tour
  Future<Map<TourModel, double>> getTop5ToursWithPercentage() async {
    try {
      QuerySnapshot<Map<String, dynamic>> historySnap =
          await FirebaseFirestore.instance.collection('historyModel').get();

      Map<String, double> tourCounts = {};
      for (var doc in historySnap.docs) {
        String? idTour = doc['idTour'];
        if (idTour != null) {
          tourCounts[idTour] = (tourCounts[idTour] ?? 0) + 1;
        }
      }

      List<MapEntry<String, double>> sortedTours = tourCounts.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      List<MapEntry<String, double>> top5TourEntries =
          sortedTours.take(5).toList();

      List<TourModel> top5Tours = [];
      for (MapEntry<String, double> entry in top5TourEntries) {
        DocumentSnapshot<Map<String, dynamic>> tourDoc = await FirebaseFirestore
            .instance
            .collection('tourModel')
            .doc(entry.key)
            .get();

        if (tourDoc.exists) {
          TourModel tour = TourModel.fromJson(tourDoc);
          top5Tours.add(tour);
        }
      }

      double totalBookings = top5Tours.isEmpty
          ? 1
          : top5TourEntries.map((entry) => entry.value).reduce((a, b) => a + b);

      Map<TourModel, double> result = {};
      for (TourModel tour in top5Tours) {
        double percentage =
            (tourCounts[tour.idTour]! / totalBookings * 100).roundToDouble();
        result[tour] = percentage.toDouble();
      }

      return result;
    } catch (e) {
      return {};
    }
  }

  Future<Map<TourModel, double>> getTop5ToursWithPercentageStatus(
      String statusCheck) async {
    try {
      QuerySnapshot<Map<String, dynamic>> historySnap =
          await FirebaseFirestore.instance.collection('historyModel').get();

      Map<String, double> tourCounts = {};
      for (var doc in historySnap.docs) {
        String? idTour = doc['idTour'];
        String? status = doc['status'];

        if (idTour != null && status == statusCheck) {
          tourCounts[idTour] = (tourCounts[idTour] ?? 0) + 1;
        }
      }

      List<MapEntry<String, double>> sortedTours = tourCounts.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      List<MapEntry<String, double>> top5TourEntries =
          sortedTours.take(5).toList();

      List<TourModel> top5Tours = [];
      for (MapEntry<String, double> entry in top5TourEntries) {
        DocumentSnapshot<Map<String, dynamic>> tourDoc = await FirebaseFirestore
            .instance
            .collection('tourModel')
            .doc(entry.key)
            .get();

        if (tourDoc.exists) {
          TourModel tour = TourModel.fromJson(tourDoc);
          top5Tours.add(tour);
        }
      }

      double totalBookings = top5Tours.isEmpty
          ? 1
          : top5TourEntries.map((entry) => entry.value).reduce((a, b) => a + b);

      Map<TourModel, double> result = {};
      for (TourModel tour in top5Tours) {
        double percentage =
            (tourCounts[tour.idTour]! / totalBookings * 100).roundToDouble();
        result[tour] = percentage.toDouble();
      }

      return result;
    } catch (e) {
      return {};
    }
  }

  // tour booking most in the week
  Future<Map<double, double>> getBookingsPerDayLastWeek() async {
    try {
      DateTime currentDate = DateTime.now();

      DateTime weekStart =
          currentDate.subtract(Duration(days: currentDate.weekday - 1));

      DateTime weekEnd = weekStart.add(Duration(days: 6));

      QuerySnapshot<Map<String, dynamic>> historySnap = await FirebaseFirestore
          .instance
          .collection('historyModel')
          .where('bookingDate',
              isGreaterThanOrEqualTo: Timestamp.fromDate(weekStart))
          .where('bookingDate',
              isLessThanOrEqualTo: Timestamp.fromDate(weekEnd))
          .get();

      Map<double, double> bookingsPerDay = {};

      for (int i = 1; i <= 7; i++) {
        bookingsPerDay[i.toDouble()] = 0;
      }

      for (var doc in historySnap.docs) {
        DateTime bookingDate = (doc['bookingDate'] as Timestamp).toDate();
        double dayOfWeek = bookingDate.weekday.toDouble();
        bookingsPerDay[dayOfWeek] = (bookingsPerDay[dayOfWeek] ?? 0) + 1;
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
      return {};
    }
  }

  Future<Map<double, double>> getBookingsPerMonth() async {
    try {
      QuerySnapshot<Map<String, dynamic>> historySnap =
          await FirebaseFirestore.instance.collection('historyModel').get();

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
}
