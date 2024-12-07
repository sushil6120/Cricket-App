import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextEditorController extends GetxController {
  // Observable variables
  final content = ''.obs;
  final selectedText = ''.obs;
  final selectionStart = 0.obs;
  final selectionEnd = 0.obs;
  final textEditingController = TextEditingController().obs;
  final focusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    // Add listener to text controller to track changes
    textEditingController.value.addListener(() {
      content.value = textEditingController.value.text;
    });

    // Add listener to focusNode to track selection changes
    focusNode.addListener(() {
      final selection = textEditingController.value.selection;
      handleSelection(selection);
    });
  }

  // Function to handle text selection
  void handleSelection(TextSelection selection) {
    if (selection.isValid) {
      selectionStart.value = selection.start;
      selectionEnd.value = selection.end;

      // Get the selected text from the current content
      if (selection.start != selection.end) {
        selectedText.value = textEditingController.value.text
            .substring(selection.start, selection.end);
        print('Selected Text: ${selectedText.value}'); // For debugging
      } else {
        selectedText.value = '';
      }
    }
  }

  // Function to apply formatting to selected text
  void applyFormatting(String format) {
    if (selectedText.value.isEmpty) {
      print('No text selected'); // For debugging
      return;
    }

    final TextEditingValue currentValue = textEditingController.value.value;
    final String newText;
    final int newCursorPosition;

    switch (format) {
      case 'bold':
        newText = content.value.replaceRange(
          selectionStart.value,
          selectionEnd.value,
          '**${selectedText.value}**',
        );
        newCursorPosition = selectionEnd.value + 4; // Account for ** markers
        break;
      case 'italic':
        newText = content.value.replaceRange(
          selectionStart.value,
          selectionEnd.value,
          '_${selectedText.value}_',
        );
        newCursorPosition = selectionEnd.value + 2; // Account for _ markers
        break;
      default:
        return;
    }

    // Update the text controller with new formatted text
    textEditingController.value.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newCursorPosition),
    );
  }

  @override
  void onClose() {
    textEditingController.value.dispose();
    focusNode.dispose();
    super.onClose();
  }
}

class TextEditorScreen extends StatelessWidget {
  final TextEditorController controller = Get.put(TextEditorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Add more details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(() => TextField(
                    controller: controller.textEditingController.value,
                    focusNode: controller.focusNode,
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Start typing...',
                    ),
                    onChanged: (text) {
                      // Handle text change if needed
                    },
                  )),
            ),
          ),
          Container(
            color: Colors.black87,
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.format_bold, color: Colors.white),
                  onPressed: () => controller.applyFormatting('bold'),
                ),
                IconButton(
                  icon: Icon(Icons.format_italic, color: Colors.white),
                  onPressed: () => controller.applyFormatting('italic'),
                ),
                // Add other formatting buttons as needed
              ],
            ),
          ),
          // Bottom buttons (Cancel/Done)
          Container(
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    child: Text('CANCEL'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.teal,
                    child: TextButton(
                      child: Text(
                        'DONE',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        // Handle saving the content
                        print('Final content: ${controller.content.value}');
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TextEditorScreen(),
  ));
}
