library quiz_view;
import 'package:flutter/material.dart';
import 'dart:math';

class QuizView extends StatefulWidget {
  bool showCorrect;
  String question;
  String questionTag;
  Color questionColor;
  Color backgroundColor;
  Widget image;
  double width;
  double height;
  String rightAnswer;
  List<String> wrongAnswers;
  Color tagBackgroundColor;
  Color tagColor;
  Color answerColor;
  Color answerBackgroundColor;
  void Function() onRightAnswer;
  void Function() onWrongAnswer;

  QuizView(
      {this.showCorrect = true,
      this.questionTag,
      @required this.question,
      this.questionColor = Colors.black,
      this.backgroundColor = Colors.white,
      this.image,
      @required this.height,
      @required this.width,
      @required this.rightAnswer,
      @required this.wrongAnswers,
      this.tagColor = Colors.black,
      this.tagBackgroundColor = Colors.white,
      this.answerColor = Colors.black,
      this.answerBackgroundColor = Colors.white,
      @required this.onRightAnswer,
      @required this.onWrongAnswer});

  _QuizViewState createState() => _QuizViewState(
      this.showCorrect,
      this.questionTag,
      this.question,
      this.questionColor,
      this.backgroundColor,
      this.image,
      this.height,
      this.width,
      this.rightAnswer,
      this.wrongAnswers,
      this.tagColor,
      this.tagBackgroundColor,
      this.answerColor,
      this.answerBackgroundColor,
      this.onRightAnswer,
      this.onWrongAnswer);
}

class _QuizViewState extends State<QuizView> with TickerProviderStateMixin {
  @override
  void iniState() {
    super.initState();
  }

  _QuizViewState(
      this.showCorrect,
      this.questionTag,
      this.question,
      this.questionColor,
      this.backgroundColor,
      this.image,
      this.height,
      this.width,
      this.rightAnswer,
      this.wrongAnswers,
      this.tagColor,
      this.tagBackgroundColor,
      this.answerColor,
      this.answerBackgroundColor,
      this.onRightAnswer,
      this.onWrongAnswer);

  bool showCorrect;
  String question;
  String questionTag;
  Color questionColor;
  Color backgroundColor;
  Widget image;
  double width;
  double height;
  String rightAnswer;
  List<String> wrongAnswers;
  Color tagBackgroundColor;
  Color tagColor;
  Color answerColor;
  Color answerBackgroundColor;
  void Function() onRightAnswer;
  void Function() onWrongAnswer;
  bool isTapped = false;
  static Random _random = new Random();
  int answerIndex;

  @override
  Widget build(BuildContext context) {
    if (!isTapped) {
      answerIndex = _random.nextInt(wrongAnswers.length + 1);
    }

    Column answerColumn = Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [],
    );

    for (String i in wrongAnswers) {
      answerColumn.children.add(Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(15),
        child: RaisedButton(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          shape: StadiumBorder(),
          color: answerBackgroundColor,
          textColor: Colors.white,
          child: Center(
            child: Text(
              i,
              style: TextStyle(
                  color: answerColor,
                  fontSize: width > height ? width / 25 : height / 25),
            ),
          ),
          onPressed: () {
            if (!isTapped) {
              onWrongAnswer();
              if (showCorrect) {
                setState(() {
                  isTapped = !isTapped;
                });
              }
            }
          },
        ),
      ));
    }
    answerColumn.children.insert(
        answerIndex,
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(15),
          child: RaisedButton(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            shape: StadiumBorder(),
            color: isTapped ? Colors.green : answerBackgroundColor,
            child: Center(
              child: Text(
                rightAnswer,
                style: TextStyle(
                    color: answerColor,
                    fontSize: width > height ? width / 25 : height / 25),
              ),
            ),
            onPressed: () {
              if (!isTapped) {
                onRightAnswer();
                if (showCorrect) {
                  setState(() {
                    isTapped = !isTapped;
                  });
                }
              }
            },
          ),
        ));

    return Container(
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.all(
                Radius.circular(height > width ? height / 20 : width / 20)),
            border: Border.all(
                color: Colors.black, width: 1.5, style: BorderStyle.solid)),
        width: width,
        height: height,
        child: questionTag != null
            ? Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: tagBackgroundColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                                height > width ? height / 20 : width / 20),
                            bottomRight: Radius.circular(
                                height > width ? height / 20 : width / 20),
                          )),
                      child: Text(
                        questionTag,
                        style: TextStyle(
                            color: tagColor,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                width > height ? width / 20 : height / 20),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        0, width > height ? width / 10 : height / 10, 0, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: image != null
                            ? [
                                Container(
                                  padding: EdgeInsets.all(20),
                                  child: RichText(
                                      text: TextSpan(
                                    text: question,
                                    style: TextStyle(
                                        color: questionColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: width > height
                                            ? width / 20
                                            : height / 20),
                                  )),
                                ),
                                image,
                                answerColumn
                              ]
                            : [
                                Container(
                                  padding: EdgeInsets.all(20),
                                  child: RichText(
                                    text: TextSpan(
                                        text: question,
                                        style: TextStyle(
                                            color: questionColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: width > height
                                                ? width / 20
                                                : height / 20)),
                                  ),
                                ),
                                answerColumn
                              ],
                      ),
                    ),
                  ),
                ],
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: image != null
                      ? [
                          Container(
                            padding: EdgeInsets.all(20),
                            child: RichText(
                                text: TextSpan(
                              text: question,
                              style: TextStyle(
                                  color: questionColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: width > height
                                      ? width / 20
                                      : height / 20),
                            )),
                          ),
                          image,
                          answerColumn
                        ]
                      : [
                          Container(
                            padding: EdgeInsets.all(20),
                            child: RichText(
                              text: TextSpan(
                                  text: question,
                                  style: TextStyle(
                                      color: questionColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: width > height
                                          ? width / 20
                                          : height / 20)),
                            ),
                          ),
                          answerColumn
                        ],
                ),
              ));
  }
}

