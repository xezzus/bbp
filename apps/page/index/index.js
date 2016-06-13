$(function(){
  var formRegistration = $('form[name=registration]');
  var formSmsSend = $('form[name=smsSend]');
  var formActivation = $('form[name=activation]');
  var formEnter = $('form[name=enter]');
  formRegistration.find('input[type=button]').on('click',function(e){
    var form = $(this).parent();
    var data = {};
    form.find('input[type=text]').each(function(i,e){
      var name = $(e).attr('name');
      var value = $(e).val();
      data[name] = value;
    });
    apps.name('registration').data(data).exec(function(e){
      var json = JSON.stringify(e,null,'  ');
      $('#registration').find('pre').text(json);
    });
  });
  formSmsSend.find('input[type=button]').on('click',function(e){
    var form = $(this).parent();
    var data = {};
    form.find('input[type=text]').each(function(i,e){
      var name = $(e).attr('name');
      var value = $(e).val();
      data[name] = value;
    });
    apps.name('sms/send').data(data).exec(function(e){
      var json = JSON.stringify(e,null,'  ');
      $('#smsSend').find('pre').text(json);
    });
  });
  formActivation.find('input[type=button]').on('click',function(e){
    var form = $(this).parent();
    var data = {};
    form.find('input[type=text]').each(function(i,e){
      var name = $(e).attr('name');
      var value = $(e).val();
      data[name] = value;
    });
    apps.name('activation/to').data(data).exec(function(e){
      var json = JSON.stringify(e,null,'  ');
      $('#activation').find('pre').text(json);
    });
  });
  formEnter.find('input[type=button]').on('click',function(e){
    var form = $(this).parent();
    var data = {};
    form.find('input[type=text]').each(function(i,e){
      var name = $(e).attr('name');
      var value = $(e).val();
      data[name] = value;
    });
    apps.name('enter').data(data).exec(function(e){
      var json = JSON.stringify(e,null,'  ');
      $('#enter').find('pre').text(json);
    });
  });
});
