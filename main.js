const canvas = document.getElementById("jsdos");

Dos(canvas, { cycles: 1, onprogress: ()=>{} }).ready((fs, main) => 
    fs.extract("snake.zip").then(() =>
        main(["snake.com"]).then((ci) => 
            swipedetect((swipedir) => swipedir && ci.simulateKeyPress(36 + swipedir))
        )
    )
);

function swipedetect(callback) {
    var startX, startY;

    canvas.addEventListener("touchstart", function(e) {
        startX = e.changedTouches[0].pageX;
        startY = e.changedTouches[0].pageY;
    }, false);

    canvas.addEventListener("touchend", function(e) {
        distX = e.changedTouches[0].pageX - startX;
        distY = e.changedTouches[0].pageY - startY;
        if (Math.abs(distX) >= 100 && Math.abs(distY) <= 100) swipedir = (distX < 0) ? 1 : 3;
        else if (Math.abs(distY) >= 100 && Math.abs(distX) <= 100) swipedir = (distY < 0) ? 2 : 4;
        callback(swipedir);
    }, false);
}
