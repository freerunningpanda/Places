part of 'image_provider_cubit.dart';

class ImageProviderState extends Equatable {
  final int length;

  @override
  List<Object?> get props => [length];

  const ImageProviderState({required this.length});

  ImageProviderState copyWith({
    int? length,
  }) {
    return ImageProviderState(
      length: length ?? this.length,
    );
  }
}
