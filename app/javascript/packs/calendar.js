import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import listPlugin from '@fullcalendar/list';

document.addEventListener('turbolinks:load', function() {
  console.log("動いてるよ");

  const calendarEl = document.getElementById('calendar');
  if (!calendarEl) return;

  const calendar = new Calendar(calendarEl, {
    plugins: [dayGridPlugin, listPlugin],
    initialView: window.innerWidth < 768 ? 'listMonth' : 'dayGridMonth',
    events: '/calendar.json',
    locale: 'ja',

    eventClick: function(info) {
      window.location.href = `/posts/${info.event.id}`;
    },

    windowResize: function(view) {
      if (window.innerWidth < 768) {
        calendar.changeView('listMonth');
      } else {
        calendar.changeView('dayGridMonth');
      }
    }
  });

  calendar.render();
});