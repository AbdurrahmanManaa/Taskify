part of 'attachment_cubit.dart';

sealed class AttachmentState {
  const AttachmentState();
}

final class AttachmentInitial extends AttachmentState {}

final class AttachmentLoading extends AttachmentState {}

final class AttachmentSuccess extends AttachmentState {
  final String? message;

  const AttachmentSuccess({
    this.message,
  });
}

final class AttachmentFailure extends AttachmentState {
  final String? message;

  const AttachmentFailure({this.message});
}
