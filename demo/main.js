const canvas = document.getElementById("jsdos");
const speed = document.getElementById("speed");
let delayId;

Dos(canvas, { cycles: 1, onprogress: ()=>{} }).ready((fs, main) =>
    fs.extract("snake.zip").then(() =>
        main(["snake.com"]).then(ci => {
            delayId = setInterval(runLag, 1);
            swipedetect(swipedir => swipedir && ci.simulateKeyPress(36 + swipedir));
            document.title = "Snake";
        })
    )
);

function swipedetect(callback) {
    var startX, startY;

    canvas.addEventListener("touchstart", function(e) {
        startX = e.changedTouches[0].pageX;
        startY = e.changedTouches[0].pageY;
        clearInterval(delayId);
        delayId = setInterval(runLag, 1, 5);
    }, false);

    canvas.addEventListener("touchend", function(e) {
        clearInterval(delayId);
        distX = e.changedTouches[0].pageX - startX;
        distY = e.changedTouches[0].pageY - startY;
        if (Math.abs(distX) >= 100) swipedir = (distX < 0) ? 1 : 3;
        else if (Math.abs(distY) >= 100) swipedir = (distY < 0) ? 2 : 4;
        callback(swipedir);
        delayId = setInterval(runLag, 1);
    }, false);
}

function runLag(factor = 1) {
    const start = Date.now();
    while (Date.now() < start + (100 - speed.value) * factor);
}
