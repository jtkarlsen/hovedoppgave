$(document).ready(function() {
		document.getElementById('alerts').style.display = ''
        document.getElementById('message').style.color = "green";
        setTimeout (function(){
        	document.getElementById('alerts').style.display = 'none'
        }, 5000);
	});
	
	function getResult() {
		document.getElementById('card_input_value').focus();
    }
	
	$(document).keypress(function(e){
    var checkWebkitandIE=(e.which==26 ? 1 : 0);
    var checkMoz=(e.which==248 ? 1 : 0);

    if (checkWebkitandIE || checkMoz) getResult();
	});