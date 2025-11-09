import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/features/patient/search/widget/search_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String search = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ابحث عن دكتور")),
      body: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: Column(
          children: [
            Container(
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.greyColor.withOpacity(.3),
                    blurRadius: 15,
                    offset: Offset(5, 5),
                  ),
                ],
              ),
              child: TextField(
                onChanged: (searchKey) {
                  setState(() {
                    search = searchKey;
                  });
                },
                decoration: InputDecoration(
                  hintText: "البحث",
                  suffixIcon: SizedBox(
                    width: 50,
                    child: Icon(Icons.search, color: AppColors.secondColor),
                  ),
                ),
              ),
            ),
            Gap(15),
            Expanded(child: SearchList(searchKey: search)),
          ],
        ),
      ),
    );
  }
}
