/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
console.log("Testing 1:- am working");
$(document).ready(function () {

    $("#productimage").click(function () {

    });

    $("#button_category").click(function () {


        $(".category_selection").slideToggle();
    });
    $("#button_aspect").click(function () {

        $(".aspect_selection").slideToggle();

    });
    $("#button_aspect_reset").click(function () {

        //clearSelection();

    });
    $("#aspects_scores").css("display", "none");

    $("#table").click(function () {

        $("#product_reviews").css("display", "none");
        $("#aspects_scores").css("display", "none");
        $("#aspects_table").css("display", "block");


    });
    $("#aspect").click(function () {
        $("#product_reviews").css("display", "none");
        $("#aspects_table").css("display", "none");
        $("#aspects_scores").css("display", "block");

    });
    $("#review").click(function () {

        $("#aspects_table").css("display", "none");
        $("#aspects_scores").css("display", "none");
        $("#product_reviews").css("display", "block");
    });

    $("#hide").click(function () {

        $(".explanationbar").css("display", "none");
        $(".explanationscatter").css("display", "none");

    });
    $("#bar").click(function () {

        $(".explanationscatter").css("display", "none");
        $(".explanationbar").css("display", "block");

    });
    $("#scatter").click(function () {

        $(".explanationbar").css("display", "none");
        $(".explanationscatter").css("display", "block");

    });



});
$(document).ready(function () {

});
var stars = [];
function setRatingArr(a) {
    var star5 = "5 star";
    var star4 = "4 star";
    var star3 = "3 star";
    var star2 = "2 star";
    var star1 = "1 star";
    console.log(a);
    stars.push(star5);
    stars.push(star4);
    stars.push(star3);
    stars.push(star2);
    stars.push(star1);
}
function getRatingArr() {
    var arr = stars;
    //stars = [];
    console.log(arr);
    return arr;
}
var starVal = [];
function setStarRatings(t, r1, r2, r3, r4, r5) {
    starVal.push(parseInt(r5));
    starVal.push(parseInt(r4));
    starVal.push(parseInt(r3));
    starVal.push(parseInt(r2));
    starVal.push(parseInt(r1));    
}
function getStarRatings() {
    var arr = starVal;
    //starVal = [];
    console.log(arr);
    return arr;
}
function ratingGraph() {

    setRatingArr();

    var starr = getRatingArr();

    console.log("star len: " + starr.length);
    var s = '';
    var id = '';
    //var type = 'mult';
    var type = 'sing';
    var ytitle = 'Frequency';
    var stitle = 'Star Rating';
    var obj = readMe();
    console.log('obj len'+obj.length);
    for (var y = 0; y < obj.length; y++) {
        
        if (y === 0) {
            var i = obj[y];
            console.log(y);
            console.log(i.productID);

            var data1 = [];
            var ticks1 = [];
            ticks1 = starr;
            data1 = getStarRatings();

            if (type === 'sing') {
                id = obj[0].getProductID();
                s = id + '_r';
                setOptions(s, data1, ticks1, ytitle, stitle);
                myChart();

            } else if (type === 'mult') {
                setSeries(data1, y + 1);

                id = obj[0].getProductID();
                s = id + '_r_mult_rating';
                if (y === obj.length - 1) {
                    setOptionsS(s, ticks1,ytitle);
                    myChartS();
                }
            }


        }

    }
    return true;

}
function show(s, id) {
    console.log("hey");
    var g = id + '_mult_sentiment';
    var q = id + '_r';
    document.getElementById("graphtitle").innerHTML = "Aspect Graph (Query Product)";
    document.getElementById("rss").style.display = 'none';
    document.getElementById(g).style.display = 'none';
    document.getElementById(q).style.display = 'block';
    document.getElementById("graphtitler").style.display = 'block';
    document.getElementById(id).style.display = 'block';
    document.getElementById("msgrss").style.display = 'block';

    //h.display = "none";

}
function hide(h) {
    //alert("hey");
    //h.display = "none";

}
//product-recommendation-detail getProductID for mult
//1 for multiple bar
//2 for single bar
var h = 0;
function showMult(m, n) {
    var id, s;
    var c = document.getElementsByClassName('product_graph_d');
    console.log(c[9]);
    m.style.display = 'none';
    for (var b = 0; b < c.length; b++) {
        c[b].style.display = 'none';
    }

    if (n === '1') {

        id = m.id.valueOf();
        s = id + '_mult_sentiment';
        var q = id + "_r";
        document.getElementById(q).style.display = 'none';
        document.getElementById("graphtitler").style.display = 'none';
        if (h === 0) {
            writeMe("1", null, s);
            h++;
        }

    } else if (n === '2') {
        id = m.id.valueOf();
        s = id + '_mult_rating';
        console.log(s);
    }


    var e = document.getElementById(s);

    e.style.display = 'block';
    document.getElementById("graphtitle").innerHTML = "Aspect Graph (Product Comparison)";
    document.getElementById("rss").style.display = 'block';
    document.getElementById("msgrss").style.display = 'none';

}
//product-recommendation-detail getProductID for desc
function showDes(m) {
    var id = m.name.valueOf();
    displayDes(id);
}
//product-recommendation-detail display desProductID  
function displayDes(id) {
    var s = 'i_';
    s += id;

    var c = document.getElementsByClassName('product_desc_d');
    console.log(c[9]);
    for (var b = 0; b < c.length; b++) {
        c[b].style.display = 'none';
    }

    var e = document.getElementById(s);

    e.style.display = 'block';
}

$(document).ready(function () {

    $('span.stars').stars();


});

$.fn.stars = function () {
    return $(this).each(function () {
        // Get the value
        var val = parseFloat($(this).html());
        // Make sure that the value is in 0 - 5 range, multiply to get width
        var size = Math.max(0, (Math.min(5, val))) * 16;
        // Create stars holder
        var $span = $('<span />').width(size);
        // Replace the numerical value with stars
        $(this).html($span);
    });
};


var tempobj, tempval;
var asarr = [];

var iii = 0;
function aspectSelect(asp, s) {
    var asarrele = [];
    tempobj = asp;
    asarrele.push(tempobj);
    var aspect = asp.value;

    asarr.push(aspect);
    tempobj.disabled = true;

    if (asarr.length > 0) {
        if (iii < 10) {
            if (s === '2') {
                writeMe(s, asarr);
            } else if (s === '1') {
                writeMe(s, asarr);
            }
            iii++;
        } else {
            var c = document.getElementsByClassName('aspect_cb');
            console.log(c[9]);
            for (var b = 0; b < c.length; b++) {
                c[b].disabled = true;
            }
        }
    }
    console.log(window.document.location.search);
}

function clearSelection(a) {
    var c = document.getElementsByClassName('aspect_cb');

    for (var b = 0; b < c.length; b++) {
        c[b].disabled = false;
        c[b].checked = false;
    }
    asarr = [];
    iii = 0;
    if (a === '2') {
        writeMe("2", null);
    } else if (a === '1') {
        writeMe("1", null);
    }
}

function retrievePRJSONDetail(queryProduct, u, page) {

    console.log("Testing 2: retrievePRJSONDetail() working");
    console.log("Ajax call: Function Start");
    var ext = "recommendation";
    var url = "/TestESRS-war/" + ext;
    console.log("URL: " + url);
    var type = "GET";
    var data = "product=" + queryProduct;
    console.log("Data: " + data);
    var status = false;
    var dtype = 'json';

    $.ajax({
        type: type,
        url: url,
        data: data,
        datatype: dtype,
        success: function (msg) {
            console.log("Ajax call: start");

            setProductJSONDetails(msg);
            setQRArrayOfProductList(msg);
            setQRJSONOfProductDetails(msg, queryProduct);
            ratingGraph();
            //console.log(msg);
            //console.log("Ajax call: stop");




            if (page === 'compare') {
                status = writeMe(u, null);                
                console.log('status: ' + status);
                if (status === true) {
                    showGraphOnCompare(page);
                }
            } else if (page === undefined) {
                writeMe(u, null);                
            }


        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log("Error: " + jqXHR + " ,Status: " + textStatus + " ,ErrorThrown: " + errorThrown);
        }

    });
    console.log("Ajax call: Function End");
    return status;
}
var completeDetail = null;
function setProductJSONDetails(msg) {
    completeDetail = msg;
}
function getProductJSONDetails() {
    return completeDetail;
}
function displayScores() {
    n("inyene");
}
//important
var p = [];
function readMe() {
    var array = getQRArrayOfProductList();
    var details = getQRJSONOfProductDetails();
    for (var i = 0; i < array.length; i++) {
        var prodid = array[i];
        var detail = details[prodid];
        var q = new ProductDetail(prodid, detail);
        q.displayProductID();
        p.push(q);
    }
    var r = p;
    p = [];
    return r;
}
var aspect = [];
function setAspectArr(a) {
    var aspect1 = "camera";
    var aspect2 = "lens";
    var aspect3 = "quality";
    var aspect4 = "focus";
    var aspect5 = "dslr";
    if (a === null) {
        console.log(a);
        console.log("a");
    }
    aspect.push(aspect1);
    aspect.push(aspect2);
    aspect.push(aspect3);
    aspect.push(aspect4);
    aspect.push(aspect5);
}
function getAspectArr() {
    var arr = aspect;
    //aspect = [];
    console.log(arr);
    return arr;
}
function showGraphOnCompare(page) {
    writeMe("2", null, page);
}
var tt = " ";
setAspectArr();
function writeMe(n, as, dID) {
    var ytitle = 'Score';
    var stitle = 'Aspect';
    console.log(dID);
    if (as !== null) {
        var aspectArr = as;
    } else {
        var aspectArr = getAspectArr();
    }
    console.log("len: " + aspectArr.length);
    console.log(aspectArr);
    var xaxis;
    var datum;

    var obj = readMe();

    for (var y = 0; y < obj.length; y++) {

        var i = obj[y];
        console.log(y);
        console.log(i.productID);
        var data = [];
        var ticks = [];
        var data1 = [];
        var ticks1 = [];

        var s = sum(i, aspectArr);
        console.log(s);
        for (var k = 0; k < aspectArr.length; k++) {
            var q = 0.0;
            q = value(i.getJsonDetail().aspects[aspectArr[k]].score, s);
            var v = parseFloat(q);
            xaxis = [];
            datum = [];
            xaxis.push(k);
            xaxis.push(aspectArr[k]);
            datum.push(k);
            datum.push(i.jsonDetail.aspects[aspectArr[k]].score);

            ticks.push(xaxis);
            data.push(datum);

            var ll = i.getJsonDetail().aspects[aspectArr[k]].score;
            var l = parseFloat(ll);
            ticks1.push(aspectArr[k]);
            //non-nomilized
            data1.push(l);
            //nomilized
            //data1.push(v);
            console.log(i.getJsonDetail());
            console.log('aspect name: ' + aspectArr[k] + ' - nomilized value: ' + v);
            console.log('aspect name: ' + aspectArr[k] + ' - non-nomilized value: ' + l);
        }
        if (n === "1") {
            setSeries(data1, y + 1);
            var id;
            if (dID === undefined) {
                id = obj[0].getProductID();
            } else {
                id = dID;
            }
            if (y === obj.length - 1) {
                setOptionsS(id, ticks1,ytitle);
                myChartS();
            }
        } else if (n === "2") {
            if (dID === undefined) {
                setOptions(i.getProductID(), data1, ticks1, ytitle, stitle);
            } else if (dID === 'compare') {
                var id = i.getProductID() + '_comp';
                //alert('hello');
                setOptions(id, data1, ticks1, ytitle, stitle);

            } else {
                setOptions(dID, data1, ticks1, ytitle, stitle);
            }

            myChart();
        }
        //var createPlot = "c";
        //createPlot += y;
        //var m = new CreatePlot(data, ticks, i.productID, createPlot);
        //var p = "#";
        //p += i.productID;
        //loadChart(p, data, ticks);
        //setOptions(i.productID,data, ticks);
        //setOptions(i.getProductID(), data1, ticks1);
        //myChart();
    }
    return true;
}

var qandrPList = [];
function setQRArrayOfProductList(msg) {
    qandrPList = msg.productlist.arrayrecomm;
}
function getQRArrayOfProductList() {
    return qandrPList;
}
var qandrPDetail = {};
function setQRJSONOfProductDetails(msg, productid) {
    qandrPDetail = msg.productdetails;
    //generateScatterGrapgh(productid);
}
function getQRJSONOfProductDetails() {
    return qandrPDetail;
}

var ProductDetail = function (productid, detail) {
    this.productID = productid;
    this.jsonDetail = detail;
    console.log("ProductDetail Object Created");
};
ProductDetail.prototype.displayProductID = function () {
    console.log("Object representing " + this.productID + " has been created...");
};
ProductDetail.prototype.getProductID = function () {
    return this.productID;
};
ProductDetail.prototype.getJsonDetail = function () {
    return this.jsonDetail;
};

function plotChart() {

}

var n = function (name) {
    console.log(name);
};

var CreatePlot = function (data1, ticks1, prodid1, chart) {
    //var data = [[0, 81], [1, 19]];
    var data = [];
    var ticks = [];
    var prodid = "";
    var label = "Aspects";
    data = data1;
    ticks = ticks1;
    prodid = prodid1;
    //var data2 = [[0, 85], [1, 15]];
    //var data3 = [[0, 82], [1, 18]];
    //var data4 = [[0, 100], [1, 0]];
    var dataset = [{label: label, data: data, color: "#5482FF"}];
    //var dataset2 = [{label: "Aspects", data: data2, color: "#5482FF"}];
    //var dataset3 = [{label: "Aspects", data: data3, color: "#5482FF"}];
    //var dataset4 = [{label: "Aspects", data: data4, color: "#5482FF"}];

    //var ticks = [[0, "camera"], [1, "picture"]];

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
            axisLabel: "S-score",
            axisLabelUseCanvas: true,
            axisLabelFontSizePixels: 12,
            axisLabelFontFamily: 'Verdana, Arial',
            axisLabelPadding: 3,
            minTickSize: 0.5,
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

    $(document).ready(function () {

    });

    function start() {
        console.log("kknnkk");
        var p = "#";
        p += prodid;

        console.log("y:" + chart);

        var Dis = function (placeholder, dataset) {
            this.name = "Abdulmumin Eneye Abdulkarim";
            this.q = placeholder;
            this.datase = dataset;
        };
        Dis.prototype.sayHello = function () {
            console.log("Hello, I'm " + this.name + " " + this.q + " " + this.datase);
            chart = $.plot($(this.q), this.datase, options);
            $(this.q).UseTooltip();

        };
        var x = new Dis(p, dataset);
        x.sayHello();

    }
    ;

    function gd(year, month, day) {
        return new Date(year, month, day).getTime();
    }
    ;

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
    ;
    start();
};
$(document).ready(function () {


});

function loadChart(o, data, ticks) {
    $(o).highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: 'Sentiment Scores'
        },
        xAxis: {
            categories: ticks
        },
        yAxis: {
            title: {
                text: 'Scores'
            }
        },
        series: [{
                name: 'Aspect',
                data: data
            }]
    });
}
;
var series = [];
function setSeries(data, p) {
    var input = {};
    input = {
        name: p,
        data: data
    };
    series.push(input);
}
function getSeries() {
    //newly added
    var s = series;
    series = [];
    return s;
}
var options;
function setOptions(placeholder, data, ticks, ytitle, stitle) {
    options = null;
    options = {
        chart: {
            renderTo: placeholder,
            type: 'column'
        },
        title: {
            text: ''
        },
        xAxis: {
            categories: ticks
        },
        yAxis: {
            title: {
                text: ytitle
            }
        },
        series: [{
                name: stitle,
                data: data
            }]
    };


}
//
function getOptions() {
    return options;
}
//
function myChart() {
    var chart = null;
    chart = new Highcharts.Chart(getOptions());
}
function setOptionsS(placeholder, ticks,ytitle) {
    options = null;
    options = {
        chart: {
            renderTo: placeholder,
            type: 'column'
        },
        title: {
            text: ''
        },
        xAxis: {
            categories: ticks
        },
        yAxis: {
            title: {
                text: ytitle
            }
        },
        series: getSeries()
    };
}
function getOptionsS() {
    return options;
}
function myChartS() {
    var chart = null;
    chart = new Highcharts.Chart(getOptionsS());
}
function sum(i, aspect) {

    var sum = 0;
    for (var h = 0; h < aspect.length; h++) {
        var score = i.getJsonDetail().aspects[aspect[h]].score;
        var absScore = Math.abs(score);
        console.log(absScore);
        sum += absScore;
    }
    //var s = sum.toFixed(2);
    return sum;
}
function value(n, sum) {
    var value = 0.0;
    var v = 0.0;
    var q = 0.0;
    value = (n / sum);
    v = value.toFixed(2);
    q = value.toPrecision(2);
    //console.log(v);
    return v;

}
var ob = {};
var ar = [];

function generateScattergraph() {
    var obj = readMe();
}
function generateScatterGrapgh(productid, scatter) {
    console.log("qpq: " + productid);
    //var obj = readMe();
    var details = getQRJSONOfProductDetails();
    console.log("qpq: " + details);
    ob = details[productid];
    console.log(details);
    ar = ob.aspectList;
    var a = [];
    var b;
    var c;
    var d = [];
    for (var i = 0; i < ar.length; i++) {
        b = {};
        c = [];
        console.log(ar[i]);
        console.log(ob.aspects[ar[i]].score);
        console.log(ob.aspects[ar[i]].freq);
        var v = parseFloat(ob.aspects[ar[i]].score);
        var w = parseInt(ob.aspects[ar[i]].freq);
        //console.log(v);
        //console.log(w);
        c.push(v);
        c.push(w);
        b = {
            name: ar[i],
            color: 'rgba(223, 83, 83, .5)',
            data: c

        };
        a.push(b);
        d.push(c);
    }
    var p = "#";
    p += productid + scatter;
    scatterChart(d, p);
    console.log(d);
}

function scatterChart(data, p) {
    $(p).highcharts({
        chart: {
            type: 'scatter',
            zoomType: 'xy'
        },
        title: {
            text: ''
        },
        subtitle: {
            text: ''
        },
        xAxis: {
            title: {
                enabled: true,
                text: 'Sentiment Scores'
            },
            startOnTick: true,
            endOnTick: true,
            showLastLabel: true
        },
        yAxis: {
            title: {
                text: 'Frequency'
            }
        },
        legend: {
            layout: 'vertical',
            align: 'left',
            verticalAlign: 'top',
            x: 100,
            y: 70,
            floating: true,
            backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF',
            borderWidth: 1
        },
        plotOptions: {
            scatter: {
                marker: {
                    radius: 5,
                    states: {
                        hover: {
                            enabled: true,
                            lineColor: 'rgb(100,100,100)'
                        }
                    }
                },
                states: {
                    hover: {
                        marker: {
                            enabled: false
                        }
                    }
                },
                tooltip: {
                    headerFormat: '<b>{series.name}</b><br>',
                    pointFormat: '{point.x} , {point.y} '
                }
            }
        },
        series: [{
                name: 'aspect',
                color: 'rgba(223, 50, 50, .5)',
                data: data
            }]
    });
}

da = [{
        name: 'aspect',
        color: 'rgba(223, 50, 50, .5)',
        data: data
    }];