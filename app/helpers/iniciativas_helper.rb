module IniciativasHelper
  
  def temas(inicitiva)
    list = inicitiva.topics.collect {|topic| content_tag(:li, topic.name) }.join('')
    unsorted_list = content_tag(:ul, raw(list), :class => :temas)
    concat raw(unsorted_list)
  end
  
  def estado_de_iniciativa(iniciativa)
    list = []
    list << content_tag(:li, 'estado de la iniciativa')
    list << content_tag(:li, 'presentacion')
    list << content_tag(:li, 'comision')
    list << content_tag(:li, 'en pleno')
    list << content_tag(:li, 'proyecto')
    concat raw(content_tag(:ul, raw(list.join('')), :class => :estado))
  end
  
  def votacion_oficial(iniciativa)
    list = []
    list << content_tag(:li, 'votacion oficial')
    if iniciativa.official_voted?
      list << content_tag(:li, "a favor: #{iniciativa.official_percentage_up}%", :style => "width:#{iniciativa.official_pixel_votes_up}px", :class => 'a-favor')
      list << content_tag(:li, "en contra #{iniciativa.official_percentage_down}%", :style => "width:#{iniciativa.official_pixel_votes_down}px", :class => 'en-contra')
    else
      list << content_tag(:li, 'iniciativa no votada', :class => 'no-votada')
    end
    concat raw(content_tag(:ul, raw(list.join('')), :class => 'votacion-oficial'))
  end
  
  def votacion_local(iniciativa)
    list = []
    list << content_tag(:li, 'votacion en curul 501')
    list << content_tag(:li, :style => "#{(iniciativa.voted?)? "width:#{iniciativa.pixel_votes_up}px" : '' }", :class => "#{(iniciativa.voted?)? 'a-favor' : 'no-votada'}") do
      if cookies["voted_#{iniciativa.id}"]
        "a favor: #{iniciativa.percentage_votes_up}%"
      else
        link_to "a favor: #{iniciativa.percentage_votes_up}%", iniciativa_vote_up_path(iniciativa), :method => :post
      end
    end
    list << content_tag(:li, :style => "#{(iniciativa.voted?)? "width:#{iniciativa.pixel_votes_down}px" : '' }", :class => "#{(iniciativa.voted?)? 'en-contra' : 'no-votada'}") do
    if cookies["voted_#{iniciativa.id}"]
      "en contra #{iniciativa.percentage_votes_down}%"
    else
      link_to "en contra #{iniciativa.percentage_votes_down}%", iniciativa_vote_down_path(iniciativa), :method => :post
    end
    end
    concat raw(content_tag(:ul, raw(list.join('')), :class => 'votacion-local'))
  end
end
