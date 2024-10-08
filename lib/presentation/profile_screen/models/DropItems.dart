///SelectionPopupModel is common model
///used for setting data into dropdowns
class Dropitems {
  int? id;
  String title;
  dynamic value;

  Dropitems({
    this.id,
    required this.title,
    this.value,
  });
}
