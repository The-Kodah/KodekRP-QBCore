var volume = 0.5;
var whitelist = []

function extractDomainNameFromURL(url) {
    const domainRegex = /^(?:https?:\/\/)?(?:www\.)?([^/]+)/;
    const domain = url.match(domainRegex);
    if (domain) {
        return domain[1]
    } else {
        return "";
    }
}

function IsURLWhitelisted(URL){
    var domain = extractDomainNameFromURL(URL);
    for(var i = 0; i < whitelist.length; i++){
        var whitelistURL = whitelist[i];
        if(domain.includes(whitelistURL)){
            return true;
        }
    }
    return false;
}

function display(bool) {
    if (bool) {
        $("#radio_container").show();
    } else {
        $("#radio_container").hide();
    }
}

$(function(){
	var radio = 0;
    display(false);
    $.post('https://xradio/init');
	window.addEventListener('message', function(event) {
		var item = event.data;
        if (item.open === "ui"){
            display(item.status);
             $("#playing").text("nothing....");
             $("#volume").text("volume: 50%");
        }

        if (item.type === "init"){
            whitelist = item.whitelist;
        }

        if (item.type === "info"){
            volume = item.volume
            $("#volume").text("volume: " + Math.floor(volume * 100 ) +"%");
            updateName(item.url);
        }

        if (item.type === "volume"){
            volume = item.volume
            $("#volume").text("volume: " + Math.floor(volume * 100 ) +"%");
        }
		
		if(item.type === "add_default"){
			radio ++;
			$("#input_menu").append("<div onclick='$(this).playDefault()' class = 'button' value = '"+item.id+"' url = '"+item.url+"'><p>"+radio+"</p></div>");
		}
    })
});

jQuery.fn.extend({
	playDefault: function() {
		var def = $(this).attr('value');
        var url = $(this).attr('url');
		if(!IsURLWhitelisted(url)){
		    return;
		}

		updateName(url);
		$.post('https://xradio/play_default', JSON.stringify({
			radioId: def,
		}));	
	}
});

$( "#plus" ).click(function() {
	$.post('https://xradio/volumeUp', JSON.stringify({}));
});

$( "#minus" ).click(function() {	
	$.post('https://xradio/volumeDown', JSON.stringify({}));
});

function roundNumber(num, scale) {
  if(!("" + num).includes("e")) {
    return +(Math.round(num + "e+" + scale)  + "e-" + scale);
  } else {
    var arr = ("" + num).split("e");
    var sig = ""
    if(+arr[1] + scale > 0) {
      sig = "+";
    }
    return +(Math.round(+arr[0] + "e" + sig + (+arr[1] + scale)) + "e-" + scale);
  }
}