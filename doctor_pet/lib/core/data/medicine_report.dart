class MedicineReport {
  String medicineName;
  String unit;
  double price;
  int quantity;
  int totalPrice;
  DateTime importDate;
  DateTime expirationDate;
  MedicineReport({
    required this.medicineName,
    required this.unit,
    required this.price,
    required this.quantity,
    required this.totalPrice,
    required this.importDate,
    required this.expirationDate,
  });

}
