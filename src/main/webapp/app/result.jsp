<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <title>Results</title>
    </head>

    <body onload="checkStatus()">
        <div>
            <h1 align="center">RESULTS</h1>
            <h1 align="center" id="WIN" class="w3-hide">YOU WIN</h1>
            <h1 align="center" id="LOSE" class="w3-hide">YOU LOSE</h1>
            <div align="center">
                <button type="button" onclick="startGame()">START NEW GAME</button>
            </div>
        </div>

        <script>

            function checkStatus() {
                console.log("checking status");
                fetch("<c:url value='/api/game/status'/>", {
                    "method": "GET",
                    headers: {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json'
                    }
                }).then(function (response) {
                    return response.json();
                }).then(function (game) {
                    console.log(JSON.stringify(game));
                    if (game.status === "FINISHED" && game.playerActive) {
                        document.getElementById("WIN").classList.remove("w3-hide");
                        document.getElementById("LOSE").classList.add("w3-hide");
                    } else {
                        document.getElementById("WIN").classList.add("w3-hide");
                        document.getElementById("LOSE").classList.remove("w3-hide");
                        window.setTimeout(function() {checkStatus();}, 1000);
                    }
                });
            }

            function startGame() {
                fetch("<c:url value='/api/game'/>", {"method": "POST"})
                    .then(function (response) {
                        location.href = "/app/placement.jsp";
                    });
            }

        </script>

    </body>
</html>
