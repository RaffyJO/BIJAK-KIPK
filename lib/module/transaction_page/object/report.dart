class Report {
  String? id = "";
  String? reportName = "";
  String? refferingName = "";
  String? university = "";
  String? major = "";
  String? year = "";
  String? description = "";

  Report(String id, String reportName, String refferingName, String university,
      String major, String year, String description) {
    this.id = id;
    this.reportName = reportName;
    this.refferingName = refferingName;
    this.university = university;
    this.major = major;
    this.year = year;
    this.description = description;
  }

  static List<Report> reportList() {
    return [
      Report("1", "Penyalahgunaan KIK-K 1", "Jacob Subagyo",
          "Poltekes Kesehatan Kupang", "Keperawatan", "2019", "lalallalalaa"),
      Report("2", "Penyalahgunaan KIK-K 2", "Jacob Subagyo",
          "Poltekes Kesehatan Kupang", "Keperawatan", "2019", "lalallalalaa")
    ];
  }
}
