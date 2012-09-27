$(document).ready(function(){
    
    // Line chart
    var d1 = [[0,8], [1,5], [2,3], [3,8], [4,5], [5,6], [6,12], [7,4], [8,8], [9,3], [10,1]];
    var d2 = [[0,3], [1,7], [2,4], [3,4], [4,6], [5,10], [6,6], [7,8], [8,2], [9,6], [10,9]];
    
    var plot = $.plot($("#line-chart"),
			   [ { data: d1, label: "Data 1", color: "#000000"}, { data: d2, label: "Data 2", color: "#0B689F"} ], {
				   series: {
					   lines: { show: true, fill: true, fillColor: { colors: [ { opacity: 0.05 }, { opacity: 0.15 } ] } },
					   points: { show: true }
				   },
				   legend: { position: 'nw'},
				   grid: { hoverable: true, clickable: true, borderColor: '#ccc', borderWidth: 1, labelMargin: 10 },
				   yaxis: { min: 0, max: 15 }
				 });
   
    
    // Pie Chart
    var data = [];
		var series = 5;
		for( var i = 0; i<series; i++) {
			data[i] = { label: "Series"+(i+1), data: Math.floor(Math.random()*100)+1 }
		}
		jQuery.plot(jQuery("#pie-chart"), data, {
				colors: ['#000000','#0B689F','#2A9EDD','#64BBEA','#85B6D1'],		   
				series: {
					pie: { show: true }
				}
		});
        
    // Bar graph
    var d2 = [];
		for (var i = 0; i <= 10; i += 1)
			d2.push([i, parseInt(Math.random() * 30)]);
			
		var stack = 0, bars = true, lines = false, steps = false;
		jQuery.plot(jQuery("#bar-chart"), [ d2 ], {
			series: {
				stack: stack,
				lines: { show: lines, fill: true, steps: steps },
				bars: { show: bars, barWidth: 0.6 }
			},
			grid: { hoverable: true, clickable: true, borderColor: '#ccc', borderWidth: 1, labelMargin: 10 },
			colors: ["#0B689F"]
		});
    
    // Real-time chart

		// we use an inline data source in the example, usually data would
		// be fetched from a server
		var data = [], totalPoints = 150;
		function getRandomData() {
			if (data.length > 0)
				data = data.slice(1);
	
			// do a random walk
			while (data.length < totalPoints) {
				var prev = data.length > 0 ? data[data.length - 1] : 50;
				var y = prev + Math.random() * 10 - 5;
				if (y < 0)
					y = 0;
				if (y > 100)
					y = 100;
				data.push(y);
			}
	
			// zip the generated y values with the x values
			var res = [];
			for (var i = 0; i < data.length; ++i)
				res.push([i, data[i]])
			return res;
		}
        
        // setup control widget
		var updateInterval = 700;
		jQuery("#updateInterval").val(updateInterval).change(function () {
			var v = jQuery(this).val();
			if (v && !isNaN(+v)) {
				updateInterval = +v;
				if (updateInterval < 1)
					updateInterval = 1;
				if (updateInterval > 2000)
					updateInterval = 2000;
				jQuery(this).val("" + updateInterval);
			}
		});

		var plot = jQuery.plot(jQuery("#realtime-chart"), [ getRandomData() ], {
            colors: ["#0B689F"],
			series: { lines: { fill: true, fillColor: { colors: [ { opacity: 0.1 }, { opacity: 0.5 } ] } }, shadowSize: 0, }, // drawing is faster without shadows
			yaxis: { min: 0, max: 100 },
			grid: { borderColor: '#ddd', borderWidth: 1},		  
          
		});
	
		function update() {
			plot.setData([ getRandomData() ]);
			// since the axes don't change, we don't need to call plot.setupGrid()
			plot.draw();
			
			setTimeout(update, updateInterval);
		}
	
		update();
});