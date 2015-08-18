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


function processAspect() {
    
    var mm = document.getElementsByClassName('comparisonaspects');
    formaspects = mm;
    
    for (var y = 0; y < formaspects.length; y++) {
        y++;

        if (y < 10) {
            var v = formaspects[y].value;
            formarraspect.push(v);
        }

    }
    isCompare = true;
     
}
var formarr = [];
var formarraspect = [];
var formaspects;
var isCompare = false;
function compare() {
    
    var yy = document.getElementsByClassName('productsid');
    form1 = yy;
    isCompare = true;

    for (var t = 0; t < form1.length; t++) {
       
        var v = form1[t].value;
        formarr.push(v);
    }
    var p = form1[0].value;
    cStatus = true;
    retrievePRJSONDet(p, '1', 'compare', 'star');
     

}
var form = null;
var form1 = null;
var formarray;

$(document).ready(function () {
    //alert("j");
    //alert('hhhh');
    var x = document.getElementsByClassName('starsfreq');
    form = x;

    var y = document.getElementById('js');
    var object = {};

    object = $("#js").data("object");


});
var stars = [];
function setRatingArr(a) {
    console.log('M:setRatingArr()-AC');
    var star5 = "5 star";
    var star4 = "4 star";
    var star3 = "3 star";
    var star2 = "2 star";
    var star1 = "1 star";

    stars.push(star5);
    stars.push(star4);
    stars.push(star3);
    stars.push(star2);
    stars.push(star1);
}
function getRatingArr() {
    console.log('M:getRatingArr()-AD');
    var arr = stars;
    //stars = [];

    return arr;
}
var starVal = [];
function setStarRatings(t, r1, r2, r3, r4, r5) {
    console.log('M:setStarRatings()-AE');
    starVal.push(parseInt(r5));
    starVal.push(parseInt(r4));
    starVal.push(parseInt(r3));
    starVal.push(parseInt(r2));
    starVal.push(parseInt(r1));
}
function getStarRatings() {
    console.log('M:getStarRatings()-AF');
    var arr = starVal;
    starVal = [];

    return arr;
}
var graphStat = false;
function callRatingGraph(p) {
    console.log('M:callRatingGraph()-AG');


if(cStatus===true){
    var graphStat = ratingGraph('sing', p);
    
    }
    if(dStatus===true){
        
        ratingGraph('sing',p);
         ratingGraph('mult',p);
        
    }
    
}
function ratingGraph(type, p) {
    console.log('M:ratingGraph()-AH');
    
    setRatingArr();
    //type - false/true
    var starr = getRatingArr();

    console.log("star len: " + starr.length);
    var s = '';
    var id = '';

    var ytitle = 'Frequency';
    var stitle = 'Star Rating';
    var obj = readMe();


    //alert("cont: "+form[0].prodid.value+'obj: '+obj[0].getProductID());
    for (var y = 0; y < obj.length; y++) {
        
        var i = obj[y];
        
        for (var w = 0; w < form.length; w++) {
            if (obj[y].getProductID() === form[w].prodid.value) {
                alert('n'+form.length);
                //console.log("cont: " + form[0].prodid.value + 'obj: ' + obj[0].getProductID());

                var data1 = [];
                var ticks1 = [];
                ticks1 = starr;
                
                //alert(form[w].star1.value);
                //var t = parseInt(form[w].tot.value);
                var t;
                if(cStatus===true){
                    t = parseInt(form[w].tot.value);
                }
                var r5 = parseInt(form[w].star5.value);
                var r4 = parseInt(form[w].star4.value);
                var r3 = parseInt(form[w].star3.value);
                var r2 = parseInt(form[w].star2.value);
                var r1 = parseInt(form[w].star1.value);
                setStarRatings(t, r1, r2, r3, r4, r5);
                
                data1 = getStarRatings();
                
                if (type === 'sing') {
                    id = obj[0].getProductID();
                    
                    if (p === undefined) {
                        
                        //alert('yes');
                        s = id + '_r';
                    } else if (p === 'star') {
                        
                        id = obj[y].getProductID();
                        s = id + '_r_comp';
                        var r = 'no_r_' + (y + 1);
                        document.getElementById(r).innerHTML = t;
                    }
                    setOptions(s, data1, ticks1, ytitle, stitle);
                    myChart();
                    
                    if (y === obj.length - 1) {
                        
                        return true;
                    }

                } else if (type === 'mult') {
                    
                    setSeries(data1, y + 1);

                    id = obj[0].getProductID();

                    s = id + '_r_mult_rating';
                    
                    if (y === obj.length - 1) {
                        
                        setOptionsS(s, ticks1, ytitle);
                        
                        var n = myChartS();
                        //alert(n);                        
                        return true;
                    }
                }
            }
        }
    }
    return true;

}
function show(s, id) {
    console.log('M:show()-AI');
    var g = id + '_mult_sentiment';
    var q = id + '_r';
    var f = id + '_r_mult_rating';
    document.getElementById("graphtitle").innerHTML = "Aspect Graph (Query Product)";
    document.getElementById(f).style.display = 'none';
    document.getElementById("rss").style.display = 'none';
    document.getElementById(g).style.display = 'none';
    document.getElementById(q).style.display = 'block';
    document.getElementById("graphtitler").style.display = 'block';
    document.getElementById(id).style.display = 'block';
    document.getElementById("msgrss").style.display = 'block';

    //h.display = "none";

}
function hide(h) {
    console.log('M:hide()-AJ');
    //alert("hey");
    //h.display = "none";

}
//product-recommendation-detail getProductID for mult
//1 for multiple bar
//2 for single bar
var h = 0;
var queryP = '';
function showMult(m, n) {
    console.log('M:showMult()-AK');
    var id, s;
    var c = document.getElementsByClassName('product_graph_d');
    m.style.display = 'none';
    for (var b = 0; b < c.length; b++) {
        // c[b].style.display = 'none';
    }

    if (n === '1') {

        id = m.id.valueOf();
        s = id + '_mult_sentiment';
        var q = id + "_r";
        document.getElementById(q).style.display = 'none';
        document.getElementById("graphtitler").style.display = 'none';
        //document.getElementById("rss").innerHTML = 'reset';
        document.getElementById("graphtitle").innerHTML = 'Aspect Graph (Comparison)';
        if (h === 0) {
            writeMe("1", null, s);
            h++;
        }


    } else if (n === '2') {
        id = m.id.valueOf();
        s = id + '_mult_rating';
        document.getElementById(queryP).style.display = 'none';
        document.getElementById("graphtitler").style.display = 'none';
        document.getElementById("graphtitle").innerHTML = 'Rating Distribution Graph (Comparison)';
    }


    var e = document.getElementById(s);

    e.style.display = 'block';

    document.getElementById("rss").style.display = 'block';
    document.getElementById("msgrss").style.display = 'none';

}
//product-recommendation-detail getProductID for desc
function showDes(m) {
    console.log('M:showDes()-AL');
    var id = m.name.valueOf();
    displayDes(id);
}
//product-recommendation-detail display desProductID  
function displayDes(id) {
    console.log('M:displayDes()-AM');
    var s = 'i_';
    s += id;

    var c = document.getElementsByClassName('product_desc_d');

    for (var b = 0; b < c.length; b++) {
        c[b].style.display = 'none';
    }

    var e = document.getElementById(s);

    e.style.display = 'block';
}

$(document).ready(function () {

    $('span.stars').stars();
    console.log('M:onready()-AN');

});

$.fn.stars = function () {
    console.log('M:stars()-AO');
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
    console.log('M:aspectSelect()-AP');
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

            for (var b = 0; b < c.length; b++) {
                c[b].disabled = true;
            }
        }
    }
    console.log(window.document.location.search);
}
function productSelect(produ){
    console.log('M:aspectSelect()-AP');
    var asarrele = [];
    tempobj = produ;
    asarrele.push(tempobj);
    var aspect = produ.value;

    asarr.push(aspect);
    tempobj.disabled = true;

    if (asarr.length > 0) {
        if (iii < 2) {
            
            iii++;
        } else {
            var c = document.getElementsByClassName('productComp');

            for (var b = 0; b < c.length; b++) {
                c[b].disabled = true;
            }
        }
    }
}

function clearSelection(a) {
    console.log('M:clearSelection()-AQ');
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
//var queryP;
var stat = false;
function retrievePRJSONDet(queryProduct, opt, page, rate) {
    
    console.log('M:retrievePRJSONDet()-RR');
    var arr = [];
    arr = formarr;
    var data = "";
    //data = "s=" + s1 + '&s=' + s2 + '&s=' + s3;
    if (arr.length > 0) {
        for (var n = 0; n < arr.length; n++) {
            if (n === 0) {
                data += 's=' + arr[n];
            } else {
                data += '&s=' + arr[n];
            }
        }
    }
    var ext = "pcomparison";
    var url = "/Prototype_ESRS-war/" + ext;
    var type = "GET";

    var dtype = 'json';
    console.log('url:- ' + url);
    $.ajax({
        type: type,
        url: url,
        data: data,
        datatype: dtype,
        success: function (msg) {
            console.log("Ajax Call Successful");
            console.log("RR1" + msg);
            setProductJSONDetails(msg);
            setQRArrayOfProductList(msg);
            setQRJSONOfProductDetails(msg, queryProduct);
            queryP = queryProduct;
            processAspect();
            
            if (page === 'detail') {
                console.log('R1');
                stat = writeMe(opt, null);
                console.log('R2');
                if (stat === true) {
                    console.log('R3');
                    grStatus = callRatingGraph();
                    //status = writeMe(opt, null);
                    console.log('R4');
                }
            }

            if (page === 'compare') {
                console.log('R5');
                writeMe(opt, null);
                //alert('1');
                showGraphOnCompare(page);
                //alert('2');
                callRatingGraph(rate);
                
                console.log('R6');
                console.log('status: ' + status);
                
                if (stat === true) {
                   
                    console.log('R7');
                    grStatus = showGraphOnCompare(page);
                    console.log('R8');
                    if (grStatus === true) {
                         
                        console.log('R9');
                        if (rate === 'star') {
                            
                            console.log('R10');
                            callRatingGraph(rate);
                            
                            console.log('R11');
                        }
                    }
                }

            } else if (page === undefined) {
                console.log('R12');
                writeMe(opt, null);
            }


        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log("Error: " + jqXHR.status + " ,Status: " + textStatus + " ,ErrorThrown: " + errorThrown);
        }

    });
    console.log("Ajax call: Function End");
    return stat;
}

var cStatus = false;
var dStatus = false;
var status = false;
function retrievePRJSONDetail(queryProduct, opt, page, rate) {
    console.log('M:retrievePRJSONDetail()-R');
    var ext = "search";
    var url = "/Prototype_ESRS-war/" + ext;
    var type = "GET";
    var data = "product=" + queryProduct;
    var dtype = 'json';
    console.log('url:- ' + url);
    $.ajax({
        type: type,
        url: url,
        data: data,
        datatype: dtype,
        success: function (msg) {
            console.log("Ajax Call Successful");

            queryP = queryProduct;
            setProductJSONDetails(msg);
            setQRArrayOfProductList(msg);
            setQRJSONOfProductDetails(msg, queryProduct);
            processAspect();//overrides the default aspect selections
            if (page === 'detail') {

                console.log('R1');
                
                dStatus = true;
                status = writeMe(opt, null);
                
                grStatus = callRatingGraph();
                
                console.log('R2');
                if (status === true) {

                    console.log('R3');
                    grStatus = callRatingGraph();
                    //status = writeMe(opt, null);
                    console.log('R4');
                }
            }

            if (page === 'compare') {
                console.log('R5');
                writeMe(opt, null);
                
                showGraphOnCompare(page);
                
                cStatus = true;
                callRatingGraph(rate);
                
                console.log('R6');
                
                console.log('status: ' + status);
                
                if (status === true) {
                    
                    console.log('R7');
                    grStatus = showGraphOnCompare(page);

                    console.log('R8');
                    if (grStatus === true) {

                        console.log('R9');
                        if (rate === 'star') {
                            console.log('R10');
                            callRatingGraph(rate);
                            console.log('R11');
                        }
                    }
                }

            } else if (page === undefined) {
                console.log('R12');
                writeMe(opt, null);
            }


        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log("Error: " + jqXHR.status + " ,Status: " + textStatus + " ,ErrorThrown: " + errorThrown);
        }

    });
    console.log("Ajax call: Function End");
    return status;
}
var completeDetail = null;
function setProductJSONDetails(msg) {
    console.log('M:setProductJSONDetails()-A');
    completeDetail = msg;
}
function getProductJSONDetails() {
    console.log('M:getProductJSONDetails()-B');
    return completeDetail;
}
function displayScores() {
    n("inyene");
}
//important
var p = [];
function readMe() {
    console.log('M:readMe()-C');
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
    console.log('M:setAspectArr()-D');
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
    console.log('M:getAspectArr()-E');
    var arr = aspect;
    //aspect = [];

    return arr;
}
function showGraphOnCompare(page) {
    console.log('M:showGraphOnCompare()-F');
    writeMe("2", null, page);
    //alert('5');
    return true;
}
var tt = " ";
//alert(isCompare);
setAspectArr();
function writeMe(n, as, dID) {
    console.log('M:writeMe()-G');
    var ytitle = 'Score';
    var stitle = 'Aspect';
    console.log(dID);
    if (as !== null) {
        var aspectArr = as;
    } else if (isCompare === false) {
        var aspectArr = getAspectArr();
    } else if (isCompare === true) {
        var aspectArr = formarraspect;
    }




    var obj = readMe();
    //alert('size' + obj.length);
    for (var y = 0; y < obj.length; y++) {

        var i = obj[y];



        var data1 = [];
        var ticks1 = [];

        var s = sum(i, aspectArr);

        for (var k = 0; k < aspectArr.length; k++) {

            var q = 0.0;
            q = value(i.getJsonDetail().aspects[aspectArr[k]].score, s);
            var v = parseFloat(q);

            var ll = i.getJsonDetail().aspects[aspectArr[k]].score;
            var l = parseFloat(ll);
            ticks1.push(aspectArr[k]);
            //non-nomilized
            data1.push(l);
            //nomilized
            //data1.push(v);


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
                
                setOptionsS(id, ticks1, ytitle);
                var st = myChartS();
                //alert(st);
                return st;
            }
            

        } else if (n === "2") {
            
            if (dID === undefined) {
                
                setOptions(i.getProductID(), data1, ticks1, ytitle, stitle);
            } else if (dID === 'compare') {
                
                var id = i.getProductID() + '_comp';
                //alert(id);
                setOptions(id, data1, ticks1, ytitle, stitle);
                
            } else {
                
                setOptions(dID, data1, ticks1, ytitle, stitle);
            }


            myChart();
            if(dStatus === true){
                return true;
            }            
            //exits this loop
            if (y === obj.length - 1) {

                return true;
            }
        }


    }

}

var qandrPList = [];
function setQRArrayOfProductList(msg) {
    console.log('M:setQRArrayOfProductList()-H');
    qandrPList = msg.productlist.arrayrecomm;
}
function getQRArrayOfProductList() {
    console.log('M:getQRArrayOfProductList()-I');
    return qandrPList;
}
var qandrPDetail = {};
function setQRJSONOfProductDetails(msg, productid) {
    console.log('M:setQRJSONOfProductDetails()-J');
    qandrPDetail = msg.productdetails;
    //generateScatterGrapgh(productid);
}
function getQRJSONOfProductDetails() {
    console.log('M:getQRJSONOfProductDetails()-K');
    return qandrPDetail;
}

var ProductDetail = function (productid, detail) {
    console.log('C:ProductDetail()-L');
    this.productID = productid;
    this.jsonDetail = detail;
    console.log("ProductDetail Object Created");
};
ProductDetail.prototype.displayProductID = function () {
    console.log('CM:displayProductID()-M');
    console.log("Object representing " + this.productID + " has been created...");
};
ProductDetail.prototype.getProductID = function () {
    console.log('CM:getProductID()-N');
    return this.productID;
};
ProductDetail.prototype.getJsonDetail = function () {
    console.log('CM:getJsonDetail()-O');
    return this.jsonDetail;
};

function plotChart() {

}

var n = function (name) {
    console.log(name);
};


$(document).ready(function () {


});

function loadChart(o, data, ticks) {
    console.log('M:loadChart()-P');
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
    console.log('M:setSeries()-Q');
    var input = {};
    input = {
        name: p,
        data: data
    };
    series.push(input);
}
function getSeries() {
    console.log('M:getSeries()-R');
    //newly added
    var s = series;
    series = [];
    return s;
}
var options;
function setOptions(placeholder, data, ticks, ytitle, stitle) {
    console.log('M:setOptions()-S');
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
    console.log('M:getOptions()-T');
    return options;
}
//
function myChart() {
    console.log('M:myChart()-U');
    var chart = null;
    chart = new Highcharts.Chart(getOptions());
    return true;
}
function setOptionsS(placeholder, ticks, ytitle) {
    console.log('M:setOptionsS()-V');
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
    console.log('M:getOptionsS()-W');
    return options;
}
function myChartS() {
    console.log('M:myChartS()-X');
    var chart = null;
    chart = new Highcharts.Chart(getOptionsS());
    return true;
}
function sum(i, aspect) {
    console.log('M:sum()-Y');

    var sum = 0;
    for (var h = 0; h < aspect.length; h++) {
        var score = i.getJsonDetail().aspects[aspect[h]].score;
        var absScore = Math.abs(score);

        sum += absScore;
    }
    //var s = sum.toFixed(2);
    return sum;
}
function value(n, sum) {
    console.log('M:value()-Z');
    var value = 0.0;
    var v = 0.0;
    var q = 0.0;
    value = (n / sum);
    v = value.toFixed(2);
    //q = value.toPrecision(2);
    //console.log(v);
    return v;

}
var ob = {};
var ar = [];

function generateScatterGraph(productid, scatter) {
    console.log('M:generateScatterGraph()-AA');
    //var obj = readMe();
    var details = getQRJSONOfProductDetails();

    ob = details[productid];

    ar = ob.aspectList;
    var a = [];
    var b;
    var c;
    var d = [];
    for (var i = 0; i < ar.length; i++) {
        b = {};
        c = [];

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

}

function scatterChart(data, p) {
    console.log('M:scatterChart()-AB');
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

