$(function(){
	$('#map').vectorMap({
		map: 'china',
		backgroundColor:'transparent',
		regionStyle:{
			  initial: {
			    fill: '#7094C6',
			    "fill-opacity": 1,
			    stroke: 'none',
			    "stroke-width": 0,
			    "stroke-opacity": 1
			  },
			  hover: {
			    fill:'#E9B31B'
			  },
 			selected: {
				fill: '#E9B31B'
  			}
		},	
		onRegionSelected:function(e,code,isSelected,selectedRegions){
			if(code=='taiwan')return;
			if(isSelected){
			cityCode = code;
			callback();}
		},
		regionsSelectable:true,
		regionsSelectableOne:true
	});
});
