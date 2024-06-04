class PointRowModel {
  final String title;
  final String description;
  final String icon;
  final bool isDoubleColor;
  PointRowModel({
    required this.title,
    required this.description,
    required this.icon,
    this.isDoubleColor = false,
  });
}
