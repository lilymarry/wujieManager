	$(function(){
		var sliderBlock;
		$('.slideBlock').mousedown(function(event){
			sliderBlock = $(this);
			sliderBlock.x = event.clientX-parseFloat($('.rate_blueSliderBar').css('width')||0);
			sliderBlock._x = event.clientX - parseFloat(this.style.left || 0);
			return false;			
		});
		$(document).mousemove(function(event){
			if(!sliderBlock) return;			
			var s = event.clientX-sliderBlock._x;			
			sliderBlock.css({left:s<=0?0:s>=726?s=726:s});
			s = event.clientX-sliderBlock.x;
			$('.rate_blueSliderBar').css({width:s<=0?0:s>=726?s=726:s});
			return false;
		}).mouseup(function(){
			sliderBlock = null;
		});
		$('span[class^=rateButtonText]').mousedown(function(event){
			if($(this).hasClass('rateButtonText2')){
				$('#rateButton').animate({left:90},500);
			}else{
				$('#rateButton').animate({left:20},500);
			}
		});	
		$('span[class^=sliderButtonTopText]').mousedown(function(event){
			if($(this).hasClass('sliderButtonTopText2')){
				$('#sliderButtonTopBG').animate({left:138},500);
			}else if($(this).hasClass('sliderButtonTopText3')){
				$('#sliderButtonTopBG').animate({left:250},500);
			}else{
				$('#sliderButtonTopBG').animate({left:25},500);
			}
		});
	});
