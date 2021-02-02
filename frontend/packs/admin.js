import JQuery from 'jquery';
window.$ = window.JQuery = JQuery;

import "../../node_modules/bootstrap-datepicker/dist/js/bootstrap-datepicker"
$(document).ready(function() {
  $('input[rel=date]').datepicker({format: 'dd.mm.yyyy'});
})

import "bootstrap/js/src/index"

import "../stylesheets/admin.scss"
