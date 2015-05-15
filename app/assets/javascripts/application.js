// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//= require_self
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require nprogress
//= require nprogress-turbolinks
//= require moment

//= require bootstrap/dist/js/bootstrap

//= require pickers
//= require_tree .

// for decade view in datepicker.. need to set options.. startView: 2
$(function (){
     $("[data-behaviour~='datepicker']").datepicker({
        format: 'yyyy-mm-dd',
        autoclose: true,
        startView:2});
      });
