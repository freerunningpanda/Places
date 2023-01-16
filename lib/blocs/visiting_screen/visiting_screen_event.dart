import 'package:equatable/equatable.dart';

import 'package:places/data/model/place.dart';

abstract class VisitingScreenEvent extends Equatable {
  @override
  List<Object?> get props => [];

  const VisitingScreenEvent();
}

// Пустой список мест
class VisitingScreenLoad extends VisitingScreenEvent {}

// Добавить место в список избранного
class VisitingScreenAddToFavorites extends VisitingScreenEvent {
  final Place place;
  
  const VisitingScreenAddToFavorites({
    required this.place,
  });
}

// Добавить место в список посещённого
class VisitingScreenAddToVisited extends VisitingScreenEvent {
  final Place place;

  const VisitingScreenAddToVisited({
    required this.place,
  });
}


// Удалить место из избранного
class DeleteFromFavorites extends VisitingScreenEvent {
  final Place place;

  const DeleteFromFavorites({
    required this.place,
  });
}

// Места добавлены
class VisitingScreenLoadedEvent extends VisitingScreenEvent {}

// Получить список мест
// class VisitingScreenGetPlaces extends VisitingScreenEvent {
//   final Set<Place> sights;

//   @override
//   List<Object?> get props => [sights];

//   const VisitingScreenGetPlaces({
//     required this.sights,
//   });
// }
// // Получить список посещённых мест
// class VisitingScreenGetVisitedPlaces extends VisitingScreenEvent {
//   final Set<Place> sights;

//   @override
//   List<Object?> get props => [sights];

//   const VisitingScreenGetVisitedPlaces({
//     required this.sights,
//   });
// }

// Поменять позицию карточки в списке
// class VisitingScreenDragCard extends VisitingScreenEvent {
//   final List<Place> sights;
//   final int oldIndex;
//   final int newIndex;

//   @override
//   List<Object?> get props => [
//         sights,
//         oldIndex,
//         newIndex,
//       ];

//   const VisitingScreenDragCard({
//     required this.sights,
//     required this.oldIndex,
//     required this.newIndex,
//   });
// }

// Удалить карточку из списка
// class VisitingScreenDeleteCard extends VisitingScreenEvent {
//   final int index;
//   final List<Place> sights;

//   @override
//   List<Object?> get props => [
//         index,
//         sights,
//       ];

//   const VisitingScreenDeleteCard({
//     required this.index,
//     required this.sights,
//   });
// }
