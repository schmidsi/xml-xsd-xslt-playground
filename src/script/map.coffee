google.maps.event.addDomListener window, 'load', ->
    props = 
        center:   new google.maps.LatLng(47.33693,8.4576695)
        zoom:     9
        mapTypId: google.maps.MapTypeId.ROADMAP

    map = new google.maps.Map( document.getElementById('map'), props )
    geocoder = new google.maps.Geocoder()

    for person, index in document.querySelectorAll('.person')
        if person.dataset['location']
            do (person) ->
                person_cache = person
                geocoder.geocode {address: person.dataset['location']}, (results, status) ->
                    if status is google.maps.GeocoderStatus.OK
                        marker = new google.maps.Marker
                            map: map
                            position: results[0].geometry.location
                        marker.person = person

                        google.maps.event.addListener marker, 'click', ->
                            this.person.classList.add('highlight')

                            for other in document.querySelectorAll('.person')
                                if other isnt this.person
                                    other.classList.remove('highlight')
