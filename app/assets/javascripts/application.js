// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

var element = document.getElementById;
var bgcolor = '#B7C2CB';
var txtcolor = '#FFFFFF';

function showAll() {
  document.getElementById('allPosts').addEventListener("click", function(event) {
      event.preventDefault()
  });

  document.getElementById('verySpecific').style.display = 'none';
  document.getElementById('nonSpecific').style.display = 'block';
  document.getElementById('followingPosts').style.backgroundColor = 'rgba(0,0,0,0)';
  document.getElementById('followingPosts').style.text = '#000000';
  document.getElementById('allPosts').style.background = bgcolor;
  document.getElementById('allPosts').style.color = txtcolor;
}

function showFollowing() {
  document.getElementById('followingPosts').addEventListener("click", function(event){
      event.preventDefault()
  });

  document.getElementById('nonSpecific').style.display = 'none';
  document.getElementById('verySpecific').style.display = 'block';
  document.getElementById('allPosts').style.backgroundColor = 'rgba(0,0,0,0)';
  document.getElementById('allPosts').style.text = '#000000';
  document.getElementById('followingPosts').style.backgroundColor = bgcolor;
  document.getElementById('followingPosts').style.color = txtcolor;
}
