import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tam_jiggy/select_page/models/hashtags_model.dart';
import 'package:tam_jiggy/select_page/select_event.dart';
import 'package:tam_jiggy/select_page/select_state.dart';

class SelectBloc extends Bloc<SelectEvent, SelectState> {
  SelectBloc()
      : super(SelectState(
            List.generate(HashtagsModel().hashtags.length, (index) => false))) {
    // ToggleHashtag 이벤트 처리
    on<ToggleHashtag>((event, emit) {
      final updatedSelection = List<bool>.from(state.selected);
      updatedSelection[event.index] = !updatedSelection[event.index];
      emit(state.copyWith(selected: updatedSelection));
    });

    // SaveHashtag 이벤트 처리
    on<SaveHashtag>((event, emit) {
      // SaveHashtag 이벤트에 대한 로직 작성
      final selectedHashtags = state.selected
          .asMap()
          .entries
          .where((entry) => entry.value) // 선택된 해시태그만 필터링
          .map((entry) => event.hashtags[entry.key]) // 인덱스를 기반으로 해시태그 가져오기
          .toList();

      // 로그 출력 (디버깅용)
      print("저장된 해시태그: $selectedHashtags");

      // 상태에 따라 추가 로직 작성 가능
      emit(state.copyWith(savedHashtags: selectedHashtags));
    });
  }
}
