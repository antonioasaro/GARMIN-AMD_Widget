using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Graphics as Gfx;
using Toybox.Communications as Comm;

class AMD_WidgetView extends Ui.View {
    var font;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        font = Ui.loadResource(Rez.Fonts.id_font);
        setLayout(Rez.Layouts.MainLayout(dc));
    
    	makeStockRequest();
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
    
    // Receive the stock price from the web
    function onStockReceive(responseCode, data) {
        Sys.println("Antonio - onStockReceive");
        var stockView = View.findDrawableById("id_stock");
        if (responseCode == 200) {
        	Sys.println("Stock response data: " + data);
           	var price = data["price"]; 
        	stockView.setText("$" + price);
        	stockView.setFont(font);
       		stockView.setColor(Gfx.COLOR_GREEN);
        } else {
           	Sys.println("Failed to load stocks\nError: " + responseCode.toString());
       		stockView.setColor(Gfx.COLOR_RED);
        }
        requestUpdate();
    }

    // Make the stock web request
    function makeStockRequest() {
        Sys.println("Antonio - makeStockRequest");
		Comm.makeWebRequest("http://www.asarotools.com/stockprice.php", {"stock" => "NYSE:AMD"}, {}, method(:onStockReceive));
    }
    

}
