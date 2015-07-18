

$ ->
    #入力用

    #状況一覧用、読み取り専用である
    $(".dial_ro").knob({
      'min': 0,
      'max': 100,
      'fgColor': "#ff6f69",
      'inputColor': "#ff6f69",
      'readOnly': true
    });

    $(".dial").knob({
      'min': 0,
      'max': 100,
      'fgColor': "#ff6f69",
      'inputColor': "#ff6f69"
    });
