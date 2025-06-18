import 'dart:developer';

import 'package:dio/dio.dart';

class DioErrorInterceptor extends InterceptorsWrapper {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('⛔ DIO 에러 :: ${err.type}');
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        log('⏳ 연결 시간 초과');
        break;
      case DioExceptionType.sendTimeout:
        log('⏳ 전송 시간 초과');
        break;
      case DioExceptionType.receiveTimeout:
        log('⏳ 수신 시간 초과');
        break;
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            log('🚫 잘못된 요청: ${err.response?.data}');
            break;
          case 401:
            log('🚫 인증 실패: ${err.response?.data}');
            break;
          case 403:
            log('🚫 권한 없음: ${err.response?.data}');
            break;
          case 404:
            log('🚫 리소스 없음: ${err.response?.data}');
            break;
          case 500:
            log('🚫 서버 오류: ${err.response?.data}');
            break;
          default:
            log('🚫 기타 오류: ${err.response?.data}');
            break;
        }
      case DioExceptionType.cancel:
        log('❌ 요청 취소됨');
        break;
      case DioExceptionType.connectionError:
        log('🚫 인터넷 연결 오류: ${err.message}');
        break;
      case DioExceptionType.unknown:
      default:
        log('❓ 알 수 없는 에러: ${err.message}');
    }
    handler.next(err);
  }
}
