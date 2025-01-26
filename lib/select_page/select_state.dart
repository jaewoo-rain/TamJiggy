class SelectState {
  final List<bool> selected;
  final List<String> savedHashtags; // 저장된 해시태그 리스트 추가

  SelectState(this.selected, {this.savedHashtags = const []});

  // copyWith 메서드: 기존 상태를 기반으로 새로운 상태를 생성
  SelectState copyWith({List<bool>? selected, List<String>? savedHashtags}) {
    return SelectState(
      selected ?? this.selected,
      savedHashtags: savedHashtags ?? this.savedHashtags,
    );
  }
}
