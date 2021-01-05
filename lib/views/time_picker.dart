library time_picker_spinner;

import 'package:flutter/material.dart';
import 'dart:math';

class ItemScrollPhysics extends ScrollPhysics {
  /// Creates physics for snapping to item.
  /// Based on PageScrollPhysics
  final double itemHeight;
  final double targetPixelsLimit;

  const ItemScrollPhysics({
    ScrollPhysics parent,
    this.itemHeight,
    this.targetPixelsLimit = 3.0,
  }) : assert(itemHeight != null && itemHeight > 0),
        super(parent: parent);

  @override
  ItemScrollPhysics applyTo(ScrollPhysics ancestor) {
    return ItemScrollPhysics(parent: buildParent(ancestor), itemHeight: itemHeight);
  }

  double _getItem(ScrollPosition position) {
    double maxScrollItem = (position.maxScrollExtent / itemHeight).floorToDouble();
    return min(max(0, position.pixels / itemHeight), maxScrollItem);
  }

  double _getPixels(ScrollPosition position, double item) {
    return item * itemHeight;
  }

  double _getTargetPixels(ScrollPosition position, Tolerance tolerance, double velocity) {
    double item = _getItem(position);
    if (velocity < -tolerance.velocity)
      item -= targetPixelsLimit;
    else if (velocity > tolerance.velocity)
      item += targetPixelsLimit;
    return _getPixels(position, item.roundToDouble());
  }

  @override
  Simulation createBallisticSimulation(ScrollMetrics position, double velocity) {
    // If we're out of range and not headed back in range, defer to the parent
    // ballistics, which should put us back in range at a item boundary.
//    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
//        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent))
//      return super.createBallisticSimulation(position, velocity);
    Tolerance tolerance = this.tolerance;
    final double target = _getTargetPixels(position, tolerance, velocity);
    if (target != position.pixels)
      return ScrollSpringSimulation(spring, position.pixels, target, velocity, tolerance: tolerance);
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}

typedef SelectedIndexCallback = void Function(int) ;
typedef TimePickerCallback = void Function(DateTime) ;

class TimePickerSpinner extends StatefulWidget {
  final DateTime time;
  final int minutesInterval;
  final int secondsInterval;
  final bool is24HourMode;
  final bool isShowSeconds;
  final double itemHeight;
  final double itemWidth;
  final bool isForce2Digits;
  final TimePickerCallback onTimeChange;

  TimePickerSpinner({
    Key key,
    this.time,
    this.minutesInterval = 1,
    this.secondsInterval = 1,
    this.is24HourMode = true,
    this.isShowSeconds = false,
    this.itemHeight,
    this.itemWidth,
    this.isForce2Digits = false,
    this.onTimeChange
  }) : super(key: key);

  @override
  _TimePickerSpinnerState createState() => new _TimePickerSpinnerState();

}

class _TimePickerSpinnerState extends State<TimePickerSpinner> {
  ScrollController hourController = new ScrollController();
  ScrollController minuteController = new ScrollController();
  ScrollController secondController = new ScrollController();
  ScrollController apController = new ScrollController();
  int currentSelectedHourIndex = -1;
  int currentSelectedMinuteIndex = -1;
  int currentSelectedSecondIndex = -1;
  int currentSelectedAPIndex = -1;
  DateTime currentTime;
  bool isHourScrolling = false;
  bool isMinuteScrolling = false;
  bool isSecondsScrolling = false;
  bool isAPScrolling = false;

  /// default settings
  TextStyle highlightTextStyle = new TextStyle(
    fontFamily: "AppleSDGothicNeo",
    fontWeight: FontWeight.w800,
      fontSize: 67,
      color: Color.fromARGB(255, 237, 234, 231),
  );
  TextStyle normalTextStyle = new TextStyle(
      fontFamily: "AppleSDGothicNeo",
      fontWeight: FontWeight.w800,
      fontSize: 62,
      color: Color.fromARGB(255, 75, 79, 93)
  );
  double spacing = 20;
  AlignmentGeometry alignment = Alignment.center;

  int _getHourCount(){
    return widget.is24HourMode ? 24 : 12;
  }
  int _getMinuteCount(){
    return (60 / widget.minutesInterval).floor();
  }
  int _getSecondCount(){
    return (60 / widget.secondsInterval).floor();
  }

  bool isLoop(int value){
    return value > 10;
  }
  DateTime getDateTime() {
    int hour = currentSelectedHourIndex - _getHourCount();
    if(!widget.is24HourMode && currentSelectedAPIndex == 2) hour += 12;
    int minute = (currentSelectedMinuteIndex - (isLoop(_getMinuteCount()) ? _getMinuteCount() : 1)) * widget.minutesInterval;
    int second = (currentSelectedSecondIndex - (isLoop(_getSecondCount()) ? _getSecondCount() : 1)) * widget.secondsInterval;
    return DateTime(currentTime.year, currentTime.month, currentTime.day, hour, minute, second);
  }

  @override
  void initState() {
    currentTime = widget.time == null ? DateTime.now() : widget.time;

    currentSelectedHourIndex = (currentTime.hour % (widget.is24HourMode ? 24 : 12)) + _getHourCount();
    hourController = new ScrollController(initialScrollOffset: (currentSelectedHourIndex - 1) * widget.itemHeight );

    currentSelectedMinuteIndex = (currentTime.minute / widget.minutesInterval).floor() + (isLoop(_getMinuteCount()) ? _getMinuteCount() : 1);
    minuteController = new ScrollController(initialScrollOffset: (currentSelectedMinuteIndex - 1) * widget.itemHeight );

    currentSelectedSecondIndex = (currentTime.second / widget.secondsInterval).floor() + (isLoop(_getSecondCount()) ? _getSecondCount() : 1);
    secondController = new ScrollController(initialScrollOffset: (currentSelectedSecondIndex - 1) * widget.itemHeight );

    currentSelectedAPIndex = currentTime.hour >= 12 ? 2 : 1;
    apController = new ScrollController(initialScrollOffset: (currentSelectedAPIndex - 1) * widget.itemHeight );

    super.initState();

    if(widget.onTimeChange != null) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => widget.onTimeChange(getDateTime()));
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(minuteController.offset);
    List<Widget> contents = [
      new SizedBox(
        width: widget.itemWidth,
        height: widget.itemHeight * 3,
        child: spinner(
          hourController,
          _getHourCount(),
          currentSelectedHourIndex,
          isHourScrolling,
          1,
              (index) {
            currentSelectedHourIndex = index;
            isHourScrolling = true;
          },
              () => isHourScrolling = false,
        ),
      ),
      spacer(),
      new SizedBox(
        width: widget.itemWidth,
        height: widget.itemHeight * 3,
        child: spinner(
          minuteController,
          _getMinuteCount(),
          currentSelectedMinuteIndex,
          isMinuteScrolling,
          widget.minutesInterval,
              (index) {
            currentSelectedMinuteIndex = index;
            isMinuteScrolling = true;
          },
              () => isMinuteScrolling = false,
        ),
      ),
    ];

    if(widget.isShowSeconds){
      contents.add(spacer());
      contents.add(
          new SizedBox(
            width: widget.itemWidth,
            height: widget.itemHeight * 3,
            child: spinner(
              secondController,
              _getSecondCount(),
              currentSelectedSecondIndex,
              isSecondsScrolling,
              widget.secondsInterval,
                  (index) {
                currentSelectedSecondIndex = index;
                isSecondsScrolling = true;
              },
                  () => isSecondsScrolling = false,
            ),
          )
      );
    }

    if(!widget.is24HourMode){
      contents.add(spacer());
      contents.add(
          new SizedBox(
            width: widget.itemWidth*1.2,
            height: widget.itemHeight * 3,
            child: apSpinner(),
          )
      );
    }

    return new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: contents,
    );
  }

  Widget spacer(){
    return new Container(
      width: spacing,
      height: widget.itemHeight * 3,
    );
  }

  Widget spinner(
      ScrollController controller,
      int max,
      int selectedIndex,
      bool isScrolling,
      int interval,
      SelectedIndexCallback onUpdateSelectedIndex,
      VoidCallback onScrollEnd
      ){
    /// wrapping the spinner with stack and add container above it when it's scrolling
    /// this thing is to prevent an error causing by some weird stuff like this
    /// flutter: Another exception was thrown: 'package:flutter/src/widgets/scrollable.dart': Failed assertion: line 469 pos 12: '_hold == null || _drag == null': is not true.
    /// maybe later we can find out why this error is happening
    Widget _spinner = NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification){
        if(scrollNotification is UserScrollNotification){
          if(scrollNotification.direction.toString() == "ScrollDirection.idle") {
            if(isLoop(max)) {
              int segment = (selectedIndex / max).floor();
              if (segment == 0) {
                onUpdateSelectedIndex(selectedIndex + max);
                controller.jumpTo(controller.offset + (max * widget.itemHeight));
              }
              else if (segment == 2) {
                onUpdateSelectedIndex(selectedIndex - max);
                controller.jumpTo(controller.offset - (max * widget.itemHeight));
              }
            }
            setState(() {
              onScrollEnd();
              if(widget.onTimeChange != null) {
                widget.onTimeChange(getDateTime());
              }
            });
          }
        }
        else if (scrollNotification is ScrollUpdateNotification){
          setState(() {
            onUpdateSelectedIndex((controller.offset / widget.itemHeight).round() + 1);
          });
        }
        return true;
      },
      child: new ListView.builder(
        itemBuilder: (context, index) {
          String text = '';
          if(isLoop(max)){
            text = ((index % max) * interval).toString();
          }
          else if(index != 0 && index != max + 1){
            text = (((index - 1)  % max) * interval).toString();
          }
          if(!widget.is24HourMode && controller == hourController && text == '0'){
            text = '12';
          }
          if(widget.isForce2Digits && text != ''){
            text = text.padLeft(2, '0');
          }
          return new Container(
            height: widget.itemHeight,
            alignment: alignment,
            child: new Text(
              text,
              style: selectedIndex == index
                  ? highlightTextStyle
                  : normalTextStyle,
            ),
          );
        },
        controller: controller,
        itemCount: isLoop(max) ? max * 3 : max + 2,
        physics: ItemScrollPhysics(
            itemHeight: widget.itemHeight
        ),
        padding: EdgeInsets.zero,
      ),
    );

    return new Stack(
      children: <Widget>[
        Positioned.fill(
            child: _spinner
        ),
        isScrolling
            ? Positioned.fill(
            child: new Container(
              color: Colors.black.withOpacity(0),
            )
        )
            : new Container()
      ],
    );
  }

  Widget apSpinner(){
    Widget _spinner = NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification){
        if(scrollNotification is UserScrollNotification){
          if(scrollNotification.direction.toString() == "ScrollDirection.idle") {
            isAPScrolling = false;
            if(widget.onTimeChange != null) {
              widget.onTimeChange(getDateTime());
            }
          }
        }
        else if (scrollNotification is ScrollUpdateNotification){
          setState(() {
            currentSelectedAPIndex = (apController.offset / widget.itemHeight).round() + 1;
            isAPScrolling = true;
          });
        }
        return true;
      },
      child: new ListView.builder(
        itemBuilder: (context, index) {
          String text = index == 1 ? 'AM' : (index == 2 ? 'PM' : '');
          return new Container(
            height: widget.itemHeight,
            alignment: Alignment.center,
            child: new Text(
              text,
              style: currentSelectedAPIndex == index
                  ? highlightTextStyle
                  : normalTextStyle,
            ),
          );
        },
        controller: apController,
        itemCount: 4,
        physics: ItemScrollPhysics(
          itemHeight: widget.itemHeight,
          targetPixelsLimit: 1,
        ),
      ),
    );

    return new Stack(
      children: <Widget>[
        Positioned.fill(
            child: _spinner
        ),
        isAPScrolling
            ? Positioned.fill(
            child: new Container()
        )
            : new Container()
      ],
    );
  }

}