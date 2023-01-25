part of 'identity_cubit.dart';

@immutable
abstract class IdentityState {}

class IdentityInitial extends IdentityState {}

class IdentitySuccess extends IdentityState {
  final List<Data>? listIdentity;
  final int? currentPage;
  final int? amountPage;
  IdentitySuccess(this.currentPage, this.amountPage, this.listIdentity);
}

class IdentityFailed extends IdentityState {
  final String message;
  IdentityFailed(this.message);
}

class IdentityLoading extends IdentityState {}
