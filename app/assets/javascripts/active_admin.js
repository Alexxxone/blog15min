//= require active_admin/base




$(document).ready(function(){
    select_options();
           $("#post_confirmed option").click(function(){
               select_options();
           });


});

function select_options(){
    if( $("#post_confirmed :selected").val()==2){
        //показать поле для ввода комента
        $('.inputs:last').prev().after("<fieldset class='inputs' id='comments_field'><legend><span>Message to user</span></legend><ol><li><textarea id='comments_body'  name='comment[body]'></textarea></li><a class='btn btn-small pull-right' onclick='admin_send_comment()'>Send comment</a></ol>");



    }else{
        //спрятать поле для ввода комента
        $('#comments_field').remove();

    }
}

function admin_send_comment(){

    comment = {body: $('#comments_body').val()};
    post_id =  Number($('#edit_post').attr('action').replace(/\D+/g,"")) ;

    $.ajax({url:'/admin/comments/'+post_id+'/add_comment/', data: {  post_id: post_id, comment: comment}, dataType:"json", type: "get"
    }).success(function(response){
               console.log(response.text);
            $('#comments_body').val('');
            $('#comments_field').prepend("<p style='color:green;' class='sending_result'>"+response.text+"</p>")
             $('.sending_result').delay(800).slideUp(600);
        })

}

function AddAndRenameAdminInput(){
    input = $(".tag-name:last");
    name = input.attr('name');
    var number =  Number(name.replace(/\D+/g,""))+1;                                                    //выбираем число 3 из  post[tags_attributes][3][name] и добавляем 1
     cloned_input =  input.clone().val('').attr('name','post[tags_attributes]['+number+'][name]');
    $(input).after(cloned_input);
}

function RemoveAdminInput(){
    $('.tag-name:last').remove();

}