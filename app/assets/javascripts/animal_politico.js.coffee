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
      }
    ]
  },

  colors: ["#3595E6", "#9784E2", "#3D599A", "#9F203C", "#E6F3D9", "#0CCBC8", "#2ABD79",
  "#72E7F1", "#09A3AA", "#D22C61", "#3073B1", "#C3A08A", "#564B73", "#E8725B",
  "#F9C58C", "#5CC09E", "#A0F159", "#CC0972", "#A03A60", "#C59331", "#9604AA",
  "#692B8E", "#BC6C47", "#32350A", "#9D8A0B", "#8BAC70", "#98CC72", "#8415EE",
  "#D88A1D", "#0770CB", "#D180CD", "#818AC7"]

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
      feature.fillOpacity = '0.3';
      feature.strokeColor = '#666666';
      feature.strokeOpacity = 1;
      feature.strokeWidth = 1;
      feature.distric = klass.district
      feature.distric_id = feature.id if klass.district
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


