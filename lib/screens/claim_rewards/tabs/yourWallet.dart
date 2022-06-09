import 'package:flutter/material.dart';

class YourWallet extends StatefulWidget {
  final bool walletConnected;

  const YourWallet({Key? key, required this.walletConnected}) : super(key: key);
  @override
  State<YourWallet> createState() => _YourWalletState();
}

class _YourWalletState extends State<YourWallet> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
