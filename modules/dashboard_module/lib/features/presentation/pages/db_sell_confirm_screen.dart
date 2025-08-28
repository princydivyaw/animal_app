import 'package:dashboard_module/features/domain/entities/db_sell_confirm_entity.dart';
import 'package:dashboard_module/features/presentation/cubit/db_sell_confirm_cubit.dart';
import 'package:dashboard_module/features/presentation/cubit/db_sell_confirm_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:share_module/core/constants/app_colors.dart';
import 'package:share_module/core/theme/text_styles.dart';

class DbSellConfirmScreen extends StatefulWidget {
  const DbSellConfirmScreen({
    super.key,
  });

  @override
  State<DbSellConfirmScreen> createState() => _DbSellConfirmScreenState();
}

class _DbSellConfirmScreenState extends State<DbSellConfirmScreen> {
  final sellCubit = Modular.get<DbSellConfirmCubit>();

  DbSellConfirmEntity? screenEntity;

  @override
  void initState() {
    super.initState();
    sellCubit.getConfirmation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  confirmPost(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Your post has been confirmed!")),
    );
    Modular.to.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          backgroundColor: AppColors.surface,
          appBar: AppBar(
            elevation: 12,
            automaticallyImplyLeading: false,
            title: Text(
              "Confirmation to sell",
              style: AppTextStyles.subHeadingSubTitleBold(
                  color: AppColors.primary),
            ),
          ),
          body: BlocConsumer(
              bloc: sellCubit,
              listener: (context, state) {
                if (state is SellConfirmLoadedState) {
                  screenEntity = state.entity;
                }
              },
              builder: (context, state) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (screenEntity != null)
                        Expanded(
                            child: ListView.builder(
                                itemCount: screenEntity!.data.length,
                                itemBuilder: (context, int i) {
                                  var item = screenEntity!.data[i];
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (item.eventId != "pincode")
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              item.question,
                                              style: AppTextStyles.bodyMedium(
                                                  color: AppColors.textPrimary),
                                            ),
                                            if (item.widgetType != "radioField")
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.016,
                                              ),
                                          ],
                                        ),
                                      if (item.widgetType == "textfield" &&
                                          item.eventId != "pincode")
                                        plainTextField(
                                            screenEntity!.data[i], i),
                                      if (item.widgetType == "textfield" &&
                                          item.eventId == "pincode")
                                        addressTextField(item),
                                      if (item.widgetType == "dropdown")
                                        dropdownTextField(
                                            screenEntity!.data[i], i),
                                      if (item.widgetType == "radioField")
                                        radioTextField(
                                            screenEntity!.data[i], i),
                                    ],
                                  );
                                })),
                      /*  Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const ScrollPhysics(),
                          children: [
                            ///getting address from pin code
                            if (isPinCodeVerified)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "State",
                                    style: AppTextStyles.bodyMedium(
                                        color: AppColors.textPrimary),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.016,
                                  ),
                                  Container(
                                    // height: MediaQuery.of(context).size.height * 0.33,
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: AppColors.primary),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                      color: AppColors.background,
                                    ),
                                    child: TextField(
                                      style: AppTextStyles.bodyRegularNormal(
                                          color: AppColors.textPrimary),
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      enabled: false,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      controller: addressController,
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.032,
                                  )
                                ],
                              ),

                            ///breed gender
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Select Gender",
                                      style: AppTextStyles.bodyMedium(
                                          color: AppColors.textPrimary)),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.008,
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: genders.length,
                                        itemBuilder: (context, int radioIndex) {
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                genderIndex = radioIndex;
                                                selectedGender =
                                                    genders[genderIndex].value;
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 16.0),
                                              child: Row(
                                                children: [
                                                  genderIndex == radioIndex
                                                      ? Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.025,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.025,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2.0),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColors
                                                                .primaryDark,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                          ),
                                                          child: Container(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.016,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.016,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(2.0),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: AppColors
                                                                    .background,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                              ),
                                                              child: Container(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.016,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.016,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: AppColors
                                                                      .primaryDark,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100),
                                                                ),
                                                              )),
                                                        )
                                                      : Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.025,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.025,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: AppColors
                                                                    .primaryDark,
                                                                width: 1.8),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                          ),
                                                        ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.016,
                                                  ),
                                                  Text(
                                                      genders[radioIndex].value,
                                                      style: AppTextStyles
                                                          .bodyRegularNormal(
                                                              color: AppColors
                                                                  .textPrimary)),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.032,
                                  )
                                ],
                              ),
                            ),

                            ///if breed female
                            if (selectedGender != null &&
                                selectedGender?.toLowerCase() == "female")
                              Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: AppColors.primary),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                      color: AppColors.background,
                                    ),
                                    child: TextField(
                                      style: AppTextStyles.bodyRegularNormal(
                                          color: AppColors.textPrimary),
                                      focusNode: quantityFocus,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Litre of Milk",
                                        hintStyle:
                                            AppTextStyles.bodyRegularNormal(
                                                color: AppColors.textPrimary),
                                        suffixText: "Ltr",
                                        suffixStyle:
                                            AppTextStyles.bodyRegularNormal(
                                                color: AppColors.textPrimary),
                                      ),
                                      controller: quantityController,
                                      onChanged: (a) {
                                        // fieldValidator(field: "email", value: a);
                                      },
                                    ),
                                  ),
                                  isQuantityValidated
                                      ? fieldErrorWidget(
                                          errorText: quantityValidateTxt)
                                      : SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.032,
                                        ),
                                ],
                              ),

                            ///breed age
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Age",
                                    style: AppTextStyles.bodyMedium(
                                        color: AppColors.textPrimary)),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.008,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: AppColors.primary),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    color: AppColors.background,
                                  ),
                                  child: TextField(
                                    style: AppTextStyles.bodyRegularNormal(
                                        color: AppColors.textPrimary),
                                    focusNode: ageFocus,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Age",
                                      hintStyle:
                                          AppTextStyles.bodyRegularNormal(
                                              color: AppColors.textPrimary),
                                    ),
                                    controller: ageController,
                                    onChanged: (a) {
                                      // fieldValidator(field: "email", value: a);
                                    },
                                  ),
                                ),
                                isAgeValidated
                                    ? fieldErrorWidget(
                                        errorText: ageValidateTxt)
                                    : SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.032,
                                      ),
                              ],
                            ),

                            ///is breed kidded before
                            radioField(
                              label: "Has the animal calved/kidded before?",
                              item: isKidItem,
                            ),

                            ///if breed kidded yes before
                            if (isKidBefore != null &&
                                isKidBefore?.toLowerCase() == "yes")
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Number of Parity",
                                      style: AppTextStyles.bodyMedium(
                                          color: AppColors.textPrimary)),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.008,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: AppColors.primary),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                      color: AppColors.background,
                                    ),
                                    child: TextField(
                                      style: AppTextStyles.bodyRegularNormal(
                                          color: AppColors.textPrimary),
                                      focusNode: kidFocus,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Number of kidds",
                                        hintStyle:
                                            AppTextStyles.bodyRegularNormal(
                                                color: AppColors.textPrimary),
                                      ),
                                      controller: kidController,
                                      onChanged: (a) {
                                        // fieldValidator(field: "email", value: a);
                                      },
                                    ),
                                  ),
                                  isKidValidated
                                      ? fieldErrorWidget(
                                          errorText: kidValidateTxt)
                                      : SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.032,
                                        ),
                                ],
                              ),

                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.016,
                            ),

                            /// Images Preview
                            Column(
                              children: [
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text("Preview the images:",
                                        style: AppTextStyles.bodyBold())),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.016,
                                ),

                                */ /* ///preview images
                                SizedBox(
                                  height: 100,
                                  child: ListView.builder(
                                    itemCount: widget.files.length,
                                    itemBuilder: (context, index) {
                                      final file = widget.files[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 200,
                                          color: Colors.grey.shade200,
                                          child: buildPreview(file),
                                        ),
                                      );
                                    },
                                  ),
                                ),*/ /*
                              ],
                            ),
                          ],
                        ),
                      ),*/

                      /// Confirm & Cancel Buttons
                      bottomWidget()
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }

  fieldErrorWidget({required String errorText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.008,
        ),
        errorText.isNotEmpty
            ? Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  errorText,
                  style: const TextStyle(color: Colors.red, fontSize: 10),
                ),
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height * 0.008,
              ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.012,
        )
      ],
    );
  }

  //dropdown
  dropdownTextField(DbSellConfirmDataEntity item, int i) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () async {
            final DropDownEntity? a =
                await dropDownTypeField(fieldText: item.label, item: item.item);
            if (a != null) {
              setState(() {
                item.fieldController.text = a.value;
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: AppColors.background,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: AppTextStyles.bodyRegularNormal(
                        color: AppColors.textPrimary),
                    focusNode: item.fieldFocus,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    enabled: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: item.label,
                      hintStyle: AppTextStyles.bodyRegularNormal(
                          color: AppColors.textPrimary),
                    ),
                    controller: item.fieldController,
                  ),
                ),
                const Icon(
                  Icons.arrow_drop_down_rounded,
                  size: 24,
                  color: AppColors.primary,
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.032,
        )
      ],
    );
  }

  Future<dynamic> dropDownTypeField({
    required String fieldText,
    List<DbSellConfirmQuestionEntity>? item,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      backgroundColor: AppColors.background,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            // padding: const EdgeInsets.only(
            //   bottom: 48.0,
            // ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: fieldText.isEmpty
                              ? const SizedBox()
                              : Text(fieldText,
                                  style: AppTextStyles.bodyNormal(
                                      color: AppColors.textPrimary)),
                        ),
                        InkWell(
                            onTap: () {
                              Modular.to.pop(context);
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.primary)),
                              child: const Icon(
                                Icons.close,
                                size: 24,
                                color: AppColors.primary,
                              ),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.016,
                  ),

                  ///list of breed name
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: item!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            final value = item[index];
                            Modular.to.pop(value);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(16.0),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: AppColors.border,
                                    ),
                                  ),
                                ),
                                child: Text(item[index].label),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ]));
      },
    );
  }

  //radio
  radioTextField(DbSellConfirmDataEntity item, int index) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          height: MediaQuery.of(context).size.height * 0.06,
          child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: item.item!.length,
              itemBuilder: (context, int radioIndex) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      for (var i = 0; i < item.item!.length; i++) {
                        item.item![i].isSelected = false;
                      }
                      item.item![radioIndex].isSelected = true;
                    });
                    print("oo======${item.item![radioIndex].fields}");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        item.item![radioIndex].isSelected
                            ? Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.025,
                                width:
                                    MediaQuery.of(context).size.height * 0.025,
                                padding: const EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryDark,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.016,
                                    width: MediaQuery.of(context).size.height *
                                        0.016,
                                    padding: const EdgeInsets.all(2.0),
                                    decoration: BoxDecoration(
                                      color: AppColors.background,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.016,
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.016,
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryDark,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                    )),
                              )
                            : Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.025,
                                width:
                                    MediaQuery.of(context).size.height * 0.025,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.primaryDark, width: 1.8),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.016,
                        ),
                        Text(item.item![radioIndex].label,
                            style: AppTextStyles.bodyRegularNormal(
                                color: AppColors.textPrimary)),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.032,
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),

        ///condition check
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: AppColors.background,
              ),
              child: TextField(
                style: AppTextStyles.bodyRegularNormal(
                    color: AppColors.textPrimary),
                focusNode: item.fieldFocus,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Litre of Milk",
                  hintStyle: AppTextStyles.bodyRegularNormal(
                      color: AppColors.textPrimary),
                  suffixText: "Ltr",
                  suffixStyle: AppTextStyles.bodyRegularNormal(
                      color: AppColors.textPrimary),
                ),
                controller: item.fieldController,
                onChanged: (a) {
                  // fieldValidator(field: "email", value: a);
                },
              ),
            ),
            item.isFieldValidated
                ? fieldErrorWidget(errorText: item.fieldErrorTxt)
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.032,
                  ),
          ],
        ),
      ],
    );
  }

  //address
  addressTextField(DbSellConfirmDataEntity item) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              item.question,
              style: AppTextStyles.bodyMedium(color: AppColors.textPrimary),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.024,
            ),
            Expanded(
              child: Container(
                // height: MediaQuery.of(context).size.height * 0.33,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: item.fieldFocus.hasFocus
                          ? AppColors.primaryDark
                          : !item.isFieldValidated
                              ? AppColors.primary
                              : AppColors.error),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  color: AppColors.background,
                ),
                child: TextField(
                  style: AppTextStyles.bodyRegularNormal(
                      color: AppColors.textPrimary),
                  focusNode: item.fieldFocus,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: item.label,
                    hintStyle: AppTextStyles.bodyRegularNormal(
                        color: AppColors.textPrimary),
                  ),
                  controller: item.fieldController,
                  onChanged: (a) {
                    sellCubit.fieldValidate();

                    setState(() {
                      if (item.fieldController.text.isNotEmpty &&
                          item.fieldController.text.length == 6) {
                        setState(() {
                          item.isFieldValidated = true;
                          // addressController.text = "Chennai";
                        });
                      } else {
                        item.fieldErrorTxt = "PLease enter valid pin code";
                        item.isFieldValidated = true;
                      }
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        item.isFieldValidated
            ? fieldErrorWidget(errorText: item.fieldErrorTxt)
            : SizedBox(
                height: MediaQuery.of(context).size.height * 0.032,
              ),

        ///getting address from pin code
        // if (item.isFieldValidated)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "State",
              style: AppTextStyles.bodyMedium(color: AppColors.textPrimary),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.016,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: AppColors.background,
              ),
              child: TextField(
                style: AppTextStyles.bodyRegularNormal(
                    color: AppColors.textPrimary),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                enabled: false,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                // controller: addressController,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.032,
            )
          ],
        ),
      ],
    );
  }

  plainTextField(DbSellConfirmDataEntity item, int i) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          // height: MediaQuery.of(context).size.height * 0.33,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            border: Border.all(
                color: item.fieldFocus.hasFocus
                    ? AppColors.primaryDark
                    : !item.isFieldValidated
                        ? AppColors.primary
                        : AppColors.error),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: AppColors.background,
          ),
          child: TextField(
            style:
                AppTextStyles.bodyRegularNormal(color: AppColors.textPrimary),
            focusNode: item.fieldFocus,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: item.label,
              hintStyle:
                  AppTextStyles.bodyRegularNormal(color: AppColors.textPrimary),
            ),
            controller: item.fieldController,
            onChanged: (a) {
              sellCubit.fieldValidate();
              setState(() {
                if (item.fieldController.text.isNotEmpty &&
                    item.fieldController.text.length == 6) {
                  setState(() {
                    item.isFieldValidated = true;
                    // addressController.text = "Chennai";
                  });
                } else {
                  item.fieldErrorTxt = "PLease enter valid pin code";
                  item.isFieldValidated = true;
                }
              });
            },
          ),
        ),
        item.isFieldValidated
            ? fieldErrorWidget(errorText: item.fieldErrorTxt)
            : SizedBox(
                height: MediaQuery.of(context).size.height * 0.032,
              ),
      ],
    );
  }

  bottomWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        OutlinedButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () => confirmPost(context),
          child: const Text("Confirm & Post"),
        ),
      ],
    );
  }
}

class DropDownEntity {
  final String key;
  final String value;
  bool isSelected;
  bool isEnable;
  List item;

  DropDownEntity({
    required this.key,
    required this.value,
    this.isSelected = false,
    this.isEnable = false,
    this.item = const [],
  });
}
