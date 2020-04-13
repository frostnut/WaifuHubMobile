/// util class used to pass args to the
/// HubDisplay page - used for encapsulation
class HubDisplayScreenArguments {
  final String id;
  final List<dynamic> commentIDs;
  final String hubname;
  final String description;
  final String imageUrl;

  HubDisplayScreenArguments(
      this.id, this.commentIDs, this.hubname, this.description, this.imageUrl);
}
