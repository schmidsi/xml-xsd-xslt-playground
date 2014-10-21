(function() {
  google.maps.event.addDomListener(window, 'load', function() {
    var geocoder, index, map, person, props, _i, _len, _ref, _results;
    props = {
      center: new google.maps.LatLng(47.33693, 8.4576695),
      zoom: 9,
      mapTypId: google.maps.MapTypeId.ROADMAP
    };
    map = new google.maps.Map(document.getElementById('map'), props);
    geocoder = new google.maps.Geocoder();
    _ref = document.querySelectorAll('.person');
    _results = [];
    for (index = _i = 0, _len = _ref.length; _i < _len; index = ++_i) {
      person = _ref[index];
      if (person.dataset['location']) {
        _results.push((function(person) {
          var person_cache;
          person_cache = person;
          return geocoder.geocode({
            address: person.dataset['location']
          }, function(results, status) {
            var marker;
            if (status === google.maps.GeocoderStatus.OK) {
              marker = new google.maps.Marker({
                map: map,
                position: results[0].geometry.location
              });
              marker.person = person;
              return google.maps.event.addListener(marker, 'click', function() {
                var other, _j, _len1, _ref1, _results1;
                this.person.classList.add('highlight');
                _ref1 = document.querySelectorAll('.person');
                _results1 = [];
                for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
                  other = _ref1[_j];
                  if (other !== this.person) {
                    _results1.push(other.classList.remove('highlight'));
                  } else {
                    _results1.push(void 0);
                  }
                }
                return _results1;
              });
            }
          });
        })(person));
      } else {
        _results.push(void 0);
      }
    }
    return _results;
  });

}).call(this);
