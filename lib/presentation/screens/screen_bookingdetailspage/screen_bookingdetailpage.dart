// imports
import 'package:dream_carz/core/appconstants.dart';
import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/constants.dart';
import 'package:dream_carz/core/responsiveutils.dart';
import 'package:dream_carz/data/booking_overview_model.dart';
import 'package:dream_carz/data/booking_requestmodel.dart';
import 'package:dream_carz/data/confirm_bookingmodel.dart';
import 'package:dream_carz/data/coupen_model.dart';
import 'package:dream_carz/presentation/blocs/booking_confirmation_bloc/booking_confirmation_bloc.dart';
import 'package:dream_carz/presentation/blocs/coupen_bloc/coupen_bloc.dart';

import 'package:dream_carz/presentation/blocs/fetch_booking_overview_bloc/fetch_bookingoverview_bloc.dart';

import 'package:dream_carz/presentation/screens/screen_bookingdetailspage/widgets/locationselection_widget.dart';
import 'package:dream_carz/presentation/screens/screen_mydocuments/screen_mydocuments.dart';
import 'package:dream_carz/presentation/screens/screen_paymentpage/screenpaymentpage.dart';
import 'package:dream_carz/presentation/screens/screen_networkpage/screen_networkpage.dart';
import 'package:dream_carz/presentation/screens/screen_paymentpages/screen_paymentsuccesspage.dart';

import 'package:dream_carz/presentation/screens/screen_searchresultscreen.dart/widgets/customloading.dart';
import 'package:dream_carz/widgets/custom_navigation.dart';
import 'package:dream_carz/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class ScreenBookingdetailpage extends StatefulWidget {
  final DateTime? pickupDate;
  final TimeOfDay? pickupTime;
  final DateTime? dropDate;
  final TimeOfDay? dropTime;
  final int? modelId;
  final String? cityId;
  final String? kmId;

  const ScreenBookingdetailpage({
    super.key,
    this.pickupDate,
    this.pickupTime,
    this.dropDate,
    this.dropTime,
    this.modelId,
    this.cityId,
    this.kmId,
  });

  @override
  State<ScreenBookingdetailpage> createState() =>
      _ScreenBookingdetailpageState();
}

class _ScreenBookingdetailpageState extends State<ScreenBookingdetailpage> {
  bool isDelivery = false;
  final TextEditingController deliveryLocationController =
      TextEditingController();
  final TextEditingController deliveryAddressController =
      TextEditingController();
  final TextEditingController deliveryContactNameController =
      TextEditingController();
  final TextEditingController deliveryMobileController =
      TextEditingController();
  final TextEditingController couponController = TextEditingController();

  List<Branch> availableBranches = [];
  String? selectedBranchId; // store branchId
  String selectedBranchName = 'Select Pickup Location';

  double? selectedDeliveryLat;
  double? selectedDeliveryLng;
  String? selectedDeliveryAddress;
  CouponModel? appliedCoupon;
  bool isCouponApplied = false;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Combine date + time (uses your existing helper in the state)
      final fromDateTime = _combineDateAndTime(
        widget.pickupDate!,
        widget.pickupTime!,
      );
      final toDateTime = _combineDateAndTime(
        widget.dropDate!,
        widget.dropTime!,
      );

      // Format exactly as server expects: "yyyy-MM-dd HH:mm:ss"
      final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
      final bookingFrom = formatter.format(
        fromDateTime,
      ); // e.g. "2025-10-07 22:00:00"
      final bookingTo = formatter.format(
        toDateTime,
      ); // e.g. "2025-10-08 10:00:00"

      // Convert ids: widget.modelId is int?, widget.cityId & kmId are String?
      final int? modelId = widget.modelId;
      final int? cityId = widget.cityId != null
          ? int.tryParse(widget.cityId!)
          : null;
      final int? kmId = widget.kmId != null ? int.tryParse(widget.kmId!) : null;

      // Validate required fields (BookingRequestmodel requires non-null ints)
      if (modelId == null || cityId == null || kmId == null) {
        // handle missing values (show snack / log). Adjust behavior as needed.
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Missing booking parameters (model/city/km).'),
          ),
        );
        return;
      }

      // Build request model (dates are strings as server expects)
      final bookingRequest = BookingRequestmodel(
        bookingFrom: bookingFrom,
        bookingTo: bookingTo,
        modelId: modelId,
        cityId: cityId,
        kmId: kmId,
      );

      // Dispatch to your bloc (adjust event constructor name if different)
      context.read<FetchBookingoverviewBloc>().add(
        FetchBookingoverviewInitialState(bookingdetails: bookingRequest),
      );
    });
  }

  DateTime _combineDateAndTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  String _formatTimeOfDay(TimeOfDay t) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, t.hour, t.minute);
    return DateFormat('h:mm a').format(dt);
  }

  // Calculate discount based on coupon
  double _calculateDiscount(double baseFare) {
    if (!isCouponApplied || appliedCoupon == null) return 0.0;

    if (appliedCoupon!.discountType.toLowerCase() == 'percentage') {
      return (baseFare * appliedCoupon!.discountValue) / 100;
    } else {
      return appliedCoupon!.discountAmount;
    }
  }

  // // Calculate GST on discounted base fare
  // double _calculateGST(double baseFare) {
  //   final discountAmount = _calculateDiscount(baseFare);
  //   final discountedBaseFare = baseFare - discountAmount;
  //   return (discountedBaseFare * 0.18);
  // }

  // Calculate total payable amount
  double _calculatePayableAmount(BookingOverviewModel model) {
    final baseFare = model.priceData?.baseFare ?? 0.0;
    final discountAmount = _calculateDiscount(baseFare);
    final discountedBaseFare = baseFare - discountAmount;

    final deliveryCharges = isDelivery
        ? (model.priceData?.deliveryCharges ?? 0.0)
        : 0.0;
    final securityDeposit = model.priceData?.securityDeposit ?? 0.0;
    final gst = (discountedBaseFare * 0.18);

    return discountedBaseFare + deliveryCharges + securityDeposit + gst;
  }

  void _applyCoupon() {
    final couponCode = couponController.text.trim();

    if (couponCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a coupon code')),
      );
      return;
    }

    context.read<CoupenBloc>().add(
      CoupenButtonClickEvent(coupencode: couponCode),
    );
  }

  void _removeCoupon() {
    setState(() {
      appliedCoupon = null;
      isCouponApplied = false;
      couponController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityAwareWidget(
      child: Scaffold(
        backgroundColor: Appcolors.kbackgroundcolor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.chevron_left,
              size: ResponsiveUtils.wp(8),
              color: Colors.black,
            ),
          ),
          title: TextStyles.subheadline(
            text: 'Booking Summary',
            color: const Color(0xFF1A365D),
          ),
          centerTitle: false,
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<CoupenBloc, CoupenState>(
              listener: (context, state) {
                if (state is CoupenSuccessState) {
                  setState(() {
                    appliedCoupon = state.coupen;
                    isCouponApplied = true;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Coupon applied successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else if (state is CoupenErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
          ],
          child: BlocBuilder<FetchBookingoverviewBloc, FetchBookingoverviewState>(
            builder: (context, state) {
              if (state is FetchBookingoverviewLoadingState) {
                return Container(
                  color: Appcolors.kwhitecolor,
                  child: Center(
                    child: RotatingSteeringWheel(
                      size: ResponsiveUtils.wp(30),
                      steeringWheelAssetPath: Appconstants.splashlogo,
                    ),
                  ),
                );
              } else if (state is FetchBookingoverviewSuccessState) {
                // inside builder when state is FetchBookingoverviewSuccessState
                final booking = state.booking;

                // copy branches (server may return empty list)
                availableBranches = booking.availableBranches;

                // auto-select first branch only if not selected already
                if (availableBranches.isNotEmpty && selectedBranchId == null) {
                  // schedule after frame to safely call setState
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (!mounted) return;
                    setState(() {
                      selectedBranchId = availableBranches.first.branchId;
                      selectedBranchName =
                          availableBranches.first.name ?? 'Pickup Location';
                    });
                  });
                }
                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
                        child: Column(
                          children: [
                            _buildCarDetailsCard(state.booking),
                            ResponsiveSizedBox.height20,
                            _buildFulfillmentDetailsCard(),
                            ResponsiveSizedBox.height20,
                            _buildCouponCard(),
                            ResponsiveSizedBox.height20,
                            _buildPriceDetailsCard(state.booking),
                          ],
                        ),
                      ),
                    ),
                   BlocConsumer<BookingConfirmationBloc, BookingConfirmationState>(
      listener: (context, state) {
        if (state is BookingConfirmationSuccessState) {
          CustomNavigation.pushWithTransition(context,ScreenPaymentPage(bookingData: state.car,));
       //  CustomNavigation.pushWithTransition(context,MyDocumentsPage(bookingId: state.car.bookingId,));
        }
        else if(state is BookingConfirmationErrorState){
        CustomSnackbar.show(context, message: state.message, type:SnackbarType.error);
        }
      },
      builder: (context, state) {
        if (state is BookingConfirmationLoadingState) {
           return Container(
          width: double.infinity,
          margin: EdgeInsets.all(ResponsiveUtils.wp(4)),
          child: ElevatedButton(
            onPressed: () {

            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: EdgeInsets.symmetric(vertical: ResponsiveUtils.hp(1.6)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusStyles.kradius10(),
              ),
              elevation: 0,
            ),
            child:SpinKitCircle(size: 20,color: Appcolors.kwhitecolor,),
          ),
        );
        }
        return Container(
          width: double.infinity,
          margin: EdgeInsets.all(ResponsiveUtils.wp(4)),
          child: ElevatedButton(
            onPressed: () {
          // Validate before proceeding
          final validationError = _validateBookingDetails();
          
          if (validationError != null) {
            CustomSnackbar.show(
              context,
              message: validationError,
              type: SnackbarType.error,
            );
            return;
          }

          // If validation passes, proceed with booking
          final fromDateTime = DateTime(
            widget.pickupDate!.year,
            widget.pickupDate!.month,
            widget.pickupDate!.day,
            widget.pickupTime!.hour,
            widget.pickupTime!.minute,
          );
          final toDateTime = DateTime(
            widget.dropDate!.year,
            widget.dropDate!.month,
            widget.dropDate!.day,
            widget.dropTime!.hour,
            widget.dropTime!.minute,
          );

          String formatDateTime(DateTime dt) =>
              "${dt.year.toString().padLeft(4, '0')}-"
              "${dt.month.toString().padLeft(2, '0')}-"
              "${dt.day.toString().padLeft(2, '0')} "
              "${dt.hour.toString().padLeft(2, '0')}:"
              "${dt.minute.toString().padLeft(2, '0')}:00";

          final fulfillment = isDelivery ? "delivery" : "pickup";

          context.read<BookingConfirmationBloc>().add(
                BookingConfirmationButtonClickEvent(
                  booking: ConfirmBookingmodel(
                    bookingFrom: formatDateTime(fromDateTime),
                    bookingTo: formatDateTime(toDateTime),
                    modelId: widget.modelId!,
                    cityId: int.parse(widget.cityId!),
                    fulfillment: fulfillment,
                    couponCode: couponController.text.trim().isNotEmpty
                        ? couponController.text.trim()
                        : null,
                    deliveryArea: isDelivery
                        ? deliveryLocationController.text.trim()
                        : null,
                    deliveryAddress: isDelivery
                        ? deliveryAddressController.text.trim()
                        : null,
                    deliveryContactName: isDelivery
                        ? deliveryContactNameController.text.trim()
                        : null,
                    deliveryContactMobile: isDelivery
                        ? deliveryMobileController.text.trim()
                        : null,
                    branchId: !isDelivery ? selectedBranchId : null,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: EdgeInsets.symmetric(vertical: ResponsiveUtils.hp(1.6)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusStyles.kradius10(),
              ),
              elevation: 0,
            ),
            child: TextStyles.body(
              text: 'PROCEED',
              color: Colors.white,
              weight: FontWeight.bold,
            ),
          ),
        );
      },
    ),
                  ],
                );
              } else if (state is FetchBookingoverviewErrorState) {
                return Center(child: Text(state.message));
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCarDetailsCard(BookingOverviewModel model) {
    final card = model.card;

    return Container(
      padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusStyles.kradius15(),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: ResponsiveUtils.wp(20),
                height: ResponsiveUtils.hp(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusStyles.kradius10(),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadiusStyles.kradius10(),
                  child: card?.image != null
                      ? Image.network(
                          card!.image!,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return Center(
                              child: SpinKitFadingCircle(
                                size: ResponsiveUtils.wp(10),
                                color: Appcolors.kgreyColor,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return _buildCarPlaceholder();
                          },
                        )
                      : _buildCarPlaceholder(),
                ),
              ),
              ResponsiveSizedBox.width20,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextStyles.subheadline(
                      text: card?.modelName ?? 'Unknown Model',
                      color: Colors.black,
                    ),
                    ResponsiveSizedBox.height5,
                    Row(
                      children: [
                        TextStyles.medium(
                          text: 'Free Km : ',
                          color: Colors.grey[600],
                        ),
                        TextStyles.medium(
                          text: (card?.freeKms ?? 0).toString(),
                          color: Colors.red,
                          weight: FontWeight.w600,
                        ),
                        ResponsiveSizedBox.width20,
                        TextStyles.medium(
                          text: 'Extra : ',
                          color: Colors.grey[600],
                        ),
                        TextStyles.medium(
                          text:
                              '₹${(card?.additionalPerKm ?? 0).toStringAsFixed(1)}/Km',
                          color: Colors.red,
                          weight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          ResponsiveSizedBox.height15,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildFeatureItem(
                Appconstants.seatIcon,
                '${card?.seater ?? 0} Seater',
              ),
              _buildFeatureItem(
                Appconstants.gearIcon,
                card?.transmission ?? 'Unknown',
              ),
              _buildFeatureItem(
                Appconstants.petrolIcon,
                card?.fuelType ?? 'Unknown',
              ),
            ],
          ),
          ResponsiveSizedBox.height20,
          _buildBookingDetailRow(
            'Start Date',
            '${DateFormat('dd MMM yyyy').format(widget.pickupDate!)}  ${_formatTimeOfDay(widget.pickupTime!)}',
          ),
          ResponsiveSizedBox.height10,
          _buildBookingDetailRow(
            'End Date',
            '${DateFormat('dd MMM yyyy').format(widget.dropDate!)}  ${_formatTimeOfDay(widget.dropTime!)}',
          ),
          ResponsiveSizedBox.height10,

          Row(
            children: [
              TextStyles.body(text: 'Price Plan', color: Colors.grey[600]),
              ResponsiveSizedBox.width5,
              const Icon(Icons.info_outline, color: Colors.red, size: 16),
              const Spacer(),
              TextStyles.body(
                text: '${model.kmLimit ?? 0} KM',
                weight: FontWeight.w600,
              ),
            ],
          ),
          ResponsiveSizedBox.height5,
          Row(
            children: [
              TextStyles.caption(text: '(Without Fuel)', color: Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCarPlaceholder() {
    return Container(
      color: Colors.grey.shade200,
      child: Icon(
        Icons.directions_car,
        size: ResponsiveUtils.sp(8),
        color: Colors.grey,
      ),
    );
  }

  Widget _buildFeatureItem(String svgAssetPath, String text) {
    return Row(
      children: [
        SvgPicture.asset(
          svgAssetPath,
          width: ResponsiveUtils.sp(5),
          height: ResponsiveUtils.sp(5),
          colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
        ),
        ResponsiveSizedBox.width5,
        TextStyles.medium(text: text, color: Colors.grey[700]),
      ],
    );
  }

  Widget _buildBookingDetailRow(String label, String value) {
    return Row(
      children: [
        TextStyles.body(text: label, color: Colors.grey[600]),
        const Spacer(),
        TextStyles.body(text: value, weight: FontWeight.w600),
      ],
    );
  }

  Widget _buildFulfillmentDetailsCard() {
    return Container(
      padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusStyles.kradius15(),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextStyles.subheadline(
            text: 'Fulfillment Details',
            color: Colors.black,
          ),
          ResponsiveSizedBox.height20,
          Row(
            children: [
              GestureDetector(
                onTap: () => setState(() => isDelivery = false),
                child: Row(
                  children: [
                    Container(
                      width: ResponsiveUtils.sp(5),
                      height: ResponsiveUtils.sp(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.red, width: 2),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: isDelivery ? 0 : ResponsiveUtils.sp(2.2),
                          height: isDelivery ? 0 : ResponsiveUtils.sp(2.2),
                          decoration: BoxDecoration(
                            color: isDelivery ? Colors.transparent : Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    ResponsiveSizedBox.width10,
                    TextStyles.body(
                      text: 'Self-Pickup',
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              ResponsiveSizedBox.width30,
              GestureDetector(
                onTap: () => setState(() => isDelivery = true),
                child: Row(
                  children: [
                    Container(
                      width: ResponsiveUtils.sp(5),
                      height: ResponsiveUtils.sp(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.red, width: 2),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: isDelivery ? ResponsiveUtils.sp(2.2) : 0,
                          height: isDelivery ? ResponsiveUtils.sp(2.2) : 0,
                          decoration: BoxDecoration(
                            color: isDelivery ? Colors.red : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    ResponsiveSizedBox.width10,
                    TextStyles.body(text: 'Delivery', weight: FontWeight.w500),
                  ],
                ),
              ),
            ],
          ),
          ResponsiveSizedBox.height20,

          // Self-Pickup Section
          if (!isDelivery)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextStyles.body(
                  text: 'Choose pickup location',
                  color: Colors.grey[600],
                ),
                ResponsiveSizedBox.height10,
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveUtils.wp(3),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(10),
                    borderRadius: BorderRadiusStyles.kradius10(),
                    border: Border.all(color: Colors.grey.withAlpha(22)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: availableBranches.isNotEmpty
                        ? DropdownButton<String>(
                            value: selectedBranchId,
                            isExpanded: true,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey.shade700,
                            ),
                            items: availableBranches.map((branch) {
                              return DropdownMenuItem<String>(
                                value: branch.branchId,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextStyles.body(
                                      text: branch.name ?? 'Unnamed Branch',
                                    ),
                                    if ((branch.address ?? '').isNotEmpty)
                                      TextStyles.caption(
                                        text: branch.address ?? '',
                                        color: Colors.grey,
                                      ),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (val) {
                              final selected = availableBranches.firstWhere(
                                (b) => b.branchId == val,
                                orElse: () => availableBranches.first,
                              );
                              setState(() {
                                selectedBranchId = selected.branchId;
                                selectedBranchName =
                                    selected.name ?? 'Pickup Location';
                              });
                            },
                          )
                        : DropdownButton<String>(
                            value: null,
                            hint: TextStyles.body(
                              text: 'No pickup locations available',
                            ),
                            items: const [],
                            onChanged: null,
                          ),
                  ),
                ),
              ],
            ),

          // Delivery Section
          if (isDelivery)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Location Field
                TextStyles.body(
                  text: 'Delivery Location',
                  color: Colors.grey[600],
                ),
                ResponsiveSizedBox.height10,
                GestureDetector(
                  onTap: () async {
                    final result = await Navigator.push<LocationSearchResult>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LocationSearchScreen(
                          apiKey: "AIzaSyBW8UbeKu73pQ3fCj5rh3PXe_mXPorgCHA",
                        ),
                      ),
                    );

                    if (result != null) {
                      setState(() {
                        deliveryLocationController.text = result.address;
                        selectedDeliveryLat = result.latitude;
                        selectedDeliveryLng = result.longitude;
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: TextField(
                      controller: deliveryLocationController,
                      decoration: InputDecoration(
                        hintText: 'Tap to pick location on map',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadiusStyles.kradius10(),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadiusStyles.kradius10(),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadiusStyles.kradius10(),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: ResponsiveUtils.wp(4),
                          vertical: ResponsiveUtils.hp(1.5),
                        ),
                        suffixIcon: const Icon(Icons.location_on_outlined),
                      ),
                    ),
                  ),
                ),

                ResponsiveSizedBox.height15,

                // Address Field
                TextStyles.body(
                  text: 'Delivery Address',
                  color: Colors.grey[600],
                ),
                ResponsiveSizedBox.height10,
                TextField(
                  controller: deliveryAddressController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: 'Enter flat/house number, floor, building name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadiusStyles.kradius10(),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadiusStyles.kradius10(),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadiusStyles.kradius10(),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: ResponsiveUtils.wp(4),
                      vertical: ResponsiveUtils.hp(1.5),
                    ),
                  ),
                ),

                ResponsiveSizedBox.height15,

                // Contact Name Field
                TextStyles.body(text: 'Contact Name', color: Colors.grey[600]),
                ResponsiveSizedBox.height10,
                TextField(
                  controller: deliveryContactNameController,
                  decoration: InputDecoration(
                    hintText: 'Enter contact person name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadiusStyles.kradius10(),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadiusStyles.kradius10(),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadiusStyles.kradius10(),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: ResponsiveUtils.wp(4),
                      vertical: ResponsiveUtils.hp(1.5),
                    ),
                  ),
                ),

                ResponsiveSizedBox.height15,

                // Mobile Number Field
                TextStyles.body(text: 'Mobile Number', color: Colors.grey[600]),
                ResponsiveSizedBox.height10,
                TextField(
                  controller: deliveryMobileController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  decoration: InputDecoration(
                    hintText: 'Enter mobile number',
                    counterText: '',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadiusStyles.kradius10(),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadiusStyles.kradius10(),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadiusStyles.kradius10(),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: ResponsiveUtils.wp(4),
                      vertical: ResponsiveUtils.hp(1.5),
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: ResponsiveUtils.wp(4)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextStyles.body(text: '+91', color: Colors.black),
                          ResponsiveSizedBox.width10,
                          Container(
                            width: 1,
                            height: ResponsiveUtils.hp(2.5),
                            color: Colors.grey[300],
                          ),
                          ResponsiveSizedBox.width10,
                        ],
                      ),
                    ),
                  ),
                ),

                ResponsiveSizedBox.height15,

                // Disclaimer
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: ResponsiveUtils.sp(3.2),
                      color: Colors.grey[600],
                    ),
                    children: const [
                      TextSpan(
                        text: 'Disclaimer: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text:
                            'Delivery Charges may vary for outside city limits locations including Airport pickup / drop. The same will be confirmed upon KYC verification.',
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildCouponCard() {
    return Container(
      padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusStyles.kradius15(),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isCouponApplied && appliedCoupon != null)
            Container(
              padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
              margin: EdgeInsets.only(bottom: ResponsiveUtils.hp(1.5)),
              decoration: BoxDecoration(
                color: Colors.green.withAlpha(25),
                borderRadius: BorderRadiusStyles.kradius10(),
                border: Border.all(color: Colors.green, width: 1),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 20),
                  ResponsiveSizedBox.width10,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextStyles.body(
                          text:
                              'Coupon Applied: ${couponController.text.toUpperCase()}',
                          color: Colors.green,
                          weight: FontWeight.w600,
                        ),
                        TextStyles.caption(
                          text:
                              appliedCoupon!.discountType.toLowerCase() ==
                                  'percentage'
                              ? '${appliedCoupon!.discountValue.toStringAsFixed(0)}% discount'
                              : '₹${appliedCoupon!.discountAmount.toStringAsFixed(2)} discount',
                          color: Colors.green.shade700,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: _removeCoupon,
                    icon: Icon(Icons.close, color: Colors.red, size: 20),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: couponController,
                  enabled: !isCouponApplied,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    hintText: 'Coupon Code',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontSize: ResponsiveUtils.sp(3.6),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadiusStyles.kradius10(),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadiusStyles.kradius10(),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadiusStyles.kradius10(),
                      borderSide: BorderSide(color: Colors.grey[200]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadiusStyles.kradius10(),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: ResponsiveUtils.wp(4),
                      vertical: ResponsiveUtils.hp(1.5),
                    ),
                  ),
                ),
              ),
              ResponsiveSizedBox.width10,
              BlocBuilder<CoupenBloc, CoupenState>(
                builder: (context, state) {
                  if (state is CoupenLoadingState) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveUtils.wp(6),
                        vertical: ResponsiveUtils.hp(1.5),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadiusStyles.kradius10(),
                      ),
                      child: SizedBox(
                        width: ResponsiveUtils.wp(10),
                        height: ResponsiveUtils.hp(2),
                        child: SpinKitWave(
                          size: 15,
                          color: Appcolors.kwhitecolor,
                        ),
                      ),
                    );
                  }

                  return GestureDetector(
                    onTap: isCouponApplied ? null : _applyCoupon,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveUtils.wp(6),
                        vertical: ResponsiveUtils.hp(1.5),
                      ),
                      decoration: BoxDecoration(
                        color: isCouponApplied ? Colors.grey : Colors.orange,
                        borderRadius: BorderRadiusStyles.kradius10(),
                      ),
                      child: TextStyles.body(
                        text: 'Apply',
                        color: Colors.white,
                        weight: FontWeight.w600,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceDetailsCard(BookingOverviewModel model) {
    final priceData = model.priceData;
    final baseFare = priceData?.baseFare ?? 0.0;
    final weekdayCharges = priceData?.weekdayCharges ?? 0.0;
    final weekendCharges = priceData?.weekendCharges ?? 0.0;
    final deliveryCharges = isDelivery
        ? (priceData?.deliveryCharges ?? 0.0)
        : 0.0;
    final securityDeposit = priceData?.securityDeposit ?? 0.0;

    final discountAmount = _calculateDiscount(baseFare);
    final discountedBaseFare = baseFare - discountAmount;
    final gst = (discountedBaseFare * 0.18);
    final payableAmount = _calculatePayableAmount(model);

    return Container(
      padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusStyles.kradius15(),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextStyles.subheadline(text: 'Price Details', color: Colors.black),
          ResponsiveSizedBox.height20,
          _buildPriceRow(
            'Weekday Charges',
            '₹${weekdayCharges.toStringAsFixed(2)}',
            hasInfo: true,
          ),
          ResponsiveSizedBox.height15,
          _buildPriceRow(
            'Weekend Charges',
            '₹${weekendCharges.toStringAsFixed(2)}',
            hasInfo: true,
          ),
          ResponsiveSizedBox.height15,
          Container(height: 1, color: Colors.grey[300]),
          ResponsiveSizedBox.height15,
          _buildPriceRow(
            'Base Fare',
            '₹${baseFare.toStringAsFixed(2)}',
            hasInfo: true,
          ),
          ResponsiveSizedBox.height15,

          // Show discount row only if coupon is applied
          if (isCouponApplied && discountAmount > 0) ...[
            _buildPriceRow(
              'Discount',
              '- ₹${discountAmount.toStringAsFixed(2)}',
              color: Colors.green,
            ),
            ResponsiveSizedBox.height15,
          ],

          _buildPriceRow(
            'Delivery Charge',
            isDelivery ? '₹${deliveryCharges.toStringAsFixed(2)}' : '₹0.00',
            color: isDelivery ? Appcolors.kgreyColor : Appcolors.kgreencolor,
          ),
          ResponsiveSizedBox.height15,
          _buildPriceRow(
            'Security Deposit',
            '₹${securityDeposit.toStringAsFixed(2)}',
          ),
          ResponsiveSizedBox.height15,
          _buildPriceRow('GST (18%)', '₹${gst.toStringAsFixed(2)}'),
          ResponsiveSizedBox.height10,
          Container(height: 1, color: Colors.grey[300]),
          ResponsiveSizedBox.height10,
          _buildPriceRow(
            'Payable Amount',
            '₹${payableAmount.toStringAsFixed(2)}',
            color: Appcolors.kgreencolor,
          ),
          ResponsiveSizedBox.height10,
          Container(height: 1, color: Colors.grey[300]),
          ResponsiveSizedBox.height10,
          Row(
            children: [
              const Spacer(),
              TextStyles.body(
                text: '*incl. of taxes',
                color: Appcolors.kgreencolor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(
    String label,
    String amount, {
    bool hasInfo = false,
    Color color = Appcolors.kgreyColor,
  }) {
    return Row(
      children: [
        TextStyles.body(text: label, color: Colors.grey[600]),
        if (hasInfo) ...[
          ResponsiveSizedBox.width5,
          const Icon(Icons.info_outline, color: Colors.red, size: 16),
        ],
        const Spacer(),
        TextStyles.body(text: amount, weight: FontWeight.w600, color: color),
      ],
    );
  }


String? _validateBookingDetails() {
  // Check if fulfillment is pickup and branchId is required
  if (!isDelivery && (selectedBranchId == null || selectedBranchId!.isEmpty)) {
    return 'Please select a pickup location';
  }

  // Check if fulfillment is delivery and all delivery fields are required
  if (isDelivery) {
    if (deliveryLocationController.text.trim().isEmpty) {
      return 'Please select delivery location';
    }
    if (deliveryAddressController.text.trim().isEmpty) {
      return 'Please enter delivery address';
    }
    if (deliveryContactNameController.text.trim().isEmpty) {
      return 'Please enter contact name';
    }
    if (deliveryMobileController.text.trim().isEmpty) {
      return 'Please enter mobile number';
    }
    if (deliveryMobileController.text.trim().length != 10) {
      return 'Mobile number must be 10 digits';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(deliveryMobileController.text.trim())) {
      return 'Mobile number must contain only digits';
    }
  }

  return null; // No validation errors
}

  @override
  void dispose() {
    deliveryLocationController.dispose();
    deliveryAddressController.dispose();
    deliveryContactNameController.dispose();
    deliveryMobileController.dispose();
    couponController.dispose();
    super.dispose();
  }
}
