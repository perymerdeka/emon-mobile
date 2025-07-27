import 'package:get/get.dart';

class HelpController extends GetxController {
  var isLoading = false.obs;
  var faqs = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFAQs();
  }

  void loadFAQs() {
    isLoading.value = true;

    // Simulasi API call
    Future.delayed(Duration(milliseconds: 500), () {
      faqs.value = [
        {
          'question': 'Bagaimana cara menambah transaksi baru?',
          'answer':
              'Anda dapat menambah transaksi baru dengan mengklik tombol "+" di halaman Transaksi atau melalui menu Add Transaction.',
          'isExpanded': false.obs,
        },
        {
          'question': 'Bagaimana cara mengatur budget?',
          'answer':
              'Untuk mengatur budget, buka halaman Budget Plans dan klik tombol "Add" untuk membuat budget baru.',
          'isExpanded': false.obs,
        },
        {
          'question': 'Bagaimana cara menghubungkan rekening bank?',
          'answer':
              'Buka halaman Bank Accounts, pilih bank yang ingin dihubungkan, dan ikuti langkah-langkah verifikasi.',
          'isExpanded': false.obs,
        },
        {
          'question': 'Bagaimana cara export laporan?',
          'answer':
              'Di halaman Reports, klik tombol "Export & Share" untuk mengunduh laporan dalam format PDF atau Excel.',
          'isExpanded': false.obs,
        },
        {
          'question': 'Bagaimana cara mengatur notifikasi?',
          'answer':
              'Buka halaman Profile > Settings > Notifications untuk mengatur preferensi notifikasi.',
          'isExpanded': false.obs,
        },
      ];
      isLoading.value = false;
    });
  }

  void searchHelp(String query) {
    // TODO: Implementasi pencarian FAQ
    Get.snackbar(
      'Pencarian',
      'Fitur pencarian akan segera tersedia',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void contactSupport() {
    // TODO: Implementasi kontak support
    Get.snackbar(
      'Kontak Support',
      'Fitur kontak support akan segera tersedia',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void toggleFAQ(int index) {
    if (index < faqs.length) {
      faqs[index]['isExpanded'].value = !faqs[index]['isExpanded'].value;
    }
  }
}
