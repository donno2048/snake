const canvas = document.getElementById("jsdos");

Dos(canvas, { cycles: 2, onprogress: ()=>{} }).ready((fs, main) =>
    fs.extract("snake.zip").then(() =>
        main(["snake.com"]).then(ci => {
            swipedetect(swipedir => swipedir && ci.simulateKeyPress(36 + swipedir));
            document.title = "Snake";
            span(canvas);
        })
    )
);

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
