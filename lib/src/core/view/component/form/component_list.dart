part of rockdot_dart;


/**
	 * @author Nils Doehring (nilsdoehring@gmail.com)
	 */
class ComponentList extends ComponentScrollable {
  //
  Type _cellClass;
  bool _constantCellSize = false;
  num _cellSize = 0;
  int _bufferSize = 20;
  Cell _mouseDownCell;
  bool _cellMoved = false;
  bool _initialized = false;
  Map _cellSelectedLookup;
  List _reusableCellPool;
  int _cellsLoaded = 0;
  int _padding = 0;
  int _scrollPos = 0;
  int _totalViewSize = 0;
  int _oldVScrollbarValue = 0;
  Timer _timer;

  List data;
  num _originX = 0;
  num _originY = 0;

  ComponentList(String orientation, Type cellClass, Type scrollbarClass, bool constantCellSize) {
    _cellClass = cellClass;
    _reusableCellPool = [];
    _constantCellSize = constantCellSize;
    superConstructor(orientation, new SpriteComponent(), scrollbarClass);
  }

  @override
  void redraw() {
    int i;
    int n = cellContainer.numChildren;
    Cell cell;
/*
    for (i = 0; i < n; i++) {
      cell = (cellContainer.getChildAt(i) as Cell);
      cell.setSize(widthAsSet, heightAsSet);
    }
*/
    super.redraw();
    _updateCells();
  }

  void setData(List dta) {
    data = dta;
    init();
  }

  void init() {
    if(_frame.width == 10 || _frame.height == 10){
      return;
    }
    _initialized = true;
    
    _totalViewSize = 0;
    _cellSelectedLookup = new Map();
    _cellsLoaded = 0;
    int numDataEntries = data.length;
    Cell cell;
    int fromIndex = _cellsLoaded;
    int i;

    // Constant cell height
    if (_constantCellSize) {
      cell = _getCell();
     
      cell.id = 0;
      cell.data = data.elementAt(0);
      cellContainer.addChild(cell);

      _cellSelectedLookup[0] = false;
      Scrollbar scroller = (_bOrientationHorizontal ? _hScrollbar : _vScrollbar);

      _cellSize = (_bOrientationHorizontal ? cell.widthAsSet : cell.heightAsSet) + _padding;
      _totalViewSize = (numDataEntries * _cellSize - _padding).round();
      _cellsLoaded = numDataEntries;
      int cellsInFrame = ((_bOrientationHorizontal ? _frame.width : _frame.height) / _cellSize).ceil();
      for (i = 1; i < numDataEntries; i++) {
        if (i < cellsInFrame) {
          cell = _getCell();
          cell.id = i;
          cell.data = data.elementAt(i);
          _bOrientationHorizontal ? cell.x = i * _cellSize : cell.y = i * _cellSize;

          cellContainer.addChild(cell);
         // _cellsLoaded++;
        }
        _cellSelectedLookup[i] = false;

      }
    } else {
      // Variable cell height
      for (i = fromIndex; i < _bufferSize; i++) {
        if (i < numDataEntries) {
          if (i == fromIndex) _scrollPos = -_totalViewSize;
          cell = _getCell();
          cell.id = i;
          cell.data = data.elementAt(i);
          if (_totalViewSize < (_bOrientationHorizontal ? _frame.width : _frame.height)) {
            // Show cell
            _bOrientationHorizontal ? cell.x = _totalViewSize : cell.y = _totalViewSize;
            _totalViewSize += ((_bOrientationHorizontal ? cell.widthAsSet : cell.heightAsSet)).round() + _padding;
            cellContainer.addChild(cell);
          } else {
            // Only precalculate cell height
            _totalViewSize += ((_bOrientationHorizontal ? cell.widthAsSet : cell.heightAsSet)).round() + _padding;
            _putCellInPool(cell);
          }
          _cellSelectedLookup[i] = false;
          _cellsLoaded++;
        }
      }
      _totalViewSize -= _padding;
    }
    redraw();
    if ((_bOrientationHorizontal ? _hScrollbar : _vScrollbar).enabled) (_bOrientationHorizontal ? _hScrollbar : _vScrollbar).value = -_scrollPos;
  }


  @override
  void destroy() {

    stage.removeEventListener(MouseEvent.MOUSE_UP, _onStageMouseUp);
    stage.removeEventListener(MouseEvent.MOUSE_MOVE, _onStageMouseMove);

    super.destroy();
  }


  void _calcNextCells() {
    if (data == null) {
      return;
    }

    int numDataEntries = data.length;
    Cell cell;
    int fromIndex = _cellsLoaded;
    int n = _cellsLoaded + _bufferSize;
    for (int i = fromIndex; i < n; i++) {
      if (i < numDataEntries) {
        cell = _getCell();
        cell.id = i;
        cell.data = data.elementAt(i);

        // Only precalculate cell height
        _totalViewSize += ((_bOrientationHorizontal ? cell.widthAsSet : cell.heightAsSet)).round() + _padding;
        _putCellInPool(cell);
        _cellSelectedLookup[i] = false;
        _cellsLoaded++;
      }
    }
    updateScrollbars();
  }


  void jumpToCell(int nr) {
    _vScrollbar.killPageTween();
    clearMomentum();
    (_bOrientationHorizontal ? _hScrollbar : _vScrollbar).interactionStart();
    if (_constantCellSize) {
      if ((_bOrientationHorizontal ? _hScrollbar : _vScrollbar).enabled) (_bOrientationHorizontal ? _hScrollbar : _vScrollbar).value = nr * _cellSize;
    } else {
      if ((_bOrientationHorizontal ? _hScrollbar : _vScrollbar).enabled) {
        Cell cell;
        int targetPos;
        cell = _getCell();
        for (int i = 0; i < nr; i++) {
          cell.id = i;
          cell.data = data.elementAt(i);
          targetPos += ((_bOrientationHorizontal ? cell.widthAsSet : cell.heightAsSet) + _padding).round();
        }

        int safetyFlag = -1;
        while ((_bOrientationHorizontal ? _hScrollbar : _vScrollbar).value != targetPos) {
          if (safetyFlag != (_bOrientationHorizontal ? _hScrollbar : _vScrollbar).value) {
            safetyFlag = (_bOrientationHorizontal ? _hScrollbar : _vScrollbar).value;
            (_bOrientationHorizontal ? _hScrollbar : _vScrollbar).value = targetPos;
          } else {
            break;
          }
        }
      }
    }
    (_bOrientationHorizontal ? _hScrollbar : _vScrollbar).interactionEnd();
  }


  @override
  void updateScrollbars() {
    if (_orientation == Orientation.HORIZONTAL) {
      _hScrollbar.enabled = _totalViewSize > widthAsSet;
      _hScrollbar.maxValue = max(0, _totalViewSize - widthAsSet);
      _vScrollbar.enabled = _view.height > heightAsSet;
      _vScrollbar.maxValue = max(0, _view.height - heightAsSet);
    } else {
      _hScrollbar.enabled = _view.width > widthAsSet;
      _hScrollbar.maxValue = max(0, _view.width - widthAsSet);
      _vScrollbar.enabled = _totalViewSize > heightAsSet;
      _vScrollbar.maxValue = max(0, _totalViewSize - heightAsSet);
    }
    _updateThumbs();
  }


  @override
  void _updateThumbs() {
    if (_orientation == Orientation.HORIZONTAL) {
      _hScrollbar.pages = _totalViewSize / widthAsSet;
      _vScrollbar.pages = _view.height / heightAsSet;
    } else {
      _hScrollbar.pages = _view.width / widthAsSet;
      _vScrollbar.pages = _totalViewSize / heightAsSet;
    }
  }


  @override
  void _onHScrollbarChange(SliderEvent event) {
    if (_orientation == Orientation.VERTICAL) super._onHScrollbarChange(event); 
    else _onScrollbarChange(event);
  }


  @override
  void _onVScrollbarChange(SliderEvent event) {
    if (_orientation == Orientation.HORIZONTAL) super._onVScrollbarChange(event); 
    else _onScrollbarChange(event);
  }


  void _onScrollbarChange(SliderEvent event) {
    if (data != null) {
      _scrollPos = _oldVScrollbarValue - event.value;
      _oldVScrollbarValue = event.value;
      _updateCells();
    }
  }


  void _updateCells() {
    if(_frame.width == 10 || _frame.height == 10){
      return;
    }
    if(_initialized == false){
      init();
      return;
    }
    
    int n = cellContainer.numChildren;
    Cell cell;
    List cellsToPool = [];
    // Push not visible cells to "cellsToPool"
    for (int i = 0; i < n; i++) {
      cell = (cellContainer.getChildAt(i) as Cell);
      _bOrientationHorizontal ? cell.x += _scrollPos : cell.y += _scrollPos;
      if ((_bOrientationHorizontal ? cell.x : cell.y) + (_bOrientationHorizontal ? cell.widthAsSet : cell.heightAsSet) < 0 || (_bOrientationHorizontal ? cell.x : cell.y) > (_bOrientationHorizontal ? _frame.width : _frame.height)) cellsToPool.add(cell);
    }

    // Put collected cells in pool
    n = cellsToPool.length;
    for (int i = 0; i < n; i++) {
      _putCellInPool(cellsToPool.elementAt(i));
    }

    // Check, if scrolling up or down
    bool firstLoop;
    if (_scrollPos > 0) {
      // Scrolling up
      cell = cellContainer.numChildren != 0 ? (cellContainer.getChildAt(0) as Cell) : _getCell(true);
      firstLoop = true;
      while ((_bOrientationHorizontal ? cell.x : cell.y) > 0) {
        if (firstLoop != null) {
          if (cell.parent == null) _putCellInPool(cell);
          firstLoop = false;
        }
        cell = _unshiftNewCell(cell);
        if (cell == null) break;
        (_bOrientationHorizontal ? cell.x : cell.y) > (_bOrientationHorizontal ? _frame.width : _frame.height) ? _putCellInPool(cell) : cellContainer.addChildAt(cell, 0);
      }
    } else if (_scrollPos < 0) {
      // Scrolling down
      cell = cellContainer.numChildren != 0 ? (cellContainer.getChildAt(cellContainer.numChildren - 1) as Cell) : _getCell(true);
      firstLoop = true;

      while ((_bOrientationHorizontal ? cell.x : cell.y) + (_bOrientationHorizontal ? cell.widthAsSet : cell.heightAsSet) < (_bOrientationHorizontal ? _frame.width : _frame.height)) {
        if (firstLoop != null) {
          if (cell.parent == null) _putCellInPool(cell);
          firstLoop = false;
        }
        cell = _addNewCell(cell);
        if (cell == null) {
          print("x");
          break;
        }
        (_bOrientationHorizontal ? cell.x : cell.y) + (_bOrientationHorizontal ? cell.widthAsSet : cell.heightAsSet) < 0 ? _putCellInPool(cell) : cellContainer.addChild(cell);
      }
    } else {

      // TODO: FIXME: Schaune, ob nach unten oder oben angebaut werden muss

      // Just update (e.g. render()) 
      cell = cellContainer.numChildren != 0 ? (cellContainer.getChildAt(0) as Cell) : _getCell(true);
      firstLoop = true;
      while ((_bOrientationHorizontal ? cell.x : cell.y) > 0) {
        if (firstLoop) {
          if (cell.parent == null) _putCellInPool(cell);
          firstLoop = false;
        }
        cell = _unshiftNewCell(cell);
        if (cell == null) break;
        (_bOrientationHorizontal ? cell.x : cell.y) > (_bOrientationHorizontal ? _frame.width : _frame.height) ? _putCellInPool(cell) : cellContainer.addChildAt(cell, 0);
      }
      cell = cellContainer.numChildren != 0 ? (cellContainer.getChildAt(cellContainer.numChildren - 1) as Cell) : _getCell(true);
      
      firstLoop = true;
      while ((_bOrientationHorizontal ? cell.x : cell.y) + (_bOrientationHorizontal ? cell.widthAsSet : cell.heightAsSet) < (_bOrientationHorizontal ? _frame.width : _frame.height)) {
        if (firstLoop) {
          if (cell.parent == null) _putCellInPool(cell);
          firstLoop = false;
        }
        cell = _addNewCell(cell);
        if (cell == null) break;
        (_bOrientationHorizontal ? cell.x : cell.y) + (_bOrientationHorizontal ? cell.widthAsSet : cell.heightAsSet) < 0 ? _putCellInPool(cell) : cellContainer.addChild(cell);
      }
    }

    if (_oldVScrollbarValue >= (_bOrientationHorizontal ? _hScrollbar : _vScrollbar).maxValue) {
      _calcNextCells();
    }
  }


  @override
  void _addScrollbars() {
    super._addScrollbars();

    // H
    if (_hScrollbar != null) {
      _hScrollbar.maxValue = _totalViewSize - widthAsSet;
    }

    // V
    if (_vScrollbar != null) {
      _vScrollbar.maxValue = _totalViewSize - heightAsSet;
    }
  }


  Cell _addNewCell(Cell oldCell) {
    if (oldCell.id+1 >= data.length) return null;

    Cell newCell = _getCell();
    newCell.id = oldCell.id + 1;
    newCell.data = data[newCell.id];
    newCell.visible = newCell.data != null;
    _cellSelectedLookup[newCell.id] != null ? newCell.select() : newCell.deselect();

    num pos = ((_bOrientationHorizontal ? oldCell.x : oldCell.y) + (_bOrientationHorizontal ? oldCell.widthAsSet : oldCell.heightAsSet)).round() + _padding;
    _bOrientationHorizontal ? newCell.x = pos : newCell.y = pos;

    return newCell;
  }


  Cell _unshiftNewCell(Cell oldCell) {
    Cell newCell = _getCell();
    newCell.id = oldCell.id - 1;
    newCell.data = data[newCell.id];
    newCell.visible = newCell.data != null;
    _cellSelectedLookup[newCell.id] != null ? newCell.select() : newCell.deselect();

    num pos = ((_bOrientationHorizontal ? oldCell.x : oldCell.y) - (_bOrientationHorizontal ? newCell.widthAsSet : newCell.heightAsSet)).round() - _padding;
    _bOrientationHorizontal ? newCell.x = pos : newCell.y = pos;

    return newCell;

    // if (_data[oldCell.id - 1] == undefined) return null;
    // Cell newCell = _getCell();
    // newCell.id = oldCell.id - 1;
    // newCell.data = _data[newCell.id];
    // _cellSelectedLookup[newCell.id] ? newCell.select() : newCell.deselect();
    // newCell[POS] = round(oldCell[POS] - newCell[SIZE]) - _padding;
    // return newCell;
  }


  Cell _getCell([bool pop = false]) {
    Cell cell;
    if (_reusableCellPool.length == 0) {
      cell = reflectClass(_cellClass).newInstance(new Symbol(""), [widthAsSet]).reflectee;
      //cell.setSize(widthAsSet, heightAsSet);
      cell.mouseChildren = false;
      cell.addEventListener(MouseEvent.MOUSE_DOWN, _onCellMouseDown, useCapture: false, priority: 0);
      cell.addEventListener(MouseEvent.MOUSE_UP, _onCellMouseUp, useCapture: false, priority: 0);
      cell.submitCallback = _onCellSelected;
      return cell;
    }
    cell = pop ? _reusableCellPool.removeLast() : _reusableCellPool.removeAt(0);
    //cell.setSize(widthAsSet, heightAsSet);
    return cell;
  }


  void _onCellMouseDown(MouseEvent event) {
    _cellMoved = false;

    _originX = stage.mouseX;
    _originY = stage.mouseY;

    _mouseDownCell = (event.currentTarget as Cell);
    if(_timer != null) {
      _timer.cancel();
    }
    _timer = new Timer(new Duration(milliseconds: 100), _onDelayedCellMouseDown);
  }


  void _onDelayedCellMouseDown() {
    if (_mouseDownCell != null) _mouseDownCell.select();
  }


  void _onCellMouseUp(MouseEvent event) {
    if (!_cellMoved && _mouseDownCell != null) {
      _mouseDownCell.select();
      _submitCallback.call(_mouseDownCell);
    }
    _mouseDownCell = null;
  }


  void _putCellInPool(Cell cell) {
    if (cell.parent != null) cell.parent.removeChild(cell);
    _reusableCellPool.add(cell);
    _cellSelectedLookup[cell.id] = cell.isSelected;
  }


  void deselectAllCells([int exception = -1]) {
    int n = cellContainer.numChildren;
    Cell cell;
    for (int i = 0; i < n; i++) {
      cell = (cellContainer.getChildAt(i) as Cell);
      if (cell.id != exception) cell.deselect();
    }

    n = _cellSelectedLookup.length;
    for (int i = 0; i < n; i++) {
      _cellSelectedLookup[i] = false;
    }
  }


  @override
  void _onViewMouseDown(MouseEvent event) {
    _touching = true;
    if (_hScrollbar.enabled) {
      _hScrollbar.interactionStart(false, false);
      _mouseOffsetX = stage.mouseX + _hScrollbar.value;
    } else {
      _mouseOffsetX = stage.mouseX;
    }

    if (_vScrollbar.enabled) {
      _vScrollbar.interactionStart(false, false);
      _mouseOffsetY = stage.mouseY + _vScrollbar.value;
    } else {
      _mouseOffsetY = stage.mouseY;
    }

    stage.addEventListener(MouseEvent.MOUSE_UP, _onStageMouseUp, useCapture: false, priority: 0);
    stage.addEventListener(MouseEvent.MOUSE_MOVE, _onStageMouseMove, useCapture: false, priority: 0);
  }


  @override
  void _onStageMouseMove(MouseEvent event) {
    super._onStageMouseMove(event);

    if ((_originX - stage.mouseX).abs() > 3 || (_originY - stage.mouseY).abs() > 3) {
      _cellMoved = true;
      _timer.cancel();
      if (_mouseDownCell != null) _mouseDownCell.deselect();
    }

  }


  void _onCellSelected([Cell cell = null]) {
    if (cell != null) {
      deselectAllCells(cell.id);
    }
  }


  SpriteComponent get cellContainer {
    return _view;
  }


  int get padding {
    return _padding;
  }


  void set padding(int padding) {
    _padding = padding;
  }


  int get bufferSize {
    return _bufferSize;
  }


  void set bufferSize(int bufferSize) {
    _bufferSize = bufferSize;
  }



}
