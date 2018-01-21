var websocket;
      var connected = false;

      $(document).ready(init);

      function init() {
          document.getElementsByName("open")[0].disabled = true;
          document.getElementsByName("close")[0].disabled = true;
          if(!("WebSocket" in window)){
              $('#status').append('<p><span style="color: red;">websockets not supported </span></p>');
              $("#navigation").hide();
          } else {
              $('#status').append('<p><span style="color: green;">websockets supported </span></p>');
              connect();
          };
      };

      function connect() {
          //wsHost = window.location.hostname
          wsHost = 'ws://' + 'localhost' + ':8080/websocket';
          $('#connection').text('Connecting');
          websocket = $.bullet(wsHost);
          websocket.onopen = function(evt) { onOpen(evt) };
          websocket.onclose = function(evt) { onClose(evt) };
          websocket.onmessage = function(evt) { onMessage(evt) };
          websocket.onerror = function(evt) { onError(evt) };
          websocket.onheartbeat = function(evt) { onHeartbeat(evt) };
      };

      function disconnect() {
          websocket.close();
      };

      function onOpen(evt) {
          $('#connection').text('Connected');
          connected = true;
          document.getElementsByName("open")[0].disabled = true;
          document.getElementsByName("close")[0].disabled = false;
      };

      function onClose(evt) {
          $('#connection').text('Disconnected');
          connected = false;
          document.getElementsByName("open")[0].disabled = false;
          document.getElementsByName("close")[0].disabled = true;
      };

      function onMessage(evt) {
        showMessage(evt.data);
      };

      function onHeartbeat(evt) {
      };

      function sendTxt() {
          if(websocket.readyState == websocket.OPEN){
            txt = $("#message_text").val();
            websocket.send(txt);
            clearInput();
          } else {
              //
          };
      };

      function showMessage(txt) {
          var now = getTimeStamp();
          $("#msgs_last").text(now);
          $("#msgs").text(txt);
      };

      function clearInput(){
        inputBox = document.getElementById('message_text');
        inputBox.value = "";
        inputBox.focus();
      }

      function getTimeStamp() {
       var now = new Date();
       return ((now.getDate()) + '/' + (now.getMonth() + 1) + '/' + now.getFullYear() + " " + now.getHours() + ':'
                     + ((now.getMinutes() < 10) ? ("0" + now.getMinutes()) : (now.getMinutes())) + ':' + ((now.getSeconds() < 10) ? ("0" + now
                     .getSeconds()) : (now.getSeconds())));
      }
