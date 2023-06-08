import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:theteam_gyp/user-interface/quiz/controller/quiz_controller.dart';
import '../../controller/index_controller.dart';
import '../../utilities/list_of_answers.dart';
import '../../utilities/list_of_questions.dart';
import '../Widgets/choose_an_answer_box.dart';
import '../Widgets/option_box.dart';
import '../Widgets/question_answer_divider.dart';
import '../Widgets/question_box.dart';
import '../Widgets/question_mark_icon.dart';
import '../Widgets/question_number_index.dart';
import 'result_screen.dart';

class FirstPage extends StatelessWidget {
  int indexForQuestionNumber = 1;
  int selectedOption = 0;
  int marksObtainedFromCorrectAnswer = 0;

  int marksEarnedFromQuiz = 0;

  FirstPage({super.key});

  QuizController controller = QuizController();

  @override
  Widget build(BuildContext context) {
    controller.navIndex.add('ques');
    return StreamBuilder<String>(
        stream: controller.navIndex.stream,
        builder: (context, snapshot) {
          if (snapshot.data == 'ques') {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //Main Column
              children: [
                Consumer<IndexController>(builder: (context, provider, child) {
                  indexForQuestionNumber = provider.currentQuestionIndex;
                  selectedOption = provider.optionSelected;
                  return QuestionNumberIndex(
                    questionNumber: indexForQuestionNumber,
                  );
                }),
                Consumer<IndexController>(builder: (context, provider, child) {
                  indexForQuestionNumber = provider.currentQuestionIndex;

                  return QuestionBox(
                      question: questionsList[indexForQuestionNumber]);
                }),
                Consumer<IndexController>(builder: (context, provider, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OptionBox(
                        optionSelected: provider.optionSelected,
                        optionParameter: optionOne,
                        optionIndex: 'A.',
                        indexForQuestionNumber: provider.currentQuestionIndex,
                        providerIndexForOption: 1,
                      ),
                      OptionBox(
                        optionSelected: provider.optionSelected,
                        optionParameter: optionTwo,
                        optionIndex: 'B.',
                        indexForQuestionNumber: provider.currentQuestionIndex,
                        providerIndexForOption: 2,
                      ),
                      OptionBox(
                        optionSelected: provider.optionSelected,
                        optionParameter: optionThree,
                        optionIndex: 'C.',
                        indexForQuestionNumber: provider.currentQuestionIndex,
                        providerIndexForOption: 3,
                      ),
                      Consumer<IndexController>(
                          builder: (context, provider, child) {
                        indexForQuestionNumber = provider.currentQuestionIndex;
                        selectedOption = provider.optionSelected;
                        return selectedOption > 0
                            ? Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Container(
                                          height: 45,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: const [
                                                BoxShadow(
                                                  offset: Offset(1, 5),
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.25),
                                                  blurRadius: 1.5,
                                                  spreadRadius: 1,
                                                ),
                                                BoxShadow(
                                                    offset: Offset(1, 2),
                                                    color: Colors.white,
                                                    blurRadius: 1,
                                                    spreadRadius: 1)
                                              ]),
                                          child: ListTile(
                                            onTap: () {
                                              marksForCorrectAnswers();
                                              if (indexForQuestionNumber < 3) {
                                                provider
                                                    .updateIndexForQuestion();
                                              } else {
                                                controller.navIndex
                                                    .add('result');
                                              }
                                              provider.selectedOptionIndex(0);
                                            },
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            tileColor: Colors.white,
                                            leading: Text(
                                              'NEXT',
                                              style: GoogleFonts.mulish(
                                                fontWeight: FontWeight.w700,
                                                color: const Color.fromRGBO(
                                                    66, 130, 241, 1),
                                              ),
                                            ),
                                            title: const Padding(
                                              padding: EdgeInsets.only(
                                                right: 20,
                                                bottom: 5,
                                              ),
                                              child: Icon(
                                                Icons.arrow_forward,
                                                color: Color.fromRGBO(
                                                    66, 130, 241, 1),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : const SizedBox(
                                height: 65,
                              );
                      })
                    ],
                  );
                }),
              ],
            );
          } else if (snapshot.data == 'result') {
            print('##### LOG ::: This is result triggered');
            return Consumer<IndexController>(
                builder: (context, getIndexProvider, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 149.33,
                        height: 149.33,
                        child: CircularPercentIndicator(
                          backgroundColor:
                              const Color.fromRGBO(230, 230, 230, 1),
                          animation: true,
                          radius: 70,
                          lineWidth: 13.0,
                          percent: marksEarnedFromQuiz / 3,
                          animationDuration: 1000,
                          reverse: true,
                          circularStrokeCap: CircularStrokeCap.round,
                          center: Text(
                            "$marksEarnedFromQuiz/3",
                            style: GoogleFonts.mulish(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.3,
                              fontSize: 15,
                            ),
                          ),
                          progressColor: marksEarnedFromQuiz > 2
                              ? const Color.fromRGBO(82, 186, 0, 1)
                              : const Color.fromRGBO(254, 123, 30, 1),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          marksEarnedFromQuiz < 2
                              ? Container(
                                  width: 150,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(254, 123, 30, 1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Ooops...!',
                                      style: GoogleFonts.mulish(
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 1),
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: -0.3,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 150,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(82, 186, 0, 1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Awesome!',
                                    style: GoogleFonts.mulish(
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 1),
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: -0.3,
                                      fontSize: 15,
                                    ),
                                  )),
                                ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          marksEarnedFromQuiz < 2
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                    top: 23,
                                  ),
                                  child: Container(
                                    width: 160,
                                    height: 37,
                                    color: Colors.white,
                                    child: InkWell(
                                      onTap: () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             const HomeScreen()));
                                      },
                                      child: Text(
                                        'Try Again',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.mulish(
                                          decoration: TextDecoration.underline,
                                          color: const Color.fromRGBO(
                                              66, 130, 241, 1),
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: -0.3,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(
                                    top: 23,
                                  ),
                                  child: Container(
                                    width: 160,
                                    height: 60,
                                    color: Colors.white,
                                    child: Text(
                                      'Congratulations\n You Passed the exam',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.mulish(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: -0.3,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      )
                    ],
                  )
                ],
              );
            });
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  void marksForCorrectAnswers() {
    if (indexForQuestionNumber == 1) {
      if (selectedOption == 1) {
        marksObtainedFromCorrectAnswer++;
      }
    }
    if (indexForQuestionNumber == 2) {
      if (selectedOption == 3) {
        marksObtainedFromCorrectAnswer++;
      }
    }
    if (indexForQuestionNumber == 3) {
      if (selectedOption == 3) {
        marksObtainedFromCorrectAnswer++;
      }
    }
  }
}
