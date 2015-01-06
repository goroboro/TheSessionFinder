//Still trying to work out how I want to do this... ideally don't try to get this from an online resource...
//rather do something local to convert to SVG... exploring abcm2ps and abcjs

function getTuneSVG(tune,type,key,abc) {
    console.debug("Loading "+tune);
    var timings={
        waltz:'3/4',
        jig:'6/8',
        reel:'4/4',
        slip:'9/8',
        hornpipe:'4/4',
        polka:'2/4',
        slide:'12/8',
        barndance:'4/4',
        strathspey:'4/4',
        three: '3/2',
        mazurka: '3/4'
    };

    var time = timings.valueOf(type);

    var http = new XMLHttpRequest();

    //http.open("POST", 'http://www.mandolintab.net/abcconverter.php', true);
    http.open("POST", 'http://www.concertina.net/tunes_detail.html?action=convert', true);
    http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
    var enc_x=encodeURIComponent('X: 1');
    var enc_tune=encodeURIComponent('T: '+tune);
    var enc_type=encodeURIComponent('R: '+type);
    var enc_time=encodeURIComponent('M: '+time);
    var enc_key=encodeURIComponent('K: '+key);
    var enc_abc=encodeURIComponent(abc);
    //console.debug("Loading "+abc);
    //http.send("abc="+enc_x+'%0D%0A'+enc_tune+'%0D%0A'+enc_type+'%0D%0A'+enc_time+'%0D%0A'+enc_key+'%0D%0A'+enc_abc+'&dispoff[0]=Q&transpose=0&ratio=0&stress=0&tab=3&tabkey=12&autolinebreak=off&abcver=&paper=letter&graphic=svg&output=abc&submit=submit');
    http.send("body="+enc_x+'%0D%0A'+enc_tune+'%0D%0A'+enc_type+'%0D%0A'+enc_time+'%0D%0A'+enc_key+'%0D%0A'+enc_abc+'&submit=submit');
    var resp=abc;
    http.onreadystatechange = function() {
        if (http.readyState == 4) {
            resp=http.responseText;
            console.log(resp);
        }
}
    return resp
}

