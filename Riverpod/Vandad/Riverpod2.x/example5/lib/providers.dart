import 'package:example5/data_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final peopleProvider = ChangeNotifierProvider(
  (ref) => DataModel(),
);
