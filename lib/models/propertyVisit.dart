class PropertyVisit {
  final String propertyId;
  final String visitID;
  final String visitDateTime;
  final String visitedBy;
  final String visitNotes;
  final Map<String, String> visitFiles;
  final List<String> visitPictures;

  PropertyVisit({this.propertyId, this.visitID, this.visitDateTime, this.visitedBy, this.visitNotes, this.visitFiles, this.visitPictures});
}