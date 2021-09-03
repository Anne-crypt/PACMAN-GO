const hideTimer = () => {

  const timerText = document.getElementById('timetimer');
  if (timerText) {
    const tohiddenArea = document.querySelector('.info');
    let sec = 40;
    let min = 1;

    const displayTimer = (sec, min) => {
      if (sec < 10 || sec == 0) {
        sec = '0' + sec;
        }
      if (min < 10 || min == 0) {
            min = '0' + min;
        }
      timerText.innerHTML = min + ':' + sec;
    }

    const initiateTimeOut = (sec, min) => {
      if(sec >= 0 && min >= 0){
        displayTimer(sec, min);
        setTimeout(function () { doStuff(sec, min) }, 200);
      }
      else {
        tohiddenArea.style['visibility'] = 'hidden';
      }
    }

    initiateTimeOut(sec, min);

    const doStuff = (sec, min) => {
      sec --;
      if (sec == -1) {
        min = min - 1;
        sec = 59;
      }
      initiateTimeOut(sec, min);
    }


  }
};

export { hideTimer };
