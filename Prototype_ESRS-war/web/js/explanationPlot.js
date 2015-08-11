/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


//alert("hello");
//var aa,bb,cc,dd,ee;
var help = function () {
    var data1 = [[0, 81], [1, 19]];
    var data2 = [[0, 85], [1, 15]];
    var data3 = [[0, 82], [1, 18]];
    var data4 = [[0, 100], [1, 0]];
    var dataset1 = [{label: "Aspects", data: data1, color: "#5482FF"}];
    var dataset2 = [{label: "Aspects", data: data2, color: "#5482FF"}];
    var dataset3 = [{label: "Aspects", data: data3, color: "#5482FF"}];
    var dataset4 = [{label: "Aspects", data: data4, color: "#5482FF"}];

    var ticks = [[0, "camera"], [1, "picture"]];

    var options = {
        series: {
            bars: {
                show: true
            }
        },
        bars: {
            align: "center",
            barWidth: 0.5
        },
        xaxis: {
            axisLabel: "Aspect",
            axisLabelUseCanvas: true,
            axisLabelFontSizePixels: 12,
            axisLabelFontFamily: 'Verdana, Arial',
            axisLabelPadding: 10,
            ticks: ticks
        },
        yaxis: {
            axisLabel: "Frequency",
            axisLabelUseCanvas: true,
            axisLabelFontSizePixels: 12,
            axisLabelFontFamily: 'Verdana, Arial',
            axisLabelPadding: 3,
            tickFormatter: function (v, axis) {
                return v + "";
            }
        },
        legend: {
            noColumns: 0,
            labelBoxBorderColor: "#000000",
            position: "nw"
        },
        grid: {
            hoverable: true,
            borderWidth: 2,
            backgroundColor: {colors: ["#ffffff", "#EDF5FF"]}
        }
    };
    var chart;
//alert("1");
    $(document).ready(function () {
        //getData();
        //start();
        //plotChart();
        /**
         chart = $.plot($("#placeholder_1"), dataset2, options);
         $("#placeholder_1").UseTooltip();
         chart = $.plot($("#placeholder_2"), dataset3, options);
         $("#placeholder_2").UseTooltip();
         chart = $.plot($("#placeholder_3"), dataset4, options);
         $("#placeholder_3").UseTooltip();
         */
        /**$("#button_aspect").click(function () {
         $("#aspect_selection_1").slideToggle();
         $("#aspect_selection_2").slideToggle();
         
         });*/
        //alert("2");
        /**
         $("#img1").mouseenter(function(){
         chart = $.plot($("#placeholder1"), dataset2, options);
         $("#placeholder1").UseTooltip();
         });
         $("#img2").mouseenter(function(){
         chart = $.plot($("#placeholder1"), dataset3, options);
         $("#placeholder1").UseTooltip();
         });
         $("#img3").mouseenter(function(){
         chart = $.plot($("#placeholder1"), dataset4, options);
         $("#placeholder1").UseTooltip();
         });
         */
    });
    /**$(document).ready(function () {            
     $("#img1").mouseover(function(){
     chart = $.plot($("#placeholder"), dataset2, options);
     $("#placeholder1").UseTooltip();
     });
     $("#img2").mouseover(function(){
     chart = $.plot($("#placeholder"), dataset3, options);
     $("#placeholder1").UseTooltip();
     });
     $("#img3").mouseover(function(){
     chart = $.plot($("#placeholder"), dataset4, options);
     $("#placeholder1").UseTooltip();
     });
     
     });*/

    function start() {
        console.log("kknnkk");
        var p = "#placeholder";


        var Dis = function (placeholder) {
            this.name = "Abdulmumin Eneye Abdulkarim";
            $.plot($(placeholder), dataset1, options);
            $(placeholder).UseTooltip();
        };

        var x = new Dis(p);
        console.log(x.name);


        $.plot($("#placeholder_1"), dataset2, options);
        $("#placeholder_1").UseTooltip();
        $.plot($("#placeholder_2"), dataset3, options);
        $("#placeholder_2").UseTooltip();
        $.plot($("#placeholder_3"), dataset4, options);
        $("#placeholder_3").UseTooltip();
    }
//alert("3");
    function gd(year, month, day) {
        return new Date(year, month, day).getTime();
    }

    var previousPoint = null, previousLabel = null;

    $.fn.UseTooltip = function () {
        $(this).bind("plothover", function (event, pos, item) {
            if (item) {
                if ((previousLabel !== item.series.label) || (previousPoint !== item.dataIndex)) {
                    previousPoint = item.dataIndex;
                    previousLabel = item.series.label;
                    $("#tooltip").remove();

                    var x = item.datapoint[0];
                    var y = item.datapoint[1];

                    var color = item.series.color;

                    //console.log(item.series.xaxis.ticks[x].label);                

                    showTooltip(item.pageX,
                            item.pageY,
                            color,
                            "<strong>" + item.series.label + "</strong><br>" + item.series.xaxis.ticks[x].label + " : <strong>" + y + "</strong> ");
                }
            } else {
                $("#tooltip").remove();
                previousPoint = null;
            }
        });
    };

    function showTooltip(x, y, color, contents) {
        $('<div id="tooltip">' + contents + '</div>').css({
            position: 'absolute',
            display: 'none',
            top: y - 40,
            left: x - 120,
            border: '2px solid ' + color,
            padding: '3px',
            'font-size': '9px',
            'border-radius': '5px',
            'background-color': '#fff',
            'font-family': 'Verdana, Arial, Helvetica, Tahoma, sans-serif',
            opacity: 0.9
        }).appendTo("body").fadeIn(200);
    }
//alert("5");
    start();
};

$(document).ready(function () {

    var Plot = function () {
        help();
    };
    function createPlot() {
        var plot = new Plot();
    }
    function hello() {
        console.log("help");
        createPlot();
    }

});

function showMe(){
    alert("biscuit");
}
$(".asp_sel:checkbox").click(function(){
    showMe();
});
function retrievePandR11(form) {
    //console.log("meeeee");
    //var qp = "";
    //qp += queryProduct;
    //console.log(form.product.value);
    //var ext = "productsearch";
    var url = "/TestESRS-war/productsearch";
    //console.log(url);
    var type = "GET";
    var data = "search=" + "form.product.value";
    var status = false;
    $.ajax({
        type: type,
        url: url,
        data: data,
        success: function (msg) {
            console.log("job start");
            console.log(msg);
            console.log("job done");
            return true;
        }

    });

    console.log(url);
    console.log(data);
    //console.log(msg);

    return status;

}