function createChart($container){
	$('#container1').highcharts({
	 chart: {
		 spacingLeft:0,
		 spacingTop:8,
		 spacingRight:10,
		 spacingBottom:3
 	},
	credits:{enabled:false},
        plotOptions: {
            column: {
                borderColor: ''
            }
        },
        legend: {
            align: 'right',
            verticalAlign: 'top',
            y: -14,
            floating: true,
            borderWidth: 0
        },
        title: {
            text: '全险种保费收入趋势',
	    y: 5,
            style: {
                height: '100px',
                display: 'block',
                color: '#274b6d',
                fontFamily: '微软雅黑',
		fontSize: '13px'
		}
        },
        xAxis: {
        categories: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月']
        },
        yAxis: {
            title: {
		    text: '保费收入（亿）',
		    style:{fontSize:'11px'}
            }
        },
        tooltip: {
            formatter: function () {
                var s;
                s = '' + this.series.name + "年" + this.x + ': <br>' + this.y + "亿元";
                return s;
            }
        },
        series: [
            {
                type: 'spline',
                name: '2013',
                color: '#6699cc',
                data: [217.21, 340.96, 552.98, 612.94],
                dataLabels: {
                    enabled: true,
                    rotation: 0,
                    color: 'black',
                    align: 'center',
                    x: 0,
                    y: 0,
                    style: {
                        fontSize: '10px',
                        fontFamily: 'Verdana, sans-serif'
                    }
                }
            },
            {
                type: 'spline',
                name: '2012',
                color: 'orange',
                data: [180.42, 296.95, 488.83, 650.76, 812.93, 1010, 1160, 1300, 1470, 1600, 1760, 1920],
                marker: {lineWidth: 1 }
            }
        ]
    });



	$('#container2').highcharts({
	chart: {
		 spacingLeft:0,
		 spacingTop:8,
		 spacingRight:10,
		 spacingBottom:3
	 },
	  credits:{enabled:false},
        plotOptions: {
            column: {
                borderColor: ""//去边框
            }
        },
        legend: {
           align: 'right',
            verticalAlign: 'top',
            y: -14,
            floating: true,
            borderWidth: 0
        },
	title: {
            text: '2013年全险种保费收入月经营 ',
	    y: 5,
            style: {
                height: '100px',
                display: 'block',
                color: '#274b6d',
                fontFamily: '微软雅黑',
		fontSize: '13px'
		}
        },
        xAxis: {
            categories: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月']
        },
        yAxis: {
            title: {
		    text: '保费收入（亿）',
		    style:{fontSize:'11px'}
            }
        },
        tooltip: {
            formatter: function () {
                var s;
                s = '' + this.series.name + "年" + this.x + ': <br>' + this.y + "亿元";
                return s;
            }
        },
        series: [
            {
                type: 'column',
                name: '2013',
                data: [217.21, 123.75, 212.02, 159.96],
                color: '#6699cc',
                dataLabels: {
                    enabled: true,
                    rotation: 0,
                    color: 'black',
                    align: 'center',
                    x: 0,
                    y: 0,
                    style: {
                        fontSize: '10px',
                        fontFamily: 'Verdana, sans-serif'
                    }
                }
            },
            {
                type: 'column',
                name: '2012',
                color: 'orange',
                data: [180.42, 116.53, 191.88, 161.93, 162.17, 195.95, 146.73, 144.73, 170.12, 132.32, 152.95, 173.95],
                marker: {
                    lineWidth:1,
                lineColor: 'white'
                }
            }
        ]
});
}


$(function(){createChart()});

