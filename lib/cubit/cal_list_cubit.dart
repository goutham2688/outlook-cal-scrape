import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../modal/cal_event.dart';
import '../modal/configs.dart';
import '../modal/data_store_modal.dart';
import '../modal/error_states.dart';
import '../repository/repository.dart';

part 'cal_list_state.dart';

class CalListCubit extends Cubit<CalListState> {
  final Repository repo;
  DateTime? currDate;
  DataStoreModal? localData;
  final oneDay = const Duration(days: 1);

  CalListCubit(this.repo) : super(CalListLoading());

  void getInitialData() async {
    // Initial load should always display todays data
    currDate = DateTime.now();

    // load data from local if it exits
    DataStoreModal? lData = await repo.localRepository.getCalData();

    if (lData != null) {
      localData = lData;
      _filterAndEmit();
    }
    // refresh the actual data in background
    await loadDataFromApi();
  }

  loadDataFromApi() async {
    DataStoreModal? apiResults;
    try {
      final configData = await repo.localRepository.getConfigs();
      if (configData.ifAllValuesExist()) {
        apiResults =
            await repo.apiRepository.getLatestData(configData: configData);
        // save data to local
        repo.localRepository.setCalData(apiResults);
      } else {
        emit(CalListError(errState: ErrorStates.errorSettings));
        return;
      }
    } catch (e) {
      emit(CalListError(errState: ErrorStates.dataNotLoading));
      return;
    }
    currDate ??= DateTime.now();

    if (currDate != null) {
      localData = apiResults;
      _filterAndEmit();
    } else {
      emit(CalListError(errState: ErrorStates.errorFetchingDateTime));
    }
  }

  void goToNextDate() {
    // go to next day
    currDate = currDate?.add(oneDay);

    _filterAndEmit();
  }

  void goToPrevDate() {
    // go to previous day
    currDate = currDate?.subtract(oneDay);

    _filterAndEmit();
  }

  bool _checkPrevEnable() {
    bool pFlag = true;
    if ((currDate?.day == localData?.startDate.day) &&
        (currDate?.month == localData?.startDate.month) &&
        (currDate?.year == localData?.startDate.year)) {
      pFlag = false;
    }
    return pFlag;
  }

  bool _checkNextEnable() {
    bool nFlag = true;
    if ((currDate?.day == localData?.endDate.day) &&
        (currDate?.month == localData?.endDate.month) &&
        (currDate?.year == localData?.endDate.year)) {
      nFlag = false;
    }
    return nFlag;
  }

  void _filterAndEmit() {
    final List<CalEvent> filteredData =
        DataStoreModal.calDatafilterCalEventsByDate(
            date: currDate!, calData: localData!.eventList);
    emit(CalListDataLoaded(
        data: filteredData,
        date: currDate!,
        prevEnabled: _checkPrevEnable(),
        nextEnabled: _checkNextEnable()));
  }

  Future<Configs> getConfigurationData() async {
    return await repo.localRepository.getConfigs();
  }

  saveConfigurationData(Configs data) async {
    await repo.localRepository.setConfigs(data);
  }
}
