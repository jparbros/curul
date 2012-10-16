window.Curul = {}
window.Curul.Editors = {
  Date: (args) ->
    scope = this;
    calendarOpen = false;
    
    @init = ->
      scope.input = $("<INPUT type=text class='editor-text' />")
      scope.input.appendTo(args.container)
      scope.input.focus().select()
      scope.input.datepicker({
        showOn: "button",
        buttonImageOnly: true,
        buttonImage: "/assets/admin/calendar.png",
        beforeShow: ->
          calendarOpen = true
          
        onClose: ->
          calendarOpen = false
        changeMonth: true,
        changeYear: true,
        yearRange: '1900:2000',
        dateFormat: 'yy-mm-dd'
      });

    @destroy = ->
      $.datepicker.dpDiv.stop(true, true)
      scope.input.datepicker("hide")
      scope.input.datepicker("destroy")
      scope.input.remove()

    @show = ->
      $.datepicker.dpDiv.stop(true, true).show() if calendarOpen

    @hide = ->
      $.datepicker.dpDiv.stop(true, true).hide() 

    @position = ->
      return if !calendarOpen
      
      $.datepicker.dpDiv
          .css("top", position.top + 30)
          .css("left", position.left);

    @focus = ->
      scope.input.focus();

    @loadValue = (item) ->
      scope.defaultValue = item[args.column.field];
      scope.input.val(scope.defaultValue);
      scope.input[0].defaultValue = scope.defaultValue;
      scope.input.select();

    @serializeValue = ->
      return scope.input.val();

    @applyValue = (item, state) ->
      item[args.column.field] = state;

    @isValueChanged = ->
      return (!(scope.input.val() == "" && scope.defaultValue == null)) && (scope.input.val() != scope.defaultValue);

    @validate = ->
      return {
        valid: true,
        msg: null
      };

    @init();
    return @
  
  SelectStates: (args) ->
    scope = this;
    
    @init = ->
      scope.input = $("<select/>").addClass('editor-text')
      scope.input.appendTo(args.container)
      _.each(Curul.Editors.states, (state) ->
        option = $('<option/>').val(state.id).html(state.name)
        scope.input.append(option);
      );
      scope.input.focus().select()

    @destroy = ->
      scope.input.remove()

    @focus = ->
      scope.input.focus();

    @loadValue = (item) ->
      scope.defaultValue = item[args.column.field];
      scope.input.find("option[value=#{scope.defaultValue }]").attr('selected','selected')
      

    @serializeValue = ->
      return scope.input.val();

    @applyValue = (item, state) ->
      item[args.column.field] = state;

    @isValueChanged = ->
      return (!(scope.input.val() == "" && scope.defaultValue == null)) && (scope.input.val() != scope.defaultValue);

    @validate = ->
      return {
        valid: true,
        msg: null
      };

    @init();
    return @
  
  SelectPoliticalParty: (args) ->
    scope = this;
    
    @init = ->
      scope.input = $("<select/>").addClass('editor-text')
      scope.input.appendTo(args.container)
      _.each(Curul.Editors.political_parties, (political_party) ->
        option = $('<option/>').val(political_party.id).html(political_party.name)
        scope.input.append(option);
      );
      scope.input.focus().select()

    @destroy = ->
      scope.input.remove()

    @focus = ->
      scope.input.focus();

    @loadValue = (item) ->
      scope.defaultValue = item[args.column.field];
      scope.input.find("option[value=#{scope.defaultValue }]").attr('selected','selected')
      

    @serializeValue = ->
      return scope.input.val();

    @applyValue = (item, state) ->
      item[args.column.field] = state;

    @isValueChanged = ->
      return (!(scope.input.val() == "" && scope.defaultValue == null)) && (scope.input.val() != scope.defaultValue);

    @validate = ->
      return {
        valid: true,
        msg: null
      };

    @init();
    return @
    
  SelectElectionType: (args) ->
    scope = this;
    
    @init = ->
      scope.input = $("<select/>").addClass('editor-text')
      scope.input.appendTo(args.container)
      scope.input.append($('<option/>').val('Mayoría Relativa').html('Mayoría Relativa'))
      scope.input.append($('<option/>').val('Representación Proporcional').html('Representación Proporcional'))
      scope.input.focus().select()

    @destroy = ->
      scope.input.remove()

    @focus = ->
      scope.input.focus();

    @loadValue = (item) ->
      scope.defaultValue = item[args.column.field];
      scope.input.find("option[value='#{scope.defaultValue }']").attr('selected','selected')
      

    @serializeValue = ->
      return scope.input.val();

    @applyValue = (item, state) ->
      item[args.column.field] = state;

    @isValueChanged = ->
      return (!(scope.input.val() == "" && scope.defaultValue == null)) && (scope.input.val() != scope.defaultValue);

    @validate = ->
      return {
        valid: true,
        msg: null
      };

    @init();
    return @
    
  SelectGenereType: (args) ->
    scope = this;
    
    @init = ->
      scope.input = $("<select/>").addClass('editor-text')
      scope.input.appendTo(args.container)
      scope.input.append($('<option/>').val('f').html('Femenino'))
      scope.input.append($('<option/>').val('m').html('Masculino'))
      scope.input.focus().select()

    @destroy = ->
      scope.input.remove()

    @focus = ->
      scope.input.focus();

    @loadValue = (item) ->
      scope.defaultValue = item[args.column.field];
      scope.input.find("option[value='#{scope.defaultValue }']").attr('selected','selected')
      

    @serializeValue = ->
      return scope.input.val();

    @applyValue = (item, state) ->
      item[args.column.field] = state;

    @isValueChanged = ->
      return (!(scope.input.val() == "" && scope.defaultValue == null)) && (scope.input.val() != scope.defaultValue);

    @validate = ->
      return {
        valid: true,
        msg: null
      };

    @init();
    return @    

    
  SelectLegislature: (args) ->
    scope = this;
    
    @init = ->
      scope.input = $("<select/>").addClass('editor-text')
      scope.input.appendTo(args.container)
      _.each(Curul.Editors.legislatures, (legislature) ->
        option = $('<option/>').val(legislature.id).html(legislature.name)
        scope.input.append(option);
      );
      scope.input.focus().select()

    @destroy = ->
      scope.input.remove()

    @focus = ->
      scope.input.focus();

    @loadValue = (item) ->
      scope.defaultValue = item[args.column.field];
      scope.input.find("option[value='#{scope.defaultValue }']").attr('selected','selected')
      

    @serializeValue = ->
      return scope.input.val();

    @applyValue = (item, state) ->
      item[args.column.field] = state;

    @isValueChanged = ->
      return (!(scope.input.val() == "" && scope.defaultValue == null)) && (scope.input.val() != scope.defaultValue);

    @validate = ->
      return {
        valid: true,
        msg: null
      };

    @init();
    return @
}