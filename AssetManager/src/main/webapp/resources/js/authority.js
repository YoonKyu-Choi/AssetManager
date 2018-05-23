/**	관리자 div 표시하는 기능
 * 
 */

var admin = "<%= session.getAttribute(\"isAdmin\") %>";

if(admin == "TRUE"){
	$("div.admin").show();
}