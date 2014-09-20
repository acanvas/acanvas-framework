part of rockdot_dart;



/**
	 * Copyright (2012 as c), Jung von Matt/Neckar
	 * All rights reserved.
	 *
	 * @author danielhuebschmann
	 * @since 16.01.2012 18:10:16
	 */
class Calendar extends SpriteComponent {

  num _firstDay = 0; //1=Sunday, 0=Monday
  List monthNames = ["Januar", "Februar", "März", "April", "Mai", "Juni", "Juli", "August", "September", "Oktober", "November", "Dezember"];
  List dayButtons = [];
  int dayButtonGap = 1;
  int dayButtonWidth = 30;
  int dayButtonHeight = 30;
  UITextField _dateLabel;
  Sprite dayButtonHolder;

  num _month;
  num _year;
  num _day;
  Calendar() : super() {

    dayButtonHolder = new Sprite();
    dayButtonHolder.x = 0;
    dayButtonHolder.y = 35;
    addChild(dayButtonHolder);

    //addItems();
    //setDate(new DateTime.now());
  }

  /**
		 * Override this method for new ui.
		 * All day-Buttons should be.added into the dayButtons-List (user your own buttons if needed)
		 * Create and position all other buttons you need, for example prevMonth, nextMonth, prevYear, nextYear and use appropriate functions
		 * Use _dateLabel to show active month and year, for example "Januar 2012"
		 * 
		 */
  void addItems() {
    for (int i = 0; i < 6; i++) {
      for (int j = 0; j < 7; j++) {
        DayButton btn = new DayButton(j.toString(), dayButtonWidth, dayButtonHeight);
        btn.addEventListener(MouseEvent.CLICK, onDayButtonClick);
        btn.x = j * (dayButtonWidth + dayButtonGap);
        btn.y = i * (dayButtonHeight + dayButtonGap);
        dayButtonHolder.addChild(btn);
        dayButtons.add(btn);
      }
    }

    NextPrevButton prevYearButton = new NextPrevButton("«", 30, 30);
    prevYearButton.x = 0;
    prevYearButton.y = 0;
    prevYearButton.addEventListener(MouseEvent.CLICK, onPrevYearButtonClick);
    addChild(prevYearButton);

    NextPrevButton nextYearButton = new NextPrevButton("»", 30, 30);
    nextYearButton.x = (dayButtonHolder.x + dayButtonHolder.width - nextYearButton.width).floor();
    nextYearButton.y = 0;
    nextYearButton.addEventListener(MouseEvent.CLICK, onNextYearButtonClick);
    addChild(nextYearButton);

    NextPrevButton prevMonthButton = new NextPrevButton("<", 30, 30);
    prevMonthButton.x = (prevYearButton.x + prevYearButton.width).floor() + 1;
    prevMonthButton.y = 0;
    prevMonthButton.addEventListener(MouseEvent.CLICK, onPrevMonthButtonClick);
    addChild(prevMonthButton);

    NextPrevButton nextMonthButton = new NextPrevButton(">", 30, 30);
    nextMonthButton.x = (nextYearButton.x - nextMonthButton.width).floor() - 1;
    nextMonthButton.y = 0;
    nextMonthButton.addEventListener(MouseEvent.CLICK, onNextMonthButtonClick);
    addChild(nextMonthButton);

    TextFormat fm = new TextFormat("Arial", 18, 0xFF000000);
    fm.align = TextFormatAlign.CENTER;
    _dateLabel = new UITextField("22", fm);
    _dateLabel.width = (nextMonthButton.x - prevMonthButton.x).floor();
    _dateLabel.wordWrap = false;
    _dateLabel.multiline = false;
    _dateLabel.autoSize = TextFieldAutoSize.CENTER;
    _dateLabel.x = (prevMonthButton.x + 20).floor();
    _dateLabel.y = 4;
    addChild(_dateLabel);
  }

  int getLastDayOfMonth(num month, num year) {
    switch (month - 1) {
      case 0: // jan
      case 2: // mar
      case 4: // may
      case 6: // july
      case 7: // aug
      case 9: // oct
      case 11: // dec
        return 31;
      case 1: // feb
        if ((year % 400 == 0) || ((year % 100 != 0) && (year % 4 == 0))) return 29;
        return 28;
      default:
        break;
    }
    // april, june, sept, nov.
    return 30;
  }



  ///////////////////////////////////
  //  methods
  ///////////////////////////////////

  void setDate(DateTime date) {
    _year = date.year;
    _month = date.month;
    _day = date.day;

    int firstDay = new DateTime(_year, _month, _firstDay).weekday;
    firstDay = firstDay == 7 ? 0 : firstDay;
    int lastDay = getLastDayOfMonth(_month, _year);

    for (int i = 0; i < 42; i++) {
      dayButtons[i].visible = false;
    }

    for (int j = 0; j < lastDay; j++) {
      DayButton btn = dayButtons[j + firstDay];
      btn.visible = true;
      btn.label = (j + 1).toString();
      btn.tag = j + 1;
    }

    if (_dateLabel != null) _dateLabel.text = monthNames[_month - 1] + " $_year";
  }

  void setYearMonthDay(int year, int month, int day) {
    setDate(new DateTime(year, month, day));
  }



  ///////////////////////////////////
  // event handlers
  ///////////////////////////////////

  void onPrevYearButtonClick(MouseEvent event) {
    _year--;
    _day = /*Math.*/min(_day, getLastDayOfMonth(_month, _year));
    setYearMonthDay(_year, _month, _day);

  }

  void onPrevMonthButtonClick(MouseEvent event) {
    _month--;
    if (_month < 1) {
      _month = 12;
      _year--;
    }
    _day = /*Math.*/min(_day, getLastDayOfMonth(_month, _year));
    setYearMonthDay(_year, _month, _day);
  }

  void onNextMonthButtonClick(MouseEvent event) {
    _month++;
    if (_month > 12) {
      _month = 1;
      _year++;
    }
    _day = /*Math.*/min(_day, getLastDayOfMonth(_month, _year));
    setYearMonthDay(_year, _month, _day);
  }

  void onNextYearButtonClick(MouseEvent event) {
    _year++;
    _day = /*Math.*/min(_day, getLastDayOfMonth(_month, _year));
    setYearMonthDay(_year, _month, _day);
  }

  void onDayButtonClick(MouseEvent event) {
    _day = (event.target as DayButton).tag;
    setYearMonthDay(_year, _month, _day);
  }



  ///////////////////////////////////
  // getter/setters
  ///////////////////////////////////

  DateTime get selectedDate {
    return new DateTime(_year, _month, _day);
  }

  int get month {
    return _month;
  }

  int get year {
    return _year;
  }

  int get day {
    return _day;
  }
}
