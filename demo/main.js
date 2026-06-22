const jsdos = document.getElementById("jsdos");

fetch("snake.com")
    .then(response => response.arrayBuffer())
    .then(arrayBuffer => Dos(jsdos, {
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
                swipedetect(swipedir => swipedir && ci.simulateKeyPress(36 + swipedir));
                span();
                document.body.getElementsByClassName("sidebar")[0].remove();
            }
        },
        initFs: [{ path: "snake.com", contents: new Uint8Array(arrayBuffer) }],
        autoStart: true,
        noCursor: true
    }))
    .catch(console.error);

function span() {
    jsdos.style.height = "auto";
    jsdos.style.width = "100%";
    if (jsdos.offsetHeight > document.documentElement.clientHeight) {
        jsdos.style.width = "auto";
        jsdos.style.height = "75vh";
    }
}

function swipedetect(callback) {
    var startX, startY;

    jsdos.addEventListener("touchstart", function(e) {
        startX = e.changedTouches[0].pageX;
        startY = e.changedTouches[0].pageY;
    }, false);

    jsdos.addEventListener("touchend", function(e) {
        let swipedir = 0;
        const distX = e.changedTouches[0].pageX - startX;
        const distY = e.changedTouches[0].pageY - startY;
        if (Math.abs(distX) >= 100) swipedir = (distX < 0) ? 1 : 3;
        else if (Math.abs(distY) >= 100) swipedir = (distY < 0) ? 2 : 4;
        if (swipedir) callback(swipedir);
    }, false);
}

window.addEventListener("resize", span);
window.addEventListener("orientationchange", span);
