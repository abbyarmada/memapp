/* Optional: Temporarily hide the "tabber" class so it does not "flash"
   on the page as plain HTML. After tabber runs, the class is changed
   to "tabberlive" and it will appear. */

document.write('<style type="text/css">.tabber{display:none;}<\/style>');

/*==================================================
  Set the tabber options (must do this before including tabber.js)
  ==================================================*/
var tabberOptions = {

  'cookie':"tabber", /* Name to use for the cookie */

  'onLoad': function(argsObj)
  {
    var t = argsObj.tabber;
    var i;
    var test;


    /* Optional: Add the id of the tabber to the cookie name to allow
       for multiple tabber interfaces on the site.  If you have
       multiple tabber interfaces (even on different pages) I suggest
       setting a unique id on each one, to avoid having the cookie set
       the wrong tab.
    */
    
    if (t.id) {
      t.cookie = t.id + t.cookie;
    }
    
    // in case of error, display the tab with an error. 
    test = checkfieldsWithErrors('div'); 
    if ( test == 1 ) 
    {
    	tt = getErrorElementsByClassName('div');
    	//alert('error tab:' + tt );
    	t.tabShow(tt);
    }
    else
    {
	    /* If a cookie was previously set, restore the active tab */
	    i = parseInt(getCookie(t.cookie));
	    if (isNaN(i)) { return; }
	    t.tabShow(i);
    }

  },

  'onClick':function(argsObj)
  {
    var c = argsObj.tabber.cookie;
    var i = argsObj.index;
    setCookie(c, i);
  }
  
  
};

/*==================================================
  Cookie functions
  ==================================================*/
function setCookie(name, value, expires, path, domain, secure) {
    document.cookie= name + "=" + escape(value) +
        ((expires) ? "; expires=" + expires.toGMTString() : "") +
        ((path) ? "; path=" + path : "") +
        ((domain) ? "; domain=" + domain : "") +
        ((secure) ? "; secure" : "");
}

function getCookie(name) {
    var dc = document.cookie;
    var prefix = name + "=";
    var begin = dc.indexOf("; " + prefix);
    if (begin == -1) {
        begin = dc.indexOf(prefix);
        if (begin != 0) return null;
    } else {
        begin += 2;
    }
    var end = document.cookie.indexOf(";", begin);
    if (end == -1) {
        end = dc.length;
    }
    return unescape(dc.substring(begin + prefix.length, end));
}
function deleteCookie(name, path, domain) {
    if (getCookie(name)) {
        document.cookie = name + "=" +
            ((path) ? "; path=" + path : "") +
            ((domain) ? "; domain=" + domain : "") +
            "; expires=Thu, 01-Jan-70 00:00:01 GMT";
    } 
}

function getErrorElementsByClassName(classname){
	var elements=document.getElementsByTagName(classname);
	var j = 0
	for( i in elements){
		if (elements[i].className == 'tabber') {
			j = 0;
		}
		if (elements[i].className == 'tabbertab') {
			j += 1	;
		}
		if (elements[i].className == 'fieldWithErrors') { 
				
				//return j;	
		}
				
	}	 return j;   
}


function checkfieldsWithErrors(classname){
	var elements=document.getElementsByTagName(classname);
	for( i in elements){
		if (elements[i].className == 'fieldWithErrors') { 	
				 return 1;
		}	
	}
}




