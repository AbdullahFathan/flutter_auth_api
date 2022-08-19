part of 'qoutes_bloc.dart';

@immutable
abstract class QoutesState {}

class QoutesInitial extends QoutesState {}

class QuotesSuccess extends QoutesState {}

class QuotesEror extends QoutesState {}

class QuotesLoading extends QoutesState {}
