import 'package:dio/dio.dart';

class Resource<T> {
  final T? data;
  final DioException? dio;

  Resource({this.data, this.dio});
}

class Success<T> extends Resource<T> {
  Success(T data) : super(data: data);
}

class Error<T> extends Resource<T> {
  Error(DioException dio, {super.data}) : super(dio: dio);
}

class Loading<T> extends Resource<T> {
  Loading({super.data});
}
