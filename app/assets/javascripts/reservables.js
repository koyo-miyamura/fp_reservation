$(function(){

  $('.datetimepicker').datetimepicker({
    format : "YYYY/MM/DD HH:mm",
    daysOfWeekDisabled: [0], // 日曜は選択できないようにする
    stepping: 30,
    icons: {
      time: "fa fa-clock-o",
      date: "fa fa-calendar",
      up: "fa fa-arrow-up",
      down: "fa fa-arrow-down",
      previous: "fa fa-arrow-left",
      next: "fa fa-arrow-right"
    }
  });
});
