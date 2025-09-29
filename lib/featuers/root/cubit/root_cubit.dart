// root_cubit.dart
import 'package:bloc/bloc.dart';

part 'root_state.dart';

class RootCubit extends Cubit<RootState> {
  int rootIndex = 0;
  bool showSubMenu = false;

  /// عناصر القوائم الفرعية لكل تبويب (إن وجد)
  final Map<int, List<String>> subMenuItems = {
    2: ['Orders - Pending', 'Orders - History'],
    3: ['Electronics', 'Clothes', 'Books'],
  };

  RootCubit() : super(RootInitial());

  /// إذا بدك نفس السلوك القديم (مجرّد تغيير صفحة)
  void changePageIndex(int pageIndex) {
    if (rootIndex != pageIndex) {
      rootIndex = pageIndex;
      showSubMenu = false;
      emit(ChangeIndexState(rootIndex));
    }
  }

  /// منطق الضغط على أيقونة الشريط السفلي مع دعم submenu
  void onIconTap(int index) {
    final hasSub = subMenuItems.containsKey(index);

    if (rootIndex == index && hasSub) {
      // قلب إظهار القائمة الفرعية
      showSubMenu = !showSubMenu;
      emit(ToggleSubmenuState(showSubMenu));
    } else {
      // غيّر الصفحة واظهر القائمة الفرعية إن وُجدت
      rootIndex = index;
      showSubMenu = hasSub;
      emit(ChangeIndexState(rootIndex));
      if (hasSub) emit(ToggleSubmenuState(showSubMenu));
    }
  }

  /// عند اختيار عنصر فرعي
  void onSubItemTap(String item) {
    // نفذ المطلوب (فلترة/تنقّل...) حسب مشروعك
    // بعدها سكّر القائمة الفرعية
    showSubMenu = false;
    emit(ToggleSubmenuState(showSubMenu));
  }
}
