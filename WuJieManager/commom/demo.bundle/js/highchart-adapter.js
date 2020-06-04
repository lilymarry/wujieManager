/**
 * Created with IntelliJ IDEA.
 * User: jwx
 * Date: 13-5-16
 * Time: 下午5:17
 */
function  showChart(chartContainer, chartTopic, xCategories, yCategories, dataValues, chartType,width,height,lineColor) {
     chartContainer.css({width:width ,height:height});
    if (chartType == "column")
        showColumnChart(chartContainer, chartTopic, xCategories, yCategories, dataValues);
    if (chartType == "line")
        showLineChart(chartContainer, chartTopic, xCategories, yCategories, dataValues,lineColor);
    if (chartType == "pie")
        showPieChart(chartContainer, chartTopic, dataValues);
    if (chartType == "map")
        showMapChart(chartContainer, dataValues);
    if (chartType == "rateGauge")
        showRateGaugeChart(chartContainer, chartTopic, yCategories, dataValues,width,height)

    

}
/**
 * Created with IntelliJ IDEA.
 * User: lsc
 * Date: 13-5-14
 * Time: 下午2:53
 * To change this template use File | Settings | File Templates.
 */
function showRateGaugeChart(chartContainer, chartTopic, yCategories, dataValues,width,height)
{
    var colors = ['#FF0000','#FF8000','#C2F7AA']
    chartContainer.highcharts({
                              chart :{
                              renderTo: 'container',
                              type: 'gauge',
                              // plotBorderWidth: 1,
                              //                    plotBackgroundColor: {//背景色
                              //                        linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 },
                              //                        stops: [
                              //                            [0, '#FFF4C6'],
                              //                            [0.3, '#FFFFFF'],
                              //                            [1, '#FFF4C6']
                              //                        ]
                              //                    },
                              plotBackgroundImage: null,//背景图片
                              height: width/2.0*1.1
                              },
                              title : {
                              //   text:  chartTopic + '进度比较'
                              text:''
                              },
                              
                              pane : [{
                                      startAngle: -90,
                                      endAngle: 90,
                                      background: null,
                                      center: ['50%', '95%'],
                                      size: width *0.85
                                      }],
                              yAxis : [{
                                       //      tickLength:0,
                                       //         minorTickLength:0,
                                       min: -20,
                                       max: +20,
                                       minorTickPosition: 'inside',
                                       tickPosition: 'inside',
                                       labels: {
                                       //        enabled:false,
                                       rotation: 'auto',
                                       distance: 10
                                       },
                                       plotBands: [{//分区段
                                                   from: -20,
                                                   to: 0,
                                                   color: colors[0],
                                                   innerRadius: '100%',
                                                   outerRadius: '65%'
                                                   },{
                                                   from: 0,
                                                   to: 10,
                                                   color: colors[1],
                                                   innerRadius: '100%',
                                                   outerRadius: '65%'
                                                   },{
                                                   from: 10,
                                                   to: 20,
                                                   color: colors[2],
                                                   innerRadius: '100%',
                                                   outerRadius: '65%'
                                                   }],
                                       title: {
                                       text: '',
                                       style :{
                                       fontSize : '14px',
                                       marginTop : '10px'
                                       },
                                       y: 20
                                       }
                                       }],
                              exporting :{
                              enabled: true
                              },
                              plotOptions: {
                              gauge: {
                              dataLabels: {
                              enabled: true,
                              y : -20
                              },
                              dial: {//仪表盘指针
                              radius: '80%',
                              rearLength: '0%',
                              backgroundColor: 'silver',
                              borderColor: 'silver',
                              borderWidth: 1,
                              baseWidth: 10,
                              topWidth: 1,
                              baseLength: '30%'
                              }
                              }
                              },
                              tooltip :{
                              formatter: function() {
                              var name = '';
                              if(this.y >= -20 && this.y <=0)
                              name = "未完成进度";
                              else if(this.y > 0 && this.y <= 10)
                              name = "进度完成率0-10%";
                              else if (this.y > 10 && this.y <=20)
                              name = "进度完成率10%以上";
                              
                              
                              return  dataValues[0]+ '  进度完成率'+':' +''+this.y+'%';
                              }
                              },
                              credits: {
                              text: '', //设置LOGO区文字
                              href: '' //设置LOGO链接地址
                              },
                              series: [{
                                       name : dataValues[0],
                                       data: [dataValues[1]]
                                       // yAxis: 1
                                       }
                                       
                                       
                                       
                                       
                                       
                                       
                                       
                                       
                                       ]
                              });
    
}


function showColumnChart(chartContainer, chartTopic, xCategories, yCategories, dataValues) {
//            console.log(xCategories)
    chartContainer.highcharts({
        chart: {
//            backgroundColor: "transparent",
            backgroundColor: "rgb(255, 255, 255)",
//            background: 'transparent',
            shadow: false

        },
        title: {
            text: chartTopic
         
        },
        yAxis: {
            title: {
                text: yCategories
            }
        },
        xAxis: {
            categories: xCategories,
                              labels: {
                              rotation: -45,
                              align: 'right',
                              style: {
                              fontSize: '11px',
                              fontFamily: 'Verdana, sans-serif'
                              }
                              }
        },
                              legend: {
                                      enabled:false,
                              align: 'right',
                              verticalAlign: 'top',
                              y: -14,
                              floating: true,
                              borderWidth: 0
                              },
        tooltip: {
            formatter: function () {
//                var s;
//                if (this.point.name) { // the pie chart
//                    s = '' +
//                        this.point.name + this.series.name + ': ' + this.y;
//                } else {
//                    s = '' +
//                        this.x + this.series.name + ': ' + this.y;
//                }
//                return s;
                return '<b>' + this.series.name.replace('单位:亿元', '') + '</b><br/>' +
                    this.x + ': ' + this.y/* + "亿元"*/;
            }
        },
                          
                              exporting: {
                              enabled: false  //设置导出按钮不可用
                              },
                              credits: {
                              text: '', //设置LOGO区文字
                              href: '' //设置LOGO链接地址
                              },
                              
        labels: {
            items: [
                {
                    html: '',
                    style: {
                        left: '40px',
                        top: '8px',
                        color: 'black'
                    }
                }
            ]
        },
        series: dataValues
    })
    ;
}

function showLineChart(chartContainer, chartTopic, xCategories, yCategories, dataValues ,lineColor) {
//    alert(chartContainer);
//    alert(chartTopic);
//    alert(xCategories);
//    alert(yCategories);
//    alert(dataValues);
//            console.log(xCategories)
//    alert(lineColor);
    chartContainer.highcharts({
        chart: {
            type: 'line',
            backgroundColor: "rgb(255, 255, 255)",
         
            shadow: false,
                              
        
        },
                          
        title: {
            text: chartTopic,
                            
        },
        xAxis: {
            categories: xCategories,
                              labels: {
                              rotation: 0,
                              align: 'center',
                              style: {
                              fontSize: '11px',
                              fontFamily: 'Verdana, sans-serif'
                              }
                              }
        },
        yAxis: {
//            title:{
//                text:'单位:百万'
//            }
                              min: 0,
                              title: {
                              text: yCategories
                              }
        },
                              
        tooltip: {
            enabled: true,
                              crosshairs: [{
                                           width: 1,
                                           color: "rgb(157, 157, 157)"
                                           }],
            formatter: function () {
                return '<b>' + this.series.name.replace('单位:亿元', '') + '</b><br/>' +
                    this.x + ' ¥' + this.y;
            }
        },
                              legend: {
                                      enabled:false,
                              align: 'right',
                              verticalAlign: 'top',
                              y: -14,
                              floating: true,
                              borderWidth: 0
                              },
        plotOptions: {
            line: {
                dataLabels: {
                    enabled: false
                },
                enableMouseTracking: true,
                              color:lineColor
            }
        },
                        
                              exporting: {
                              enabled: false  //设置导出按钮不可用
                              },
                              credits: {
                              text: '', //设置LOGO区文字
                              href: '' //设置LOGO链接地址
                              },
        series: dataValues
    });
};

function showPieChart(chartContainer, chartTopic, dataValues) {
    chartContainer.highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            backgroundColor: "rgb(255, 255, 255)",
//            backgroundColor: 'transparent',
//            backgroundColor:'green',
            shadow: false
        },
        title: {
            text: chartTopic
        },
        tooltip: {
            formatter: function () {
                              return '<b>' + this.point.name + '</b><br/>'   + '值' + ': ' + this.point.y + '<br/>' +'比例' + ': '
                              + this.percentage.toFixed(2) + ' % ';
            },
                              
                              
            percentageDecimals: 1
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
//                dataLabels: {
//                    enabled: true,
//                    color: '#000000',
//                    connectorColor: '#000000',
//                    formatter: function () {
//                        return '<b>' + this.point.name + '</b>: ' + this.percentage.toFixed(2) + ' %';
//                    }
//                },
                showInLegend: {
                    enabled: true
                }
            }
        },
//        credits:{
//            text: ""
//        },
                              
                  
                              exporting: {
                              enabled: false  //设置导出按钮不可用
                              },
                              credits: {
                              text: '', //设置LOGO区文字
                              href: '' //设置LOGO链接地址
                              },
        series: dataValues
    })
    ;
}

//var gdpData = {
//    "CN-54": 20,
//    "CN-52": 22,
//    "CN-35": 24,
//    "CN-50": 26,
//    "CN-51": 28,
//    "CN-31": 30,
//    "CN-32": 32,
//    "CN-33": 34,
//    "CN-14": 36,
//    "CN-15": 38,
//    "CN-12": 40,
//    "CN-13": 42,
//    "CN-11": 44,
//    "CN-34": 46,
//    "CN-53": 48,
//    "CN-36": 50,
//    "CN-37": 52,
//    "CN-41": 54,
//    "CN-43": 56,
//    "CN-42": 58,
//    "CN-45": 60,
//    "CN-44": 62,
//    "CN-46": 64,
//    "CN-65": 66,
//    "CN-64": 68,
//    "CN-63": 70,
//    "CN-62": 72,
//    "CN-61": 74,
//    "CN-23": 76,
//    "CN-22": 78,
//    "CN-21": 80,
//    "taiwan_area": 10
//};

//function showMapChart(chartContainer, dataValues) {
//    chartContainer.vectorMap({
//        map: 'cn_merc_en',
//        backgroundColor: 'transparent',
//        series: {
//            regions: [
//                {
////                    values: gdpData,
//                    values: dataValues[0],
//                    //normalizeFunction返回的数据根据数值排序，与scale里面的顺序对应
//                    //例如3>2>1,对应的[min, mid, max]，就是3对应最大的颜色，2对应第二颜色，1对应最小的颜色
//                    //如果返回值有更多的数值，就_会按照渐变去处理（保留最大和最小，然后用颜色去处理）
//
////                    scale:['#ffffff',"#0000ff","FFFF00"],
////                    scale: ['#FFFFFF', "#FFFF00", "#ff0000", "#0000ff"], //白 黄 红
////                    scale: ['#e74e52', '#f8fcaf', '#c2f7aa'],
//                    scale: [ '#FF0000', '#FF8000', '#c2f7aa', "#5be9f4"],    // 2red   3\yellow  4\lv
//
//
////                    scale:['#ffffff',"#ff0000","#FFFF00"],    //白红黄
//
////                    scale:['#FFFFFF',"#7FFF00","#ff0000"],
////                    scale: ['BDF400', 'FFD700', 'FF2800'],
////                    normalizeFunction: 'polynomial'
//                    normalizeFunction: function (e) {
//                        if (e) {
////                            alert(e);
////                            var a = parseFloat(e.toString());
//////                            var a = parseFloat(e.substr(0,e.indexOf('%')));
////                            var b = parseFloat(dataValues[1].replace('%', ''));
////                            var c = parseInt(a - b);
//                            var c = e - dataValues[1];
////                            alert(c);
//                            if (c > 100)
//                                return 4
//                            else {
//                                if (c >= 10)
//                                    return 3;
//                                else {
//                                    if (c >= 0)
//                                        return 2;
//                                    else
////                                        if (e - dataValues[1] < 0)
//                                        return 1;
//                                }
//
//                            }
////                            if (e - dataValues[1] > 100)
////                                return 4
////                            else {
////                                if (e - dataValues[1] >= 10)
////                                    return 3;
////                                else {
////                                    if (e - dataValues[1] >= 0)
////                                        return 2;
////                                    else
//////                                        if (e - dataValues[1] < 0)
////                                            return 1;
////                                    }
////
////                            }
////                            if (e - dataValues[1] >= 10)
////                                return 4;
////                            else {
////                                if (e - dataValues[1]>= 0)
////                                    return 3;
////                                else {
////                                    if (e - dataValues[1]< 0)
////                                        return 2;
////                                    else {
////                                        if(e = -10){
////                                            return "#8E388E"
////                                        }
//////                                        return 2;
////                                    }
////
////                                }
////                            }
//                        }
//                    }
//                }
//            ]
//        },
//        onRegionLabelShow: function (e, el, code) {
//            if(gdpData[code] > 100){
//                el.html(el.html() + ' - ' + "暂无数据");
//            }else{
//                el.html(el.html() + ' - ' + gdpData[code] + "%");
//            }
////             return code
////            el.html(el.html() + ' ('+$(this).parent().parent().parent().children(".head").children("span").children("span:first").text()+'   - ' + (gdpData[code] / 100000000).toFixed(6) + ' 亿元)');
//
//        }
//    });
function showMapChart(chartContainer, dataValues) {
    chartContainer.vectorMap({
        map: 'cn_merc_en',
        backgroundColor: 'transparent',
        series: {
            regions: [
                {
// values: gdpData,
                    values: dataValues[0],
//normalizeFunction返回的数据根据数值排序，与scale里面的顺序对应
//例如3>2>1,对应的[min, mid, max]，就是3对应最大的颜色，2对应第二颜色，1对应最小的颜色
//如果返回值有更多的数值，就_会按照渐变去处理（保留最大和最小，然后用颜色去处理）
// scale:['#ffffff',"#0000ff","FFFF00"],
// scale: ['#FFFFFF', "#FFFF00", "#ff0000", "#0000ff"], //白 黄 红
// scale: ['#e74e52', '#f8fcaf', '#c2f7aa'],
                    scale: [ '#FF0000', '#FF8000', '#c2f7aa', "#5be9f4"], // 2red 3\yellow 4\lv
// scale:['#ffffff',"#ff0000","#FFFF00"], //白红黄
// scale:['#FFFFFF',"#7FFF00","#ff0000"],
// scale: ['BDF400', 'FFD700', 'FF2800'],
// normalizeFunction: 'polynomial'
                    normalizeFunction: function (e) {
                        if (e) {
// alert(e);
// var a = parseFloat(e.toString());
//// var a = parseFloat(e.substr(0,e.indexOf('%')));
// var b = parseFloat(dataValues[1].replace('%', ''));
// var c = parseInt(a - b);
                            var c = e - dataValues[1];
// alert(c);
                            if (c > 100)
                                return 4
                            else {
                                if (c >= 10)
                                    return 3;
                                else {
                                    if (c >= 0)
                                        return 2;
                                    else
// if (e - dataValues[1] < 0)
                                        return 1;
                                }
                            }
// if (e - dataValues[1] > 100)
// return 4
// else {
// if (e - dataValues[1] >= 10)
// return 3;
// else {
// if (e - dataValues[1] >= 0)
// return 2;
// else
//// if (e - dataValues[1] < 0)
// return 1;
// }
//
// }
// if (e - dataValues[1] >= 10)
// return 4;
// else {
// if (e - dataValues[1]>= 0)
// return 3;
// else {
// if (e - dataValues[1]< 0)
// return 2;
// else {
// if(e = -10){
// return "#8E388E"
// }
//// return 2;
// }
//
// }
// }
                        }
                    }
                }
            ]
        },
        onRegionLabelShow: function (e, el, code) {
            if(gdpData[code] > 100){
                el.html(el.html() + ' - ' + "暂无数据");
            }else{
                el.html(el.html() + ' - ' + gdpData[code] + "%");
            }
// return code
// el.html(el.html() + ' ('+$(this).parent().parent().parent().children(".head").children("span").children("span:first").text()+' - ' + (gdpData[code] / 100000000).toFixed(6) + ' 亿元)');
        }
    });
}


