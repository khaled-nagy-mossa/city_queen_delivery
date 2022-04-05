import 'package:delivery/main_imports.dart';
import 'package:delivery/module/statistics/cubit/delivery/states.dart';
import 'package:delivery/module/statistics/model/driver_profile.dart';
import 'package:delivery/module/statistics/repo/service.dart';

class DeliveryCubit extends Cubit<DeliveryStates> {
  DeliveryCubit({@required int deliveryId})
      : assert(deliveryId != null),
        super(const InitialState()) {
    fetchData(driverId: deliveryId, p: profile);
  }

  DriverProfile profile;

  DateTime _startMonth;
  DateTime _endMonth;

  DateTime get startMonth => _startMonth ?? prevMonth;

  DateTime get endMonth => _endMonth ?? currentMonth;

  DateTime get currentMonth {
    return DateTime.now();
  }

  DateTime get prevMonth {
    final now = DateTime.now();
    return DateTime(now.year, now.month - 1, now.day);
  }

  factory DeliveryCubit.get(BuildContext context) {
    return BlocProvider.of<DeliveryCubit>(context);
  }

  Future<void> fetchData({
    int driverId,
    DriverProfile p,
  }) async {
    try {
      await Future<void>.delayed(Duration.zero);
      emit(const FetchingDataState());

      if (p == null) {
        final res = await DeliveryService.driverProfile(
          driverId: driverId,
          startMonth: '${startMonth.month}-${startMonth.year}',
          endMonth: '${endMonth.month}-${endMonth.year}',
        );

        if (res is DriverProfile) {
          profile = res;
        } else {
          throw res.toString();
        }
      } else {
        await Future<void>.delayed(Duration.zero);
        profile = p;
      }

      emit(const FetchedDataState());
    } catch (e) {
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }

  Future<void> changeDuration(DateTime from, DateTime to) async {
    try {
      _startMonth = from;
      _endMonth = to;

      await Future<void>.delayed(Duration.zero);
      emit(const LoadingState());

      final res = await DeliveryService.driverProfile(
        driverId: profile.profileData.id,
        startMonth: '${startMonth.month}-${startMonth.year}',
        endMonth: '${endMonth.month}-${endMonth.year}',
      );
      if (res is DriverProfile) {
        profile = res;
      } else {
        throw res.toString();
      }

      emit(const LoadedState());
    } catch (e) {
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }
}
