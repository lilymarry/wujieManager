	function showMap(container,code){
		if(container&&container.data['map']){
			container.data['map'].remove();
			$('div.jvectormap-label').remove();
		}
		$('<div style="height:100%" id="_container"></div>').appendTo(container);
		container.data['map'] = $('#_container').vectorMap({
			map:code,regionsSelectable:true,regionsSelectableOne:true,	backgroundColor:'transparent',
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
				if(isSelected){
					loadFile(code,showMap,container);
                    var markName = $('div.jvectormap-label').text() ;

                    alert( markName) ;



				}
			}
		});
	}
	function loadFile(code,callback,container){
		var s = document.createElement('script');
		s.src = 'js/mapdata/' + code + '.js';					
		document.getElementsByTagName('head')[0].appendChild(s);
		s.onload = function(){
			callback(container,code);
		}
		//s.onerror = function(){alert('无法钻取下一级地图');};
	}
