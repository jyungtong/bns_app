# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	$('#event_timepicker .input-append').datetimepicker
		language: 'en',
		pick12HourFormat: true,
		pickDate: false
	$('#event_datepicker .input-append').datetimepicker
		language: 'en',
		pickTime: false
