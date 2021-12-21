import 'package:flutter/material.dart';

class MessageInput extends StatefulWidget {
  const MessageInput({
    required this.onSubmit,
    this.clearInput = true,
    Key? key,
  }) : super(key: key);

  final ValueChanged<String>? onSubmit;
  final bool clearInput;

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        color: Colors.grey.shade400,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                  child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 100),
                child: TextField(
                  controller: _controller,
                  onSubmitted: (_) => _submit(),
                  focusNode: _focusNode,
                ),
              )),
              ElevatedButton(
                onPressed: _submit,
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.send,
                    size: 20,
                  ),
                ),
                style: ElevatedButton.styleFrom(shape: const CircleBorder()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    final text = _controller.text;
    _controller.text = '';
    if (widget.onSubmit != null) {
      widget.onSubmit!(text);
    }
    _focusNode.requestFocus();
  }
}
