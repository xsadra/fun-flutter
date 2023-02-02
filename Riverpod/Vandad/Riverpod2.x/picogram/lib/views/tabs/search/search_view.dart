import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../lib.dart' show DismissKeyboard, SearchGridView, Strings;

class SearchView extends HookConsumerWidget {
  const SearchView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();

    final searchTerm = useState('');
    useEffect(() {
      controller.addListener(() {
        searchTerm.value = controller.text;
      });
      return () {};
    }, [controller]);

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: controller,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                labelText: Strings.enterYourSearchTermHere,
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.clear();
                    dismissKeyboard();
                  },
                  icon: const Icon(Icons.clear),
                ),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SearchGridView(searchTerm: searchTerm.value),
          ),
        ],
      ),
    );
  }
}
