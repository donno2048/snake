let canvas;

fetch("snake.com")
    .then(response => response.arrayBuffer())
    .then(arrayBuffer => Dos(document.getElementById("jsdos"), {
        dosboxConf: `
            [cpu]
            cycles=5
            [autoexec]
            mount c .
            c:
            snake.com
        `,
        onEvent: (event, ci) => {
            if (event === "ci-ready") {
                canvas = document.getElementsByTagName("canvas")[0];
                swipedetect(swipedir => swipedir && ci.simulateKeyPress(261 + swipedir));
                span();
            }
        },
        initFs: [{ path: "snake.com", contents: new Uint8Array(arrayBuffer) }],
        autoStart: true,
        noCursor: true,
    }))
    .catch(console.error);

function span() {
    canvas.style.height = "auto";
    canvas.style.width = "100vw";
    if (canvas.offsetHeight > document.documentElement.clientHeight) {
        canvas.style.width = "auto";
        canvas.style.height = "75vh";
    }
}

function swipedetect(callback) {
    var startX, startY;

    canvas.addEventListener("touchstart", function(e) {
        startX = e.changedTouches[0].pageX;
        startY = e.changedTouches[0].pageY;
    }, false);

    canvas.addEventListener("touchend", function(e) {
        let swipedir = 0;
        const distX = e.changedTouches[0].pageX - startX;
        const distY = e.changedTouches[0].pageY - startY;
        if (Math.abs(distX) >= 100) swipedir = (distX < 0) ? 2 : 1;
        else if (Math.abs(distY) >= 100) swipedir = (distY < 0) ? 4 : 3;
        callback(swipedir);
    }, false);
}

window.addEventListener("resize", span);
window.addEventListener("orientationchange", span);
