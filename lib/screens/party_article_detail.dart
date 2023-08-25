import 'package:dev_community/models/party_article_model.dart';
import 'package:dev_community/utils/helpers/helper.dart';
import 'package:dev_community/widgets/molecules/techskill_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PartyArticleDetail extends StatefulWidget {
  final PartyArticleModel partyArticleModel;

  const PartyArticleDetail({super.key, required this.partyArticleModel});

  @override
  State<PartyArticleDetail> createState() => _PartyArticleDetailState();
}

class _PartyArticleDetailState extends State<PartyArticleDetail> {
  Widget _articleOptionColumn(String svgPath, String label) {
    return Column(
      children: [
        SvgPicture.asset(
          svgPath,
          width: 30,
          height: 30,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 300,
                color: Colors.white,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.partyArticleModel.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage("assets/images/darius.png"),
                              )),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Text(
                          widget.partyArticleModel.poster,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Divider(
                          height: 30,
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _articleOptionColumn(
                                "assets/svgs/commons/category.svg",
                                widget.partyArticleModel.type),
                            _articleOptionColumn(
                                "assets/svgs/commons/process.svg",
                                widget.partyArticleModel.process),
                            _articleOptionColumn(
                                "assets/svgs/commons/calendar.svg",
                                widget.partyArticleModel.estimatedPeriod),
                            _articleOptionColumn(
                                "assets/svgs/commons/alarm.svg",
                                "D-${Helper().dayDifference(DateTime.now(), widget.partyArticleModel.deadline)}일 전"),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                color: Colors.white,
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    // recruitment status container
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "지원 현황",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: widget.partyArticleModel.position.entries
                              .map((e) {
                            return SizedBox(
                              height: 55,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    e.key,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "${e.value["current"]} / ${e.value["max"]}"),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      OutlinedButton(
                                        onPressed: () {},
                                        child: const Text("지원하기"),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // tech skill container
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "기술스택",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TechSkillRow(
                            techSkill: widget.partyArticleModel.techSkill),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
