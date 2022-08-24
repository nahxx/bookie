$(function () {
  // 1. each(): 복수의 .count를 각각 받아온다.
  $('.counters .count').each(function () {
    // console.log($(this));

    // 2. prop(), Counter라는 속성을 생성한 뒤 0으로 초기화 한다.
    $(this)
      .prop('Counter', 0)
      // 3. animate(), 각각의 text를 받아와 Counter에 넣어 애니메이트한다.
      .animate(
        {
          Counter: $(this).text(),
        },
        // 4. 부드러운 애니메이션을 만들기 위해 속성을 지정한다.
        {
          duration: 4000,
          easing: 'swing',
          // 5. step(), 애니메이션 과정을 받아온다.
          step: function (now) {
            // 6. 소숫점을 올려서 반환된 정수를 표시한다.
            $(this).text(Math.ceil(now));
          },
        }
      );
  });
});