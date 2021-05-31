// Nơi định nghĩa cá String sử dụng trong app
class AppStr {
  static const String appName = 'Tên App';

  //label
  static final String notify = 'Thông báo';
  static final String receiveNotify = 'Nhận thông báo';
  static final String cancel = 'Hủy';
  static final String paste = 'Dán';
  static final String filter = 'Lọc';
  static final String error = 'Lỗi';
  static final String next = 'Tiếp';
  static final String skip = 'Bỏ qua';
  static final String close = "Đóng";
  static final String accept = "Đồng ý";
  static final String scan = "Quét";
  static final String exitsApp = 'Chạm lần nữa để thoát';
  static const String dataEmpty = "Không có dữ liệu";
  static final String viewAll = 'Xem tất cả';
  static final String errorFile = 'Lỗi khi xử lý file';
  static final String invoice = 'Hóa đơn';
  static final String search = 'Tra cứu';
  static final String account = 'Tài khoản:';
  static final String hello = 'Xin chào!';
  static final String phone = 'Số điện thoại';
  static final String email = 'Email';
  static final String password = 'Mật khẩu';
  static final String forgotPassword = 'Quên mật khẩu?';
  static final String rePassword = 'Nhập lại mật khẩu';
  static final String openSettings = 'Mở cài đặt';
  static final String exitApp = 'Chạm lần nữa để thoát';
  static final String delete = "Xóa";
  static final String help = "Trợ giúp";
  static final String home = "Trang chủ";
  static final String person = "Cá nhân";
  static final String sendEmail = "Gửi email";

  // filter
  static final String formNumber = 'Mẫu số';
  static final String signText = 'Kí hiệu';
  static final String timeText = 'Thời gian';
  static final String statusText = 'Trạng thái';
  static final String applyText = 'Áp dụng';

  /// nên tách ra nội dung ở các `Page`
  //home
  static final String homeHotArticle = 'Tin nổi bật';
  static final String homeArticle = 'Tin tức mới';
  static final String article = 'Tin tức';
  static final String homeTitle = 'Trang chủ';
  static final String accountTitle = 'Tài khoản';

  //login
  static final String loginBtn = "Đăng nhập";
  static final String logoutBtn = "Đăng xuất";

  //câu thông báo error
  static const String errorConnectTimeOut =
      'Không có phản hồi từ hệ thống, Quý khách vui lòng thử lại sau';
  static const String errorInternalServer =
      'Lỗi xử lý hệ thống\nQuý khách vui lòng thử lại sau!!!';
  static const String error502 =
      'Server đang bảo trì. Quý khách vui lòng quay lại sau.';
  static const String error503 =
      'Server đang bảo trì. Quý khách vui lòng quay lại sau một vài phút.';
  static const String error404 =
      'Không tìm thấy đường dẫn này, xin vui lòng liên hệ Admin';
  static const String error401 =
      'Phiên đăng nhập đã hết hạn. Quý khách vui lòng đăng nhập lại';
  static const String error400 = 'Dữ liệu gửi đi không hợp lệ!';
  static const String errorConnectFailed = 'Connection failed';
  static const String errorConnectFailedStr =
      'Không thể kết nối tới máy chủ\nQuý khách vui lòng kiểm tra lại kết nối mạng';
  static const String errorPermission =
      'Bạn chưa cấp đầy đủ quyền Camera hoặc bộ nhớ để thực hiện chức năng này!';

  //đường dẫn ảnh image
  static final imgLogoEI = 'assets/images/logoEI.png';
  static final imgError = 'assets/images/error.jpg';
}
