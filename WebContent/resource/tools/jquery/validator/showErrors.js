/**
 * @author user
 */
showCustomErrors = function(msg,obj){
        var errorMesage = msg
        if (!errorMesage) 
            errorMesage = "验证没通过";
        var pos = getAbsolutePos(obj);
        var x=pos.x;
        var y=pos.y;
        if(y-obj.clientHeight-8<0){//在下面显示
           y=y+obj.clientHeight+1;
        }
        else{//在上面显示
           y=y-obj.clientHeight-8;
		}
        jQuery("#divErrorMessage").remove();
        jQuery("body").append("<div id='divErrorMessage' ><label id='errorMesage'>" + errorMesage + "</label></div>");
        jQuery('#divErrorMessage').css({
            left: x + 2+"px",
            top: y+"px"
        });
        jQuery('#divErrorMessage').show();
        jQuery('#divErrorMessage').click(function(){
            jQuery('#divErrorMessage').remove();
        });
        jQuery('#divErrorMessage').focus();
}
 function getAbsolutePos(el) {
	var SL = 0, ST = 0;
	var is_div = /^div$/i.test(el.tagName);
	if (is_div && el.scrollLeft)
		SL = el.scrollLeft;
	if (is_div && el.scrollTop)
		ST = el.scrollTop;
	var r = { x: el.offsetLeft - SL, y: el.offsetTop - ST };
	if (el.offsetParent) {
		var tmp = this.getAbsolutePos(el.offsetParent);
		r.x += tmp.x;
		r.y += tmp.y;
	}
	return r;
}