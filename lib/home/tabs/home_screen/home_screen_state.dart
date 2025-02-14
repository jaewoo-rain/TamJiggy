abstract class HomeScreenState {}

class TravelInitial extends HomeScreenState {}

class TravelLoaded extends HomeScreenState {}

class ReviewState extends HomeScreenState {
  final List<Map<String, dynamic>> reviews;

  ReviewState(this.reviews);
}
