class Samples {
  //
  //
  //     S E T T I N G S
  //
  //

  Map<String, Object> SettingsSample = {
    //kullanıcılara özel
    'theme': 'dark',
    'timer_pomodoro': {
      //settings
    },
    'sounds': {
      //settings
    }
  };

  //
  //
  //      D A I L Y   A S S E S S T M E N T S
  //
  //

  Map<String, Object> DailyAssessmentSample = {
    "date": "17/10/2023",
    "emoji": "!!EMOJICODE!!",
    "assessment": "bugün çok iyiydi"
  };

  //
  //
  //       M I S S I O N S
  //
  //

  Map<String, Object> MissionSample1 = {
    "name": "Denklemlere calis",
    "type": "ders",
    "priority": 2, //yüksek öncelik
    "working_time": 5280, //saniye
    "solved_question": 40, //çözülen soru sayısı
    "started_date": "16/10/2023 18:34",
    "deadline_date": "", //görevin son geçerlilik süresi (tamamlanma süresi)
    "finished_date": "16/10/2023 20:02", //görevin bitirildiği süre
    "isfinished": true
  };

  Map<String, Object> MissionSample2 = {
    "name": "Projeyi tamamla",
    "type": "diger",
    "priority": 0,
    "working_time": 0,
    "solved_question": 0,
    "started_date": "14/10/2023 12:15",
    "deadline_date": "2/1/2024 00:00",
    "finished_date": "",
    "isfinished": false
  };

  //
  //
  //
  //      U S E R S
  //
  //
  //

  Map<String, Object> UserSample = {
    "username": "admin",
    "password": "31",
    "pp": "!!!IMAGEBASE64CODE!!!",
    "uncompleted_missions": [],
    "completed_missions": [],
    "daily_assessments": [],
    'settings' : {}
  };


}
