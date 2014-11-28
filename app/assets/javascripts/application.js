// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(function() {

  var parser = function(text) {
    text = text.replace(/^([^\(]*)+/, '<span class="mixin-name">$1</span>');
    text = text.replace(/(:\s*)([^,\)]+)/g, '$1<span class="default-value">$2</span>');
    text = text.replace(/(\$([^:,\) ]+))/g, '<span class="variable-name">$1</span>');
    return text;
  };

  $(".table-mixins td.file > a").each(function() {
    var $this = $(this);
    $this.html(parser($this.html()));
  });
});
