class GetStrings {
  String? deliveryTime(int code) {
    switch (code) {
      case 0:
        return 'morning_time';
      case 1:
        return 'dhuhr_time';
      case 2:
        return 'asr_time';
      case 3:
        return 'maghrib_time';
      case 4:
        return 'isha_time';
    }
  }

  String? orderStatus(int code) {
    switch (code) {
      case 6:
        return 'canceled';
      case 10:
        return 'on_way';
      case 11:
        return 'delivered';
      case 12:
        return 'problem_being_solved';
      case 13:
        return 'problem_being_solved_and_delivered';
      case 16:
        return 'notـanswered';
      case 17:
        return 'there_note';
      default:
        return 'order_status';
    }
  }
}
