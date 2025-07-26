import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'category_controller.dart';
import 'package:emon_mobile/app/routes/app_pages.dart';

class CategoryView extends GetView<CategoryController> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final horizontalPadding = size.width * 0.04 > 24 ? 24.0 : size.width * 0.04;
    final maxContentWidth = 500.0;
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Color(0xFF181F2B)),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Categories',
          style: TextStyle(
            color: Color(0xFF181F2B),
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 18,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxContentWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Income',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFF181F2B),
                      ),
                    ),
                    SizedBox(height: 10),
                    Obx(() => _categoryCardList(controller.incomeCategories)),
                    SizedBox(height: 28),
                    Text(
                      'Expenses',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFF181F2B),
                      ),
                    ),
                    SizedBox(height: 10),
                    Obx(() => _categoryCardList(controller.expenseCategories)),
                    SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _showAddCategoryDialog();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE3F0FF),
                          elevation: 0,
                          padding: EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          'Add New Category',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF181F2B),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Color(0xFF3498F3),
        unselectedItemColor: Color(0xFF8A94A6),
        showUnselectedLabels: true,
        onTap: (index) {
          switch (index) {
            case 0:
              Get.offAllNamed(Routes.HOME);
              break;
            case 1:
              Get.offAllNamed(Routes.TRANSACTIONS);
              break;
            case 2:
              Get.offAllNamed(Routes.REPORTS);
              break;
            case 3:
              Get.offAllNamed(Routes.PROFILE);
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart_outlined),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

Widget _categoryCardList(List categories) {
  return Column(
    children: List.generate(categories.length, (i) {
      final cat = categories[i];
      return Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: cat['color'],
              child: Icon(cat['icon'], color: cat['iconColor'], size: 26),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cat['title'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF181F2B),
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    cat['desc'],
                    style: TextStyle(fontSize: 15, color: Color(0xFF8A94A6)),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => _showEditCategoryDialog(cat),
              child: Icon(Icons.edit, color: Color(0xFF8A94A6)),
            ),
          ],
        ),
      );
    }),
  );
}

void _showAddCategoryDialog() {
  Get.dialog(
    AlertDialog(
      title: Text('Add New Category'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Category Name',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Type',
              border: OutlineInputBorder(),
            ),
            items: [
              DropdownMenuItem(value: 'income', child: Text('Income')),
              DropdownMenuItem(value: 'expense', child: Text('Expense')),
            ],
            onChanged: (value) {},
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // TODO: Implement add category functionality
            Get.back();
            Get.snackbar(
              'Success',
              'Category added successfully!',
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
          },
          child: Text('Add'),
        ),
      ],
    ),
  );
}

void _showEditCategoryDialog(Map cat) {
  Get.dialog(
    AlertDialog(
      title: Text('Edit Category'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Category Name',
              border: OutlineInputBorder(),
            ),
            controller: TextEditingController(text: cat['title']),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // TODO: Implement edit category functionality
            Get.back();
            Get.snackbar(
              'Success',
              'Category updated successfully!',
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
          },
          child: Text('Save'),
        ),
      ],
    ),
  );
}
