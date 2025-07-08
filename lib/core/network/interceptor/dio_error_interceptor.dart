import 'package:dio/dio.dart';

class DioErrorInterceptor extends InterceptorsWrapper {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('⛔ DIO 에러 :: ${err.type}');
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        print('⏳ 연결 시간 초과');
        break;
      case DioExceptionType.sendTimeout:
        print('⏳ 전송 시간 초과');
        break;
      case DioExceptionType.receiveTimeout:
        print('⏳ 수신 시간 초과');
        break;
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            print('🚫 잘못된 요청: ${err.response?.data}');
            break;
          case 401:
            print('🚫 인증 실패: ${err.response?.data}');
            break;
          case 403:
            print('🚫 권한 없음: ${err.response?.data}');
            break;
          case 404:
            print('🚫 리소스 없음: ${err.response?.data}');
            break;
          case 500:
            print('🚫 서버 오류: ${err.response?.data}');
            break;
          default:
            print('🚫 기타 오류: ${err.response?.data}');
            break;
        }
      case DioExceptionType.cancel:
        print('❌ 요청 취소됨');
        break;
      case DioExceptionType.connectionError:
        print('🚫 인터넷 연결 오류: ${err.message}');
        break;
      case DioExceptionType.unknown:
      default:
        print('❓ 알 수 없는 에러: ${err.message}');
    }
    handler.next(err);
  }
}
