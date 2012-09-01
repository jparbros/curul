window.GoogleMaps = {
  initialize : ->
    @map = new google.maps.Map(document.getElementById('map_canvas'))
    @widget = $('#widget')
    @repTemplate = $('#representative-template')
    klass = @
    $('#back-link a').click( (event) ->
      event.preventDefault()
      klass.renderNational()
    )
    $('#show-profile #close').live('click', (event) ->
      event.preventDefault();
      $('#show-profile').fadeOut('slow').html('');
    )
    $('#error-message #close').live('click', (event) ->
      event.preventDefault();
      $('#error-message').fadeOut('slow').find('#content').html('');
    )

  fullScreen: ->
    @widget.removeClass('mix')

  mixScreen: ->
    @widget.addClass('mix')

  defaults: {
    zoom: 5,
    panControl: false,
    zoomControl: false,
    scaleControl: false,
    mapTypeControl: false,
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    streetViewControl: false,
    styles: [
      {
        "featureType":"administrative",
        "elementType":"labels",
        "stylers":[
          {
            "visibility":"off"
          }
        ]
      },
      {
        "featureType":"road",
        "stylers":[
          {
            "visibility":"off"
          }
        ]
      },
      {
        "featureType":"poi",
        "stylers":[
          {
            "visibility":"off"
          }
        ]
      },
      {
        "featureType":"water",
        "elementType":"labels",
        "stylers":[
          {
            "visibility":"off"
          }
        ]
      },
      {
        "featureType": "landscape",
        "elementType": "geometry",
        "stylers": [
          { "visibility": "on" },
          { "color": "#ffffff" }
        ]
      }
    ]
  },

  colors: ['#d8e4be','#d6d1c5','#b7e1e1','#2a04a','#512561','#f6e294','#a6cdd1','#a89eab',
           '#ffcc33','#80adcc','#e2a04a','#9cbc5b','#ed6d1c5','#e18383','#ffcc33','#99cccc',
           '#b7e1e1','#99cccc','#512561','#f6e294','#d8e4be','#a89eab','#80adcc','#efeae4',
           '#9cbc5b','#b7e1e1','#efeae4','#e18383','#a6cdd1','#80adcc','#99cccc','#d6d1c5']

  myLatlng: ->
    new google.maps.LatLng(@center[1], @center[0])

  renderNational: ->
    $('#back-link, #state-name').hide()
    @loadGeo('nacional')

  renderState: (state)->
    $('#back-link, #state-name').show()
    @loadGeo(state)

  setOptions: ->
    # @map.setCenter(@myLatlng())
    @map.setOptions(@defaults)

  paintChildren: ->
    klass = @
    _.each(@geo.features, (feature, index) ->
      feature.fillColor = klass.colors[index]
      feature.fillOpacity = '0.4';
      feature.strokeColor = '#666666';
      feature.strokeOpacity = 1;
      feature.strokeWidth = 1;
      feature.distric = klass.district
      feature.distric_id = feature.id if klass.district
      console.log(feature.name)
    )

  setData: (data) ->
    @center = data.state.centerLL
    @bbox = data.state.bboxLL
    @geo = if data.district then data.district else data.state
    @district = if data.district then true else false
    @setOptions()

  render: ->
    @fitBbox()
    @gonzo.setMap(null) if @gonzo
    @paintChildren()
    @polygonzo()

  renderRep: (rep) ->
    console.log(@repTemplate)
    templateHtml = @repTemplate.html()
    console.log(templateHtml)
    template = _.template(templateHtml)
    html = template(rep)
    $('#show-profile').html(html).show()

  renderError: (errorMessage) ->
    $('#error-message #content').html(errorMessage)
    $('#error-message').fadeIn('slow')

  loadGeo: (state)->
    klass = @
    $.ajax({
        url: "/maps_coords/#{state}.js",
        dataType: 'json',
        success: (data)->
          klass.setData data
          klass.render()
    })

  fitBbox: ->
    latLng1 = new google.maps.LatLng(@bbox[1], @bbox[0])
    latLng2 = new google.maps.LatLng(@bbox[3], @bbox[2])
    LatLngBounds = new google.maps.LatLngBounds(latLng1, latLng2)
    @map.fitBounds(LatLngBounds);

  loadRep: (state, district_id) ->
    klass = @
    $.ajax({
        url: "/api/representative/#{state}/#{district_id}",
        dataType: 'json',
        success: (data)->
          if data.error
            klass.renderError(data.error)
          else
            _.each(data, (rep) ->
              klass.renderRep rep
            )
    })

  polygonzo: ->
    klass = @
    @gonzo = new PolyGonzo.PgOverlay({map: @map, geo: @geo, events: {
                                            mousemove: ( event, where ) ->
                                              feature = where && where.feature
                                              return if( feature == mouseFeature )
                                              mouseFeature = feature;
                                              klass.map.setOptions({ draggableCursor: if feature then 'pointer' else null });

                                            click: (event, where) ->
                                              name = where.feature.name.toLowerCase()
                                              unless where.feature.distric
                                                klass.renderState(name.replace(/\s+/g, '_'))
                                                $('#state-name').html(name)
                                              else
                                                stateName = where.geo.name.toLowerCase().replace(/\s+/g, '_')
                                                klass.loadRep(stateName, where.feature.distric_id)
                                    }})
    @gonzo.setMap(@map)
}


