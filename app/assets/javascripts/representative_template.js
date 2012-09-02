<h2><%= name %></h2>
<div id="close"><a href="#">x</a></div>
<div class="left-column">
<img src="assets/<%= photo %>">
<p class="location">
representante de <%= region.name %>
</p>
<p>
<span>partido politico</span>
<img  src="<%= political_party.logo.thumb.url %>"><%= political_party.name %>
</p>

</div>
<div class="right-column">
<div class='container'>
<div class='left'>
<p>
<span>distrito</span>
<%= district %>
</p>
</div>
<div class='left'>
<p>
<span>circunscripción</span>
<%= circumscription %>
</p>
</div>
</div>
<p>
<span>email</span>
<%= email %>
</p>
<p>
<span>telefono</span>
<%= phone %>
</p>
<p>
<span>twitter</span>
<%= twitter %>
</p>
<p>
<span>suplente</span>
<%= substitute %>
</p>
<p>
<span>fecha de nacimiento</span>
<%= biography %>
</p>
<p>
<span>comisiones</span>
</p>
<p>
<span>biografia</span>
<%= biography %>
</p>
</div>
