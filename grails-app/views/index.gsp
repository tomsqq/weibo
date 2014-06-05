<!doctype html>
<html lang="en">
 <head>
  <link rel="stylesheet" type="text/css" href="${createLinkTo(dir:'css',file:'bootstrap.min.css')}" media="screen" />
  <meta charset="UTF-8">
  <meta name="Generator" content="EditPlus®">
  <meta name="Author" content="">
  <meta name="layout" content="main" />
  <meta name="Keywords" content="">
  <meta name="Description" content="">
  <title>Document</title>
 
  <style type="text/css">
  tr{
   height:auto;
  }
  td.thumbnails{
  	width: 10%;
  }
  div.borderDiv{
    border-right: solid black 1px;
    width: 54px;
    display: inline;
  }
  div.leftDiv{
  	float:left;
  	width: 400px;
  	display: inline;
  }
  div.rightDiv{
  	float:right;
  	width: 300px;
  	display: inline;
  }
  div.commentDiv{
   display: inline;
  }
  div.messageDiv{
  color:#0088cc;
  }
  div.heardDiv{
  font-weight:bold;
  font-size: 14px;
  }
  div.heardDiv a{
  color:#000000;
  }
  </style>
 </head>
 <body style="height:auto">
 <div style="width: 900px;margin: 0 auto;">
  <table id="maintable" class="table table-hover" ></table>
  <ul class="pager">
	  <li id="newer" class="previous disabled">
	    <a href="#" onclick="pagination('newer')">&larr; Newer</a>
	  </li>
	  <li id="older" class="next">
	    <a href="#" onclick="pagination('older')">&rarr; Older</a>
	  </li>
  </ul>
</div>
<g:javascript src="jquery-1.11.1.min.js" />
<g:javascript src="bootstrap.min.js" />
<script type="text/javascript">
var dataCach = {};
var pageFlag = 0;
var regex = /((http|https|ftp|file):\/\/[\S]+)/g;
 $(document).ready(function(){
	
	$.ajax({
        url: "https://api.weibo.com/2/statuses/public_timeline.json",
        type: "GET", 
        dataType: "jsonp",
        data: {
            source: "1443493394",
		    access_token:"2.00Ho5LSCWZkgZB28276b1a730tyfPs",
		    uid: "2100956683",
		    count:"150"
        },
        success: function(json) {
        	dataCach = json;
        	gotoPage(0);
        }
    });

	 
});
function pagination(but_name){
	if(pageFlag==0&&but_name=="newer"){
		return;
	}
	if(pageFlag==140&&but_name=="older"){
		return;
	}
	if(but_name=="newer"){
		pageFlag = pageFlag-10;	
	}else if(but_name=="older"){
		pageFlag = pageFlag+10;
	}
	gotoPage(pageFlag);
}
function gotoPage(pageNum){
  $("#maintable tr").remove();
  var tempData = dataCach.data.statuses.slice(pageNum,pageNum+10);
  var pics;
  for(var a in tempData){
      $("#maintable").append(
        "<tr>"+
        "<td class=\"thumbnails\">"+
        "<img src=\""+tempData[a].user.profile_image_url+"\"class=\"img-polaroid\" style=\"width: 50px;height: 50px;\">"+
        "</td>"+
        "<td>"+
        "<div class=\"heardDiv\"><a href=\""+tempData[a].user.url+"\">"+tempData[a].user.screen_name+"</a></div>"+
        "<div>"+tempData[a].text.replace(regex,"<a href=\"$1\">$1</a>")+"</div>"+
        "<div id=\"picTd"+a+"\"></div>"+
        "<div class=\"messageDiv\"><div class=\"leftDiv\">&nbsp;"+new Date(tempData[a].created_at).toLocaleString()+"&nbsp;&nbsp;&nbsp;<font color=\"black\">来自</font>&nbsp;"+tempData[a].source+"</div><div class=\"rightDiv\"><div class=\"borderDiv\"><i class=\"icon-thumbs-up\"></i>("+tempData[a].attitudes_count+")&nbsp;&nbsp;</div><div class=\"borderDiv\">&nbsp;&nbsp;转发 ("+tempData[a].reposts_count+")&nbsp;&nbsp;</div><div class=\"commentDiv\">&nbsp;&nbsp;评论 ("+tempData[a].comments_count+")&nbsp;</div></div></div>"+
        "</td>"+
        "</tr>");
   pics = tempData[a].pic_urls;
   for(var b in pics){
       $("#picTd"+a).append("<img src=\""+pics[b].thumbnail_pic+"\"class=\"img-rounded\" style=\"width: auto;height: auto;\">");
   }
  }
  if(pageNum==0){
	$("#newer").addClass("disabled");
	$("#newer").removeClass("active");
  }else{
	$("#newer").addClass("active");
	$("#newer").removeClass("disabled");
  }

  if(pageNum==140){
	$("#older").addClass("disabled");
	$("#older").removeClass("active");
  }else{
	$("#older").addClass("active");
	$("#older").removeClass("disabled");
  }	
}




</script>
</body>
</html>