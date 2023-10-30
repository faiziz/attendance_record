class Data {

  final String user;
  final String phone;
  final String checkIn;
  final DateTime secondcheckIn;

  Data({
    required this.user,
    required this.phone,
    required this.checkIn,
    required this.secondcheckIn});
}

List<Data> dataList = [
  Data(
    user : "Chan Saw Lin",
    phone: "0152131113",
    checkIn: "2020-06-30 16:10:05",
    secondcheckIn: DateTime(2020, 6, 30, 16, 10, 5),
  ),
  Data(
    user : "Lee Saw Loy",
    phone: "01612331346",
    checkIn: "2020-07-11 15:39:59",
    secondcheckIn: DateTime(2020, 7, 11, 15, 39, 59),
  ),
  Data(
    user : "Khaw Tong Lin",
    phone: "0158398109",
    checkIn: "2020-08-19 11:10:18",
    secondcheckIn: DateTime(2020, 8, 19, 11, 10, 18),
  ),
  Data(
    user : "Lim Kok Lin",
    phone: "0168279101",
    checkIn: ": 2020-08-19 11:11:35",
    secondcheckIn: DateTime(2020, 8, 19, 11, 11, 35),
  ),
  Data(
    user : "Low Jun Wei",
    phone: "0112731912",
    checkIn: "2020-08-15 13:00:05",
    secondcheckIn: DateTime(2020, 8, 15, 13, 0, 5),
  ),
  Data(
    user : "Yong Weng Kai",
    phone: "0172332743",
    checkIn: "2020-07-31 18:10:11",
    secondcheckIn: DateTime(2020, 7, 31, 18, 10, 11),
  ),
  Data(
    user : "Jayden Lee",
    phone: "0191236439",
    checkIn: "2020-08-22 08:10:38",
    secondcheckIn: DateTime(2020, 8, 22, 8, 10, 38),
  ),
  Data(
    user : "Kong Kah Yan",
    phone: "0111931233",
    checkIn: "2020-07-11 12:00:00",
    secondcheckIn: DateTime(2020, 7, 11, 12),
  ),
  Data(
    user : "Jasmine Lau",
    phone: "0162879190",
    checkIn: "2020-08-01 12:10:05",
    secondcheckIn: DateTime(2020, 8, 1, 12, 10, 5),
  ),
  Data(
    user : "Chan Saw Lin",
    phone: "016783239",
    checkIn: "2020-08-23 11:59:05",
    secondcheckIn: DateTime(2020, 8, 23, 11, 59, 5),
  ),
];