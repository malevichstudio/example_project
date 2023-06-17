part of "../../modal_bottom_picker.dart";

class ASModalBottomPickerOption<T> {
  final String displayableName;
  final T value;

  ASModalBottomPickerOption({required this.value, required this.displayableName});
}

class ASOptionPickerModalBottom<T> extends ASModalBottomSheet {
  final List<ASModalBottomPickerOption<T>> options;
  final ASOptionSelectedCallback<T> onSelected;
  const ASOptionPickerModalBottom({
    required this.options,
    required this.onSelected,
    Key? key,
  }) : super(key: key);

  @override
  State<ASOptionPickerModalBottom<T>> createState() => _ASOptionPickerModalBottomState<T>();
}

class _ASOptionPickerModalBottomState<T> extends State<ASOptionPickerModalBottom<T>> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < widget.options.length; i++)
          Column(
            children: [
              Material(
                child: InkWell(
                  onTap: () {
                    widget.onSelected(widget.options[i].value);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: i != widget.options.length - 1
                            ? const BorderSide(width: 1, color: ASColors.lightBackground)
                            : BorderSide.none,
                      ),
                    ),
                    child: Text(
                      widget.options[i].displayableName,
                      overflow: TextOverflow.ellipsis,
                      style: ASTextStyles.inputTextStyle,
                    ),
                  ),
                ),
              )
            ],
          )
      ],
    );
  }
}
