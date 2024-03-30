// ignore_for_file: no_default_cases

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty_app/l10n/l10n.dart';

class SearchTextfield extends StatelessWidget {
  const SearchTextfield({
    this.onChanged,
    super.key,
  });

  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    const key = ValueKey('search-textfield');

    void onTapOutside(PointerDownEvent event) {
      FocusManager.instance.primaryFocus?.unfocus();
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return CupertinoTextField(
          key: key,
          autofocus: true,
          placeholder: context.l10n.characterSearchPageHint,
          onChanged: onChanged,
          onTapOutside: onTapOutside,
        );
      case TargetPlatform.android:
        return TextField(
          key: key,
          autofocus: true,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: context.l10n.characterSearchPageHint,
          ),
          onChanged: onChanged,
          onTapOutside: onTapOutside,
        );

      default:
        throw Exception('$defaultTargetPlatform not supported');
    }
  }
}
