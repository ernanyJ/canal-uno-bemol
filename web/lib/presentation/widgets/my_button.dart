import 'package:canaluno/presentation/widgets/my_loading_indicator.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.label, this.onPressed, this.isLoading = false});

  final String label;
  final void Function()? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: isLoading
            ? MyLoadingIndicator()
            : Text(
                label,
                style: TextStyle(color: Colors.white),
              ),
      ),
    );
  }
}

class MyButtonSecondary extends StatelessWidget {
  const MyButtonSecondary({super.key, required this.label, this.onPressed, this.isLoading = false});
  final String label;
  final void Function()? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.primary, // Cor do texto e interação
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary, // Cor do contorno
            width: 1.0, // Espessura do contorno
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: isLoading
            ? MyLoadingIndicator()
            : Text(
                label,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, // Texto na cor primária
                ),
              ),
      ),
    );
  }
}
