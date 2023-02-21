
dollar = {}; 





window.addEventListener('message', function(event) {
    eFunc = event.data;
    if(event.data.action == "show") {

    if (eFunc.speed > 100 && eFunc.speed < 150  ) {
        document.getElementById("speedometer").style.color = "orange";
      
    } else if (eFunc.speed >= 150 ) {
        document.getElementById("speedometer").style.color = "red";

    } else {
            document.getElementById("speedometer").style.color = "white";

    }
    $(".speedometer").html(('000' + Math.round(eFunc.speed)).substr(-3));
    $(".fuelmeter").html(Number(eFunc.fuelLevel));
    $(".damagemeter").html(Number(eFunc.damagelevel));
    $(".streetname").html(eFunc.laststreet);
    $(".compasstext").html('  | ' + eFunc.degree + '  |');


    if (eFunc.gearlevel <= 0  ) {
        $(".gear").html('R');

  
    } else {
        $(".gear").html(Number(eFunc.gearlevel));
    }

    $(".Container").fadeIn();

        // $(".Container").css({"display":"block"});
        $('body').show()
    } else if (event.data.action == "hide") {
        $(".Container").fadeOut();

    } 

})




