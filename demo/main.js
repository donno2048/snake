const canvas = document.getElementById("jsdos");
const xhr = new XMLHttpRequest();
const zip = hex => {
    const int2hex = x => [x, x >> 8, x >> 16, x >> 24].map(i => i & 0xff);
    const length = int2hex(hex.length);
    return new Uint8Array([0x50, 0x4b, 3, 4, ...Array(14).fill(0),
      ...length, ...length, 8, 0, 0, 0, 0x6d, 0x61, 0x69, 0x6e, 0x2e, 0x63,
      0x6f, 0x6d, ...hex, 0x50, 0x4b, 1, 2, ...Array(16).fill(0),
      ...length, ...length, 8, ...Array(11).fill(0), 0x80, 0x81, 0, 0, 0, 0,
      0x6d, 0x61, 0x69, 0x6e, 0x2e, 0x63, 0x6f, 0x6d, 0x50, 0x4b,
      5, 6, 0, 0, 0, 0, 1, 0, 1, 0, 0x36, 0, 0, 0,
      ...int2hex(hex.length + 0x26), 0, 0]);
};

xhr.open('GET', 'snake.com', true);
xhr.responseType = 'arraybuffer';

xhr.onload = _ =>
    Dos(canvas, { cycles: 6, onprogress: ()=>{} }).ready((fs, main) =>
        fs.extract(URL.createObjectURL(new Blob([zip(new Uint8Array(xhr.response))]))).then(() =>
            main(["main.com"]).then(ci => {
                swipedetect(swipedir => swipedir && ci.simulateKeyPress(36 + swipedir));
                document.title = "Snake";
                span(canvas);
            })
        )
    )
;

xhr.send();

function span(element) {
    element.style.height = "auto";
    element.style.width = "100%";
    if (element.offsetHeight > document.documentElement.clientHeight) {
        element.style.width = "auto";
        element.style.height = "75vh";
    }
}

function swipedetect(callback) {
    var startX, startY;

    canvas.addEventListener("touchstart", function(e) {
        startX = e.changedTouches[0].pageX;
        startY = e.changedTouches[0].pageY;
    }, false);

    canvas.addEventListener("touchend", function(e) {
        distX = e.changedTouches[0].pageX - startX;
        distY = e.changedTouches[0].pageY - startY;
        if (Math.abs(distX) >= 100) swipedir = (distX < 0) ? 1 : 3;
        else if (Math.abs(distY) >= 100) swipedir = (distY < 0) ? 2 : 4;
        callback(swipedir);
    }, false);
}

window.addEventListener("resize", () => span(canvas));
