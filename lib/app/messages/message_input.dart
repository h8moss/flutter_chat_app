import 'package:flutter/material.dart';

class MessageInput extends StatelessWidget {
  const MessageInput({
    required this.onSubmit,
    this.formKey,
    this.validateInput,
    this.textController,
    Key? key,
  }) : super(key: key);

  final Key? formKey;
  final VoidCallback? onSubmit;
  final String? Function(String?)? validateInput;
  final TextEditingController? textController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        color: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
              key: formKey,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: textController,
                        validator: validateInput,
                        onEditingComplete: onSubmit,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'Message',
                          fillColor: Colors.grey.shade400,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: onSubmit,
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.send,
                        size: 20,
                      ),
                    ),
                    style:
                        ElevatedButton.styleFrom(shape: const CircleBorder()),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
