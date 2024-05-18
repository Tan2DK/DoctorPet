class DataTitleModel {
  final String name;
  final int flex;
  final Function()? action;
  final String? actionName;
  DataTitleModel({
    required this.name,
    required this.flex,
    this.action,
    this.actionName,
  });
}
