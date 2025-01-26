abstract class SelectEvent {}

class ToggleHashtag extends SelectEvent {
  final int index; // 선택된 해시태그의 인덱스

  ToggleHashtag(this.index);
}

class SaveHashtag extends SelectEvent {
  final List<String> hashtags; // 저장할 해시태그 리스트

  SaveHashtag(this.hashtags);
}
