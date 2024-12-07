import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextEditorController extends GetxController {
  // Observable variables
  final content = ''.obs;
  final selectedText = ''.obs;
  final selectionStart = 0.obs;
  final selectionEnd = 0.obs;
  final textEditingController = TextEditingController().obs;

  @override
  void onInit() {
    super.onInit();
    // Add listener to text controller to track changes
    textEditingController.value.addListener(() {
      content.value = textEditingController.value.text;
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
    super.onClose();
  }
}