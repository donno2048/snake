Dos(document.getElementById("jsdos"), { cycles: 300, autolock: true, onprogress: (stage, total, loaded) => {document.getElementById("Bar").style.width = Math.floor(loaded * 99 / total) + "%"}}).ready((fs, main) => {
    fs.extract("snake.zip").then(() => {
        document.getElementById("Bar").style.height = "0px";
        main(["-c", "cls", "-c", "snake"]).then((ci) => {
            window.ci = ci;
            swipedetect(document.getElementById("jsdos"), (swipedir) => {if (swipedir) ci.simulateKeyPress(36 + swipedir);})
        })
    });
});
function swipedetect(el, callback) {
    var touchsurface = el, swipedir, startX, startY, distX, distY, threshold = 100, restraint = 90, allowedTime = 1000, elapsedTime, startTime;
    touchsurface.addEventListener("touchstart", function(e){
        var touchobj = e.changedTouches[0]
        swipedir = 0
        dist = 0
        startX = touchobj.pageX
        startY = touchobj.pageY
        startTime = new Date().getTime()
    }, false)
    touchsurface.addEventListener("touchmove", function(e){}, false)
    touchsurface.addEventListener("touchend", function(e){
        var touchobj = e.changedTouches[0]
        distX = touchobj.pageX - startX
        distY = touchobj.pageY - startY
        elapsedTime = new Date().getTime() - startTime
        if (elapsedTime <= allowedTime){
            if (Math.abs(distX) >= threshold && Math.abs(distY) <= restraint){swipedir = (distX < 0)? 1 : 3}
            else if (Math.abs(distY) >= threshold && Math.abs(distX) <= restraint){swipedir = (distY < 0)? 2 : 4}
        }
        callback(swipedir)
    }, false)
}