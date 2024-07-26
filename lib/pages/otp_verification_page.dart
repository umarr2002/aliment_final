import 'dart:ffi';

import 'package:aliment/classes/otp_textfield.dart';
import 'package:aliment/variables.dart';
import 'package:aliment/pages/login_account_page.dart';
import 'package:flutter/material.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final String defaulPassword = "2121";
  bool onClick = false;
  bool check = true;
  bool _isLoading = false;
  String sendPassword = "";
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());

  void _simulateLoading() async {
    setState(() {
      _isLoading = true;
    });

    _validateOtp();

    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });
  }

  void _validateOtp() {
    if (sendPassword != defaulPassword) {
      check = false;
    } else {
      setState(() {
        onClick = true;
      });
    }
  }

  @override
  void initState() {
    for (var controller in _controllers) {
      controller.addListener(() {
        sendPassword = _controllers.map((controller) => controller.text).join();
        setState(() {
          check = true;
          onClick = false;
        });
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Padding(
          padding: EdgeInsets.only(left: 56),
          child: Text(
            "OTP Verification",
            textAlign: TextAlign.center,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 27),
          child: Column(
            children: [
              const SizedBox(
                height: 39,
              ),
              Center(
                child: Image.asset(
                  "assets/images/otp_image.png",
                  width: 258,
                  height: 256,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 48.75, bottom: 7.5),
                child: Row(
                  children: [
                    Text(
                      "Enter OTP",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              const Row(
                children: [
                  SizedBox(
                    width: 233,
                    height: 36,
                    child: Text(
                      "An 4 digit code has been sent to +91 9995380399",
                    ),
                  ),
                ],
              ),
              OtpTextField(
                  check: check,
                  focusNodes: _focusNodes,
                  controllers: _controllers),
              SizedBox(
                height: 70,
                width: double.infinity,
                child: check
                    ? const Text("")
                    : const Padding(
                        padding: EdgeInsets.only(top: 16, left: 30),
                        child: Text(
                          "Invalid or Incorrect OTP. Try Again",
                          style: TextStyle(
                              color: Color(0xffD70000),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
              ),
              GestureDetector(
                onTap: () {
                  _validateOtp();
                  onClick = true;
                  _isLoading ? null : _simulateLoading();
                },
                child: Column(
                  children: [
                    Container(
                      height: 57,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.amber,
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xffFF9B63).withOpacity(1),
                            const Color(0xffFF621F).withOpacity(1)
                          ],
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 15,
                            height: 15,
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.black,
                                  )
                                : const Text(""),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          onClick
                              ? const Text(
                                  "Verify...",
                                  style: TextStyle(
                                    color: Color(0xffFFFFFF),
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              : const Text(
                                  "Verify",
                                  style: TextStyle(
                                    color: Color(0xffFFFFFF),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 26.25,
              ),
              const SizedBox(
                child: Text(
                  "Resend OTP",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
