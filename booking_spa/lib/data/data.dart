import 'package:booking_spa/models/service_model.dart';

import '../../constants/image.dart';

class Data {
  Data._();
  // Data example for welcome
  static const dataWelcome = [
    {
      'image': AppImage.welcome1,
      'title': 'Sắc Đẹp',
      'sub':
          'Trải nghiệm các liệu pháp làm đẹp cao cấp, giúp làn da bạn rạng rỡ và trẻ trung với sản phẩm tự nhiên và công nghệ hiện đại.',
    },
    {
      'image': AppImage.welcome2,
      'title': "Sức Khỏe",
      'sub':
          'Thư giãn với các liệu pháp massage, xông hơi và yoga, giúp giảm căng thẳng và tăng cường sức khỏe toàn diện.',
    },
    {
      'image': AppImage.welcome3,
      'title': 'Không Gian Thiên Nhiên',
      'sub':
          'Thả mình vào không gian xanh mát, yên bình với vườn cây, hương thảo mộc và âm thanh thiên nhiên, đem lại sự thư thái và năng lượng mới.',
    },
  ];
  // Data example for Service
  static final dataService = [
    ServiceModel(
        keySearch: 'Cham Soc Suc Khoe',
        title: 'Chăm Sóc Sức Khỏe',
        price: 350000,
        sub:
            'Thư giãn với các liệu pháp massage chuyên sâu, xông hơi, yoga và thiền, giúp giảm căng thẳng, cải thiện tuần hoàn và tăng cường sức khỏe toàn diện.',
        image:
            'https://smartscentvn.com/wp-content/uploads/2019/05/spa-1-1-1024x684.jpg'),
    ServiceModel(
        keySearch: 'Lam Dep',
        title: 'Làm Đẹp',
        price: 220000,
        sub:
            'Trải nghiệm các liệu pháp làm đẹp hiện đại như chăm sóc da mặt, trẻ hóa toàn thân, tẩy tế bào chết và điều trị mụn, sử dụng sản phẩm tự nhiên và công nghệ tiên tiến.',
        image:
            'https://kbeauty.fpt.edu.vn/wp-content/uploads/2023/04/tai-sao-phai-cham-soc-da-mat.jpg'),
    ServiceModel(
        keySearch: 'Cham Soc Toc',
        title: 'Chăm Sóc Tóc',
        price: 150000,
        sub:
            'Tận hưởng các dịch vụ chăm sóc tóc như gội đầu dưỡng sinh, phục hồi tóc hư tổn, cắt, uốn và nhuộm tóc với các sản phẩm an toàn và kỹ thuật chuyên nghiệp.',
        image:
            'https://statics.vinpearl.com/goi-dau-duong-sinh-Nha-Trang-4_1684422986.jpg'),
    ServiceModel(
        keySearch: 'Cham Soc Mong',
        title: 'Chăm Sóc Móng',
        price: 180000,
        sub:
            'Làm đẹp móng tay và móng chân với các dịch vụ cắt tỉa, sơn gel, đắp móng và dưỡng móng, mang lại bộ móng khỏe đẹp và phong cách.',
        image:
            'https://tiki.vn/blog/wp-content/uploads/2023/03/nail-bo-sua.jpg'),
    ServiceModel(
        keySearch: 'Cham Soc Co The',
        title: 'Chăm Sóc Cơ Thể',
        price: 250000,
        sub:
            'Thư giãn với các liệu pháp tẩy tế bào chết toàn thân, dưỡng ẩm da, quấn bùn khoáng và chăm sóc vùng kín, giúp da mịn màng và cơ thể thư thái.',
        image:
            'https://thammyvienngocdung.com/wp-content/uploads/2023/12/tay-te-bao-chet-toan-than.jpg'),
    ServiceModel(
        keySearch: 'Cham Soc Ba Bau',
        title: 'Chăm Sóc Bà Bầu',
        price: 100000,
        sub:
            'Chăm sóc đặc biệt cho bà bầu với các liệu pháp massage nhẹ nhàng, chăm sóc da mặt và body, giúp mẹ bầu thư giãn và khỏe mạnh.',
        image:
            'https://easysalon.vn/wp-content/uploads/2020/09/massage-ba-bau-dung-cach-1.jpg'),
    ServiceModel(
        keySearch: 'Tham My Cong Nghe Cao',
        title: 'Thẩm Mỹ Công Nghệ Cao',
        price: 1300000,
        sub:
            'Ứng dụng công nghệ cao như laser, RF, và IPL trong các liệu trình xóa nám, tàn nhang, triệt lông, và nâng cơ, mang lại hiệu quả thẩm mỹ tối ưu.',
        image:
            'https://tti.edu.vn/wp-content/uploads/2022/08/vay-laser-trong-nganh-tham-my-nhi-the-nao.jpg'),
  ];
}
