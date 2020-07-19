library quiz_view;

import 'package:flutter/material.dart';
import 'dart:math';

class QuizView extends StatefulWidget {
  /// Boolean to show the correct answer after the quiz is answered
  final bool showCorrect;

  /// The question
  final String question;

  /// The questonTag (question number or id)
  final String questionTag;

  /// Color of question font
  final Color questionColor;

  /// Background color
  final Color backgroundColor;

  /// Image if any
  final Widget image;

  /// Width of the quiz view
  final double width;

  /// Height of the quiz view
  final double height;

  /// The right answer
  final String rightAnswer;

  /// The wrong answers
  final List<String> wrongAnswers;

  /// Question Tag background color
  final Color tagBackgroundColor;

  /// Question Tag font color
  final Color tagColor;

  /// Answer font color
  final Color answerColor;

  /// Answer background color
  final Color answerBackgroundColor;

  /// This function is executed if the answer is right
  final void Function() onRightAnswer;

  /// This function is executed if the answer is wrong
  final void Function() onWrongAnswer;

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

  _QuizViewState createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  _QuizViewState();

  bool isTapped = false;
  static Random _random = new Random();
  int answerIndex;

  @override
  Widget build(BuildContext context) {
    if (!isTapped) {
      answerIndex = _random.nextInt(widget.wrongAnswers.length + 1);
    }

    Column answerColumn = Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [],
    );

    for (String i in widget.wrongAnswers) {
      answerColumn.children.add(Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(15),
        child: RaisedButton(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          shape: StadiumBorder(),
          color: widget.answerBackgroundColor,
          textColor: Colors.white,
          child: Center(
            child: Text(
              i,
              style: TextStyle(
                  color: widget.answerColor,
                  fontSize: widget.width > widget.height
                      ? widget.width / 25
                      : widget.height / 25),
            ),
          ),
          onPressed: () {
            if (!isTapped) {
              widget.onWrongAnswer();
              if (widget.showCorrect) {
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
            color: isTapped ? Colors.green : widget.answerBackgroundColor,
            child: Center(
              child: Text(
                widget.rightAnswer,
                style: TextStyle(
                    color: widget.answerColor,
                    fontSize: widget.width > widget.height
                        ? widget.width / 25
                        : widget.height / 25),
              ),
            ),
            onPressed: () {
              if (!isTapped) {
                widget.onRightAnswer();
                if (widget.showCorrect) {
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
            color: widget.backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(
                widget.height > widget.width
                    ? widget.height / 20
                    : widget.width / 20)),
            border: Border.all(
                color: Colors.black, width: 1.5, style: BorderStyle.solid)),
        width: widget.width,
        height: widget.height,
        child: widget.questionTag != null
            ? Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: widget.tagBackgroundColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                                widget.height > widget.width
                                    ? widget.height / 20
                                    : widget.width / 20),
                            bottomRight: Radius.circular(
                                widget.height > widget.width
                                    ? widget.height / 20
                                    : widget.width / 20),
                          )),
                      child: Text(
                        widget.questionTag,
                        style: TextStyle(
                            color: widget.tagColor,
                            fontWeight: FontWeight.bold,
                            fontSize: widget.width > widget.height
                                ? widget.width / 20
                                : widget.height / 20),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        0,
                        widget.width > widget.height
                            ? widget.width / 10
                            : widget.height / 10,
                        0,
                        0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: widget.image != null
                            ? [
                                Container(
                                  padding: EdgeInsets.all(20),
                                  child: RichText(
                                      text: TextSpan(
                                    text: widget.question,
                                    style: TextStyle(
                                        color: widget.questionColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: widget.width > widget.height
                                            ? widget.width / 20
                                            : widget.height / 20),
                                  )),
                                ),
                                widget.image,
                                answerColumn
                              ]
                            : [
                                Container(
                                  padding: EdgeInsets.all(20),
                                  child: RichText(
                                    text: TextSpan(
                                        text: widget.question,
                                        style: TextStyle(
                                            color: widget.questionColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                widget.width > widget.height
                                                    ? widget.width / 20
                                                    : widget.height / 20)),
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
                  children: widget.image != null
                      ? [
                          Container(
                            padding: EdgeInsets.all(20),
                            child: RichText(
                                text: TextSpan(
                              text: widget.question,
                              style: TextStyle(
                                  color: widget.questionColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: widget.width > widget.height
                                      ? widget.width / 20
                                      : widget.height / 20),
                            )),
                          ),
                          widget.image,
                          answerColumn
                        ]
                      : [
                          Container(
                            padding: EdgeInsets.all(20),
                            child: RichText(
                              text: TextSpan(
                                  text: widget.question,
                                  style: TextStyle(
                                      color: widget.questionColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: widget.width > widget.height
                                          ? widget.width / 20
                                          : widget.height / 20)),
                            ),
                          ),
                          answerColumn
                        ],
                ),
              ));
  }
}
