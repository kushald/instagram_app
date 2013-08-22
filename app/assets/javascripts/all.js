$(function() {

  $.getJSON('/login-check', function(data) {
    if(data["status"] == 1) {
      $('#feed').html('<a href="/user">Feeds</a>');
      $('#login-check').html("<a href='/logout'>Logout</a></div>");
    } else {
      $('#feed').removeClass('none');
      $('#login-check').html("<a href='/login' class='button' style='background: #202020;color: white;font-family: &quot;Droid sans&quot;;font-size: 16px;border: none;font-weight: 700;border-radius: 5px;margin-top: 12px;'><img src='/assets/Instagram_Icon.png' style='width: 26px;'>Sign In With Instagram</a>");
    }
  });

  $(window).scroll(function() {
    if ($(this).scrollTop() > 200) {
      $('.go-top').fadeIn(200);
    } else {
      $('.go-top').fadeOut(200);
    }
  });

  // Animate the scroll to top
  $('.go-top').click(function(event) {
    event.preventDefault();
    
    $('html, body').animate({scrollTop: 0}, 300);
  })

  var pull    = $('#pull');
  menu    = $('nav ul');
  menuHeight  = menu.height();

  $(pull).on('click', function(e) {
    e.preventDefault();
    menu.slideToggle();
  });

  $(window).resize(function(){
    var w = $(window).width();
    if(w > 320 && menu.is(':hidden')) {
      menu.removeAttr('style');
    }
  });

  $("#fittext1").fitText();

  $("#refresh-feed").click(function(){
    $("#image-loader").show();
    $("#disp").addClass("opaque");
    $.ajax({
      url: "/popular",
      success: function(response) {
        $("#image-loader").hide();
        $("#disp").removeClass("opaque");
        $("#disp").html(response);
      }
    });
  });

  // Like heart at front 
  $(".white").click(function(){
      var mediaId = this.id;
      likeCount = parseInt($('#'+mediaId).attr('data-likes'))+1;
      $('#'+mediaId).fadeOut("slow", function(){
        $('#'+mediaId).fadeIn();
        $('#'+mediaId).addClass('red');
        $('#'+mediaId).removeClass('white');
        $('#bar-font-'+mediaId+' span').text(likeCount);
      });

      $.ajax({
        url: "/like-media",
        type: 'POST',
        data: {"media_id" : mediaId},
        success: function(response) {
        }
      });
    });

  $("#like-media").click(function(){
    likeCount = parseInt($(this).attr('data-likes'))+1;
    $('#like-media').addClass('red');
    $('#like-media').removeClass('white');
    $('#like-count span').text(likeCount);

    $.ajax({
      url: "/like-media",
      type: 'POST',
      data: {"media_id" : $("#like-media").attr("val")},
      success: function(response) {
        console.log("phew!!!!");
      }
    });
  });

// Follow Users
  $("body").on("click","#relation-none",function(){
    $("#relation-none").css({"opacity": 0.4});
    var uid = $('#getuid').attr('uid');
    $.ajax({
      url: "/relationship/"+uid,
      type: "POST",
      data: {instagram_action : "follow", media_id : $("#uname").attr("val") },
      success: function(response) {
        $("#relation-none").css({"background-color": "#45C491", "opacity": 1});
        $("#relation-none").text("following");
      }
    });
  });

  $(".follow-btn-media").click(function(){
    $(".follow-btn-media").css({"opacity": "0.6"});
    var uid = $(".uploader").attr('uid');
    $.ajax({
      url: "/relationship/"+uid,
      type: "POST",
      data: {instagram_action : "follow", media_id : $("#uname").attr("val") },
      success: function(response) {
        $(".follow-btn-media").css({"background-color": "#85A32B"});
        $(".follow-btn-media").text("following");
        $(".follow-btn-media").css({"opacity": "1"});
      }
    });
  });


  $('#comment-button').click(function(){
    var text = $('textarea').val();
    $.ajax({
      url: '/comment',
      type: 'POST',
      data: { text: text, media_id: $("#uname").attr("val") },
      success: function(){
        alert("done");
      }
    });
  });


  $('#fb-share').click(function(){
    var obj = {
        method: 'feed',
        //redirect_uri: 'http://127.0.0.1:3000',
        link: $(this).attr("link"),
        picture: $(this).attr("picture"),
        name: 'Joyviewer.com - fun way to view and share instagram content',
        caption: $(this).attr("caption"),
        description: "Instagram Web Viewer"
      };
    function callback(response) {
        //console.log(response);
      }
    FB.ui(obj, callback);
  });


  $("#profile-load").load('/profile_count/'+$('#profile-load').attr('uid'), function(responseText, statusText, xhr){
    var uid = $('#profile-load').attr('uid');
    if ($('#profile-load').attr('logged-in') == "1") {
      $.ajax({
        url: "/relation/"+uid,
        type: "GET",
        success: function(response) {
          if(response["status"] == "follows") {
            $("#relation-check").html('Following');
            $("#relation-check").addClass('button');
            $("#relation-check").attr('id','relation-follows');
          }
          else {
            $("#relation-check").html('Follow me');
            $("#relation-check").addClass('button');
            $("#relation-check").attr('id','relation-none'); 
          }
        }
      });
    }
  });

  $("#browse-user").load('/browse-user/'+$('#browse-user').attr('uid'), function(responseText, statusText, xhr){
    var uid = $('#browse-user').attr('uid');
    if ($('#browse-user').attr('logged-in') == "1") {
      $.ajax({
        url: "/relation/"+uid,
        type: "GET",
        success: function(response) {
          if(response["status"] == "follows") {
            $("#relation-check").html('Following');
            $("#relation-check").addClass('button');
            $("#relation-check").attr('id','relation-follows');
          }
          else {
            $("#relation-check").html('Follow me');
            $("#relation-check").addClass('button');
            $("#relation-check").attr('id','relation-none'); 
          }
        }
      });
    }
  });


});