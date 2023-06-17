part of '../../../date_picker.dart';

class ASCalendarPanelSwitchers<T> extends StatefulWidget {
  final List<ASCalendarPanelSwitcherOption<T>> options;

  const ASCalendarPanelSwitchers({
    required this.options,
    Key? key,
  }) : super(key: key);

  @override
  State<ASCalendarPanelSwitchers<T>> createState() => _ASCalendarPanelSwitchersState<T>();
}

class _ASCalendarPanelSwitchersState<T> extends State<ASCalendarPanelSwitchers<T>> {
  late final ValueNotifier<List<ASCalendarPanelSwitcherOption<T>>> _availableValueNotifier;

  @override
  void initState() {
    super.initState();
    _availableValueNotifier = ValueNotifier(widget.options);
  }

  void _onOptionChanged(ASCalendarPanelSwitcherOption<T> option) {
    _availableValueNotifier.value =
        _availableValueNotifier.value.map((e) => e.copyWith(isActive: e == option)).toList();
    option.onChanged(option.type);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _availableValueNotifier,
      builder: (BuildContext context, List<ASCalendarPanelSwitcherOption<T>> value, Widget? child) {
        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: value.map((item) {
            return SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: item.isActive
                  ? _ASEnabledSwitcher(
                      title: item.title,
                      option: item,
                    )
                  : _ASDisabledSwitcher<T>(
                      title: item.title,
                      onChanged: _onOptionChanged,
                      option: item,
                    ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _ASEnabledSwitcher extends StatelessWidget {
  final String title;
  final ASCalendarPanelSwitcherOption option;
  const _ASEnabledSwitcher({required this.title, required this.option, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: ASColors.primary, borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Text(
        title,
        style: ASTextStyles.buttonTextThin,
      ),
    );
  }
}

class _ASDisabledSwitcher<T> extends StatelessWidget {
  final String title;
  final ASCalendarPanelSwitcherOption<T> option;
  final Function(ASCalendarPanelSwitcherOption<T>) onChanged;
  const _ASDisabledSwitcher({required this.title, required this.onChanged, required this.option, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => onChanged(option),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          alignment: Alignment.center,
          decoration:
              const BoxDecoration(color: ASColors.secondary, borderRadius: BorderRadius.all(Radius.circular(4))),
          child: Text(
            title,
            style: ASTextStyles.secondaryButtonText,
          ),
        ),
      ),
    );
  }
}
