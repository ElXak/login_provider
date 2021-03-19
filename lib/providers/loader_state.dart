enum ViewState {
  Idle,
  Busy,
}

abstract class LoaderState {
  ViewState _state = ViewState.Idle;
  void setState(ViewState viewState);
}
