import 'package:base_flutter_bloc/base/base.dart';
import 'package:base_flutter_bloc/base/locator/get_it.dart';
import 'package:base_flutter_bloc/const/all_const.dart';
import 'package:base_flutter_bloc/feature/home/notifycation/model/notify_model.dart';
import 'package:base_flutter_bloc/feature/home/notifycation/model/notify_response.dart';

class LoginRepository {
  final BaseRequest baseRequest = GetIt.I<
      BaseRequest>(); // dùng để gọi đến Instance đã đc khởi tạo từ trước

  Future<NotifyResponse> getNotifyData(NotifyModel notifyModel) async {
    Map<String, String> jsonMap = {
      "KieuSapXep": notifyModel.sortType,
      "khoangThoiGian": notifyModel.time,
    };

    var response = await baseRequest
        .sendRequest(AppConst.urlNotify, RequestMethod.POST, jsonMap: jsonMap);
    return NotifyResponse.fromJson(response);
  }

  Future getNotifyTest(NotifyModel notifyModel) async {
    Map<String, String> jsonMap = {
      "KieuSapXep": notifyModel.sortType,
      "khoangThoiGian": notifyModel.time,
    };

    var response = await baseRequest
        .sendRequest(AppConst.urlNotify, RequestMethod.POST, jsonMap: jsonMap);
    return response;
  }
}
