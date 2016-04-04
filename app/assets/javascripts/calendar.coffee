# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('#calendar').fullCalendar
    header:
      left: 'prev,next today',
      center: 'title',
      right: 'month,agendaWeek,agendaDay',
    defaultView: 'month',
    slotMinutes: 30,
    timeFormat: 'H:mm',

    viewRender: (view, element, end) -> 
      $.ajax({
        url: '/calendar/105',
        dataType: 'json',
        type:"get",
        success: (EventSource) ->
          $('#calendar').fullCalendar('removeEvents');
          $('#calendar').fullCalendar('addEventSource', EventSource);
      });
      
    eventDrop: (event, delta, minuteDelta, allDay, revertFunc) ->
      #if !confirm(event.title + "を" + event.start.format() + "に移動します")
       # revertFunc()
      eNt: (drag, event, allDay, revertFunc) ->
        $.ajax({
          url: '/calendar/1',
          type: 'patch'
          dataType: 'json'
          data:
            id: event.id
            start: event.start.format()
            allday: allDay
            drag: drag
          success: (json) ->
            calendar.fullCalendar 'updateEvent', event
            return
          error: ->
            revertFunc()
            return
        })