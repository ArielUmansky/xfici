$(document).ready(function(){
	function hideAndShowFriendLinks(id, hideDiv, showDiv, method, requireIdInUrl){
		url = "/friendships";
		if (requireIdInUrl && id!=null)
			url = url + "/" + id 
		$.ajax({
			type: method,
			daraType: "json",
			url: url,
			data: {
				friendship: { friend_id: id }
			}
		}).done(function(response){
      		$($("." + hideDiv + "[data-friend='" + id + "']")[0]).parent().hide()
      		$("." + showDiv + "").find("." + showDiv + "-link[data-friend='" + id + "']").parent().show()
		})
	}
  $(".cancel-friendship-link").click(function(e) {
  	hideAndShowFriendLinks($(e.target).data("friend"), "cancel-friendship-link", "request-friendship", "DELETE", true)
  	$("#PendingFriends").text(Number($("#PendingFriends").text()) - 1)
  })
 $(".request-friendship-link").click(function(e) {
    hideAndShowFriendLinks($(e.target).data("friend"), "request-friendship-link", "cancel-friendship", "POST", false)
    $("#PendingFriends").text(Number($("#PendingFriends").text()) + 1)
  })
 $(".accept-friendship-link").click(function(e) {
  	hideAndShowFriendLinks($(e.target).data("friend"), "accept-friendship-link", "delete-friendship", "PUT", true)
  	$("#Friends").text(Number($("#Friends").text()) + 1)
  	$("#RequestedFriends").text(Number($("#RequestedFriends").text()) - 1)
  })
 $(".reject-friendship-link").click(function(e) {
    hideAndShowFriendLinks($(e.target).data("friend"), "reject-friendship-link", "request-friendship", "DELETE", true)
  	$("#RequestedFriends").text(Number($("#RequestedFriends").text()) - 1)
  })
 $(".delete-friendship-link").click(function(e) {
    hideAndShowFriendLinks($(e.target).data("friend"), "delete-friendship-link", "request-friendship", "DELETE", true)
 	$("#Friends").text(Number($("#Friends").text()) - 1)
 })
})