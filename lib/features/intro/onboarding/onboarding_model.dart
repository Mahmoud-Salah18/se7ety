class OnboardingModel {
  final String title;
  final String description;
  final String imagePath;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}

List<OnboardingModel> onboardingList = [
  OnboardingModel(
    title: "ابحث عن دكتور متخصص",
    description:
        "اكتشف مجموعة واسعة من الاطباء الخبراء والمتخصصين في مختلف المجالات",
    imagePath: "assets/images/on1.svg",
  ),

  OnboardingModel(
    title: "سهولة الحجز",
    description: "احجز المواعيد بضغطة زرار في اي وقت وفي اي مكان",
    imagePath: "assets/images/on2.svg",
  ),

  OnboardingModel(
    title: "امن وسري",
    description: "كن مطمئنا لأن خصوصيتك وأمانك هما أهم أولوياتنا",
    imagePath: "assets/images/on3.svg",
  ),
];
