//= require active_admin/base




$(document).ready(function(){

});



function AddAndRenameAdminInput(){
    input = $(".tag-name:last");
    name = input.attr('name');
    console.log(name);
    var number =  Number(name.replace(/\D+/g,""))+1;                                                    //выбираем число 3 из  post[tags_attributes][3][name] и добавляем 1
     cloned_input =  input.clone().val('').attr('name','post[tags_attributes]['+number+'][name]');
    $(input).after(cloned_input);
    console.log(number);
    //changeNameInAdmin();
}

function RemoveAdminInput(){
    $('.tag-name:last').remove();
}