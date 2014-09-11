// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
// Note: This example requires that you consent to location sharing when
// prompted by your browser. If you see a blank space instead of the map, this
// is probably because you have denied permission for location sharing.

var map;

// document.location;

function initialize() {
    var events = [];
    var markers = [];
    var mapOptions = {
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        zoom: 13
    };
    map = new google.maps.Map(document.getElementById('googleMap'), mapOptions);

    // var defaultBounds;// = new google.maps.LatLngBounds(
      // new google.maps.LatLng(-33.8902, 151.1759),
      // new google.maps.LatLng(-33.8474, 151.2631));
    // map.fitBounds(defaultBounds);

    // Try HTML5 geolocation
    if (window.events) {
        var i;
        for (i = 0; i < window.events.length; i++) {
            var pos = new google.maps.LatLng(window.events[i].lat,
                                           window.events[i].lon);
            var evt = new google.maps.Marker({
                position: pos,
                title:window.events[i].name
            });

            evt.setMap(map);
        }
    }

    if (navigator.geolocation) {

        navigator.geolocation.getCurrentPosition(function(position) {
        var pos = new google.maps.LatLng(position.coords.latitude,
                                       position.coords.longitude);



        var infowindow = new google.maps.InfoWindow({
            map: map,
            position: pos,
            content: 'Your Current Location'
        });

        document.locat = new google.maps.Marker({
            position: pos,
            title: "DRAG THIS OVER YOUR LOCATION",
            draggable: true
        });
        google.maps.event.addListener(document.locat, "dragend", function(event) {

           var point = document.locat.getPosition();
           document.getElementById("lon").value = event.latLng.lng();
           document.getElementById("lat").value = event.latLng.lat();
           console.log(event.latLng.lng().toFixed(6));

        });

        var marker = new google.maps.Marker({
            position: pos,
            title:"Your Current Location"
        });

        setInterval( function() {
            infowindow.close();
            marker.setMap(map);
            document.locat.setMap(map);

        }, 2250);

        map.setCenter(pos);
    }, function() {
        handleNoGeolocation(true);
    });
    } else {
        // Browser doesn't support Geolocation
        handleNoGeolocation(false);

        // Note:
        // whether geolocation is enabled or not,
        // we should display all the events in the database.
        // we should maket them markers
    }

    var input = /** @type {HTMLInputElement} */(document.getElementById('pac-input'));
    map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

    var searchBox = new google.maps.places.SearchBox(
    /** @type {HTMLInputElement} */(input));

    // Listen for the event fired when the user selects an item from the
    // pick list. Retrieve the matching places for that item.
    google.maps.event.addListener(searchBox, 'places_changed', function() {
        var places = searchBox.getPlaces();

        if (places.length == 0) {
            return;
        }
        for (var i = 0, marker; marker = markers[i]; i++) {
            marker.setMap(null);
        }

        // For each place, get the icon, place name, and location.
        markers = [];
        var bounds = new google.maps.LatLngBounds();
        for (var i = 0, place; place = places[i]; i++) {
            var image = {
                url: place.icon,
                size: new google.maps.Size(71, 71),
                origin: new google.maps.Point(0, 0),
                anchor: new google.maps.Point(17, 34),
                scaledSize: new google.maps.Size(25, 25)
            };

          // Create a marker for each place.
            var marker = new google.maps.Marker({
                map: map,
                icon: image,
                title: place.name,
                position: place.geometry.location
            });

            markers.push(marker);

            bounds.extend(place.geometry.location);
        }

        map.fitBounds(bounds);
    });

  // Bias the SearchBox results towards places that are within the bounds of the
  // current map's viewport.
    google.maps.event.addListener(map, 'bounds_changed', function() {
        var bounds = map.getBounds();
        searchBox.setBounds(bounds);
    });



}

function handleNoGeolocation(errorFlag) {
  if (errorFlag) {
    var content = 'Error: The Geolocation service failed.';
  } else {
    var content = 'Error: Your browser doesn\'t support geolocation.';
  }

  var options = {
    map: map,
    position: new google.maps.LatLng(60, 105),
    content: content
  };

  var infowindow = new google.maps.InfoWindow(options);
  map.setCenter(options.position);
}
google.maps.event.addDomListener(window, 'load', initialize);
