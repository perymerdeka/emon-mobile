import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../data/services/category_service.dart';
import '../../data/models/category_model.dart';

class CategoryController extends GetxController {
  final CategoryService _categoryService = CategoryService();

  // Observable variables
  final isLoading = false.obs;
  final categories = <Category>[].obs;
  final incomeCategories = <Category>[].obs;
  final expenseCategories = <Category>[].obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  // Load all categories
  Future<void> loadCategories() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await _categoryService.getCategories();

      if (response.success && response.data != null) {
        categories.value = response.data!;

        // Separate income and expense categories
        incomeCategories.value = categories
            .where((category) => category.type == CategoryType.income)
            .toList();

        expenseCategories.value = categories
            .where((category) => category.type == CategoryType.expense)
            .toList();
      } else {
        errorMessage.value = response.message ?? 'Gagal memuat kategori';
        Get.snackbar(
          'Error',
          response.message ?? 'Gagal memuat kategori',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.colorScheme.onError,
        );
      }
    } catch (e) {
      errorMessage.value = 'Terjadi kesalahan: ${e.toString()}';
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Create new category
  Future<void> createCategory(CategoryCreateRequest request) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await _categoryService.createCategory(request);

      if (response.success && response.data != null) {
        // Add new category to list
        categories.add(response.data!);

        // Update income/expense lists
        if (response.data!.type == CategoryType.income) {
          incomeCategories.add(response.data!);
        } else {
          expenseCategories.add(response.data!);
        }

        Get.snackbar(
          'Sukses',
          'Kategori berhasil dibuat',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.primary,
          colorText: Get.theme.colorScheme.onPrimary,
        );
      } else {
        errorMessage.value = response.message ?? 'Gagal membuat kategori';
        Get.snackbar(
          'Error',
          response.message ?? 'Gagal membuat kategori',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.colorScheme.onError,
        );
      }
    } catch (e) {
      errorMessage.value = 'Terjadi kesalahan: ${e.toString()}';
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Update category
  Future<void> updateCategory(int id, CategoryUpdateRequest request) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await _categoryService.updateCategory(id, request);

      if (response.success && response.data != null) {
        // Update category in list
        final index = categories.indexWhere((cat) => cat.id == id);
        if (index != -1) {
          categories[index] = response.data!;

          // Update income/expense lists
          _updateCategoryLists();
        }

        Get.snackbar(
          'Sukses',
          'Kategori berhasil diperbarui',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.primary,
          colorText: Get.theme.colorScheme.onPrimary,
        );
      } else {
        errorMessage.value = response.message ?? 'Gagal memperbarui kategori';
        Get.snackbar(
          'Error',
          response.message ?? 'Gagal memperbarui kategori',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.colorScheme.onError,
        );
      }
    } catch (e) {
      errorMessage.value = 'Terjadi kesalahan: ${e.toString()}';
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Delete category
  Future<void> deleteCategory(int id) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await _categoryService.deleteCategory(id);

      if (response.success) {
        // Remove category from list
        categories.removeWhere((cat) => cat.id == id);

        // Update income/expense lists
        _updateCategoryLists();

        Get.snackbar(
          'Sukses',
          'Kategori berhasil dihapus',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.primary,
          colorText: Get.theme.colorScheme.onPrimary,
        );
      } else {
        errorMessage.value = response.message ?? 'Gagal menghapus kategori';
        Get.snackbar(
          'Error',
          response.message ?? 'Gagal menghapus kategori',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.colorScheme.onError,
        );
      }
    } catch (e) {
      errorMessage.value = 'Terjadi kesalahan: ${e.toString()}';
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Update income and expense category lists
  void _updateCategoryLists() {
    incomeCategories.value = categories
        .where((category) => category.type == CategoryType.income)
        .toList();

    expenseCategories.value = categories
        .where((category) => category.type == CategoryType.expense)
        .toList();
  }

  // Get category by ID
  Category? getCategoryById(int id) {
    try {
      return categories.firstWhere((cat) => cat.id == id);
    } catch (e) {
      return null;
    }
  }

  // Refresh categories
  Future<void> refreshCategories() async {
    await loadCategories();
  }
}
