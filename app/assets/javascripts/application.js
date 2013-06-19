// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require cloud
//= require swfobject




$(document).ready(function(){
    var bootstrapButton = $.fn.button.noConflict();
    $.fn.bootstrapBtn = bootstrapButton;
    $(".new_post_input").focus(function() {
       $(".maxsymbols").css('color','blue').fadeIn(800).delay(800).fadeOut(800);
    });

    $("#post_body").focus(function() {
        $(".maxsymbolsbody").css('color','blue').fadeIn(800).delay(800).fadeOut(800);
    });
    $("#post_body").focusout(function() {
        $(".current_symbols").hide();
    });
    $("#post_body").keydown(function() {
        $('.current_symbols').text("current quantity :"+$(this).val().length);
        $(".maxsymbolsbody").hide();
        $(".current_symbols").css('color','blue').fadeIn(800);
    });


    $('a.remote-delete').click(function() {
        $.post(this.href, { _method: 'delete' }, null, "script");
        var id = $(this).attr('name');
        countPosts();
        $(".post_with"+id+"delete").remove();
        $(".all_titles").find("a[href='/posts/"+id+"']").next().remove();
        $(".all_titles").find("a[href='/posts/"+id+"']").remove();
        return false;
    });

      $(".all_titles").mouseenter(function(){
          $(this).css('overflow-y','scroll');
      }).mouseleave(function() {
              $(this).css('overflow-y','hidden');
          });


    countPosts();

})  //end document ready

function add_tag_form(){
    input = $(".tag-name:last");
    if( !input.val() == ''){
        name = input.attr('name');
        var number =  Number(name.replace(/\D+/g,""))+1;
        cloned_input =  input.clone().val('').attr({
            name: 'post[tags_attributes]['+number+'][name]',
            id: 'post_tags_attributes_'+number+'_name'
         });
        $(input).after(cloned_input).after("<span class='icon-minus' onclick=\"remove_tag_form(this)\"></span>");
    };
}

function remove_tag_form(elem){
    if($(elem).parent().find('input').length > 1){
        $(elem).prev().remove();
        $(elem).remove();
    };
}

function countPosts(){
    $.ajax({url:'/posts/count', dataType:"json", type: "post"
    }).success(function(response){

            $('#countwait').text('').append("Waiting to approve: "+response.countwait);
            $('#countapproved').text('').append("Approved: "+response.countapproved);
            $('#countwarning').text('').append("Warning: "+response.countwarning);

     })
}


